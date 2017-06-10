

        private void Q_Zero() // Q_0_PNN3
        {
            int MAX_PROBA = 10;
            int ACTION_NUMBER = 6;
            double epsilon = 0.005;

            int BOX_COUNT = test.LiczbaRekordow;
            double[] ACTIONS = { -1, -0.1, -0.01, 0.01, 0.1, 1 };

            double gamma = 0.95;    //współczynnik 
            double alpha = 0.01;    //współczynnik aktualizacji funkcji Q
            //double lambdaq = 0.7;   //współczynnik świeżości funkcji Q

            int l_klas = train.Klasy.Count;
            int l_cech = train.LiczbaCech;
            double[,] sc_min = new double[train.Klasy.Count, train.LiczbaCech];
            for (int i = 0; i < train.Klasy.Count; i++)
            {
                for (int j = 0; j < train.LiczbaCech; j++)
                {
                    sigma[i, j] = 1;
                    sc_min[i, j] = 1;
                }
            }

            //funkcja wartości akcji (wypełnione zerami)
            double[, , ,] Q = new double[BOX_COUNT, l_klas, l_cech, ACTION_NUMBER];
            //sygnał wzmocnienia (wypełnione zerami)
            double[, ,] r = new double[l_klas, l_cech, ACTION_NUMBER];
            //(wypełnione zerami)
            double[, ,] delta = new double[l_klas, l_cech, ACTION_NUMBER];

            double[,] SSE = new double[l_klas, l_cech];
            double[,] SSE_old = new double[l_klas, l_cech];

            double SSE_min = Test(); // Validate(test);

            //Inicjalizaja macierzy sc
            int l_iteracji_sc = 10; //czyli przeglądam zakres sc od 1 do 10 w celu poszukiwania wartości optymalnej
            double[] SSE_sc_vec_init = new double[l_iteracji_sc];

            for (int i = 0; i < l_iteracji_sc; i++)
            {
                for (int j = 0; j < train.Klasy.Count; j++)
                {
                    for (int k = 0; k < train.LiczbaCech; k++)
                    {
                        sigma[j, k] = i + 1;
                    }
                }
                //U Romka jest pnn_maciek_test_ncnk
                SSE_sc_vec_init[i] = Test(); // Validate(test);
            }
            double wart = SSE_sc_vec_init[0];
            int ind_wart = 0;
            for (int i = 1; i < l_iteracji_sc; i++)
            {
                if (SSE_sc_vec_init[i] < wart)
                {
                    wart = SSE_sc_vec_init[i];
                    ind_wart = i;
                }
            }
            double[,] sc_START = new double[train.Klasy.Count, train.LiczbaCech];
            for (int i = 0; i < train.Klasy.Count; i++)
            {
                for (int j = 0; j < train.LiczbaCech; j++)
                {
                    sc_START[i, j] = (double)(ind_wart + 1);
                    sigma[i, j] = sc_START[i, j];
                }
            }

            int l_Tc = test.LiczbaRekordow;
            int nextbox = Get_box_pnn1s(SSE_min, l_Tc);
            int box = nextbox;
            int BOX_START = nextbox;
            int krok = 0;

            double[, ,] SSE_test = new double[MAX_PROBA, l_klas, l_cech];
            double[, ,] sc_ = new double[MAX_PROBA, l_klas, l_cech];
            double[, , ,] r_ = new double[MAX_PROBA, l_klas, l_cech, ACTION_NUMBER];
            double[,] sc_old = new double[l_klas, l_cech];
            int[,] i_app_action = new int[l_klas, l_cech];
            double[] akcje_zach = new double[ACTION_NUMBER];

            int steps = 0;
            int box_old;
            double app_action;

            while (krok < MAX_PROBA)
            {
                box_old = box;
                box = nextbox;

                for (int i = 0; i < train.Klasy.Count; i++)     //Pętla po klasach
                {
                    for (int j = 0; j < train.LiczbaCech; j++)  //Pętla po cechach
                    {
                        double max_Q = Q[box, i, j, 0];
                        for (int n = 1; n < ACTION_NUMBER; n++)
                        {
                            if (Q[box, i, j, n] > max_Q)
                            {
                                max_Q = Q[box, i, j, n];
                            }
                        }
                        int ind_akcje_zach = 0;
                        for (int n = 0; n < ACTION_NUMBER; n++)
                        {
                            if (Q[box, i, j, n] == max_Q)
                            {
                                akcje_zach[ind_akcje_zach++] = ACTIONS[n];
                            }
                        }
                        double rand = (double)(randGen.Next(1, 100)) / 100.0;
                        int indeks_aplikowanej_akcji = -1;
                        if (rand > epsilon)
                        {
                            app_action = akcje_zach[randGen.Next(0, ind_akcje_zach)];
                        }
                        else
                        {
                            app_action = ACTIONS[randGen.Next(0, ACTION_NUMBER - 1)];
                        }
                        for (int n = 0; n < ACTION_NUMBER; n++)
                        {
                            if (ACTIONS[n] == app_action)
                            {
                                indeks_aplikowanej_akcji = n;
                                break;
                            }
                        }
                        i_app_action[i, j] = indeks_aplikowanej_akcji;

                        sc_old[i, j] = sigma[i, j];

                        sigma[i, j] = sigma[i, j] + app_action;
                        if (sigma[i, j] <= 0)
                        {
                            if (sc_old[i, j] == 0)
                            {
                                sigma[i, j] = sc_START[i, j];
                            }
                            else
                            {
                                sigma[i, j] = sc_old[i, j];
                            }
                        }

                        SSE_old[i, j] = SSE[i, j];

                        SSE[i, j] = Train();// Validate(train);

                        SSE_test[krok, i, j] = Test(); // Validate(test);

                        nextbox = Get_box_pnn1s(SSE[i, j], l_Tc);

                        if (krok != 1)
                        {
                            r[i, j, i_app_action[i, j]] = SSE_old[i, j] - SSE[i, j];
                        }
                        else
                        {
                            r[i, j, i_app_action[i, j]] = 0.0;
                        }

                        if (SSE[i, j] < SSE_min)
                        {
                            SSE_min = SSE[i, j];
                            sc_min[i, j] = sigma[i, j];
                        }

                        max_Q = Q[nextbox, i, j, 0];
                        for (int n = 1; n < ACTION_NUMBER; n++)
                        {
                            if (Q[box, i, j, n] > max_Q)
                            {
                                max_Q = Q[box, i, j, n];
                            }
                        }

                        delta[i, j, i_app_action[i, j]] = r[i, j, i_app_action[i, j]] + gamma * max_Q - Q[box, i, j, i_app_action[i, j]];
                    }  //Koniec pęti po cechach
                }  //Koniec pęti po klasach

                for (int i = 0; i < l_klas; i++)
                {
                    for (int j = 0; j < l_cech; j++)
                    {
                        sc_[krok, i, j] = sigma[i, j];
                        for (int n = 0; n < ACTION_NUMBER; n++)
                        {
                            r_[krok, i, j, n] = r[i, j, n];
                        }
                    }
                }

                krok++;

                for (int i = 0; i < l_klas; i++)
                {
                    for (int j = 0; j < l_cech; j++)
                    {
                        Q[box, i, j, i_app_action[i, j]] =
                            Q[box, i, j, i_app_action[i, j]] +
                            alpha * delta[i, j, i_app_action[i, j]];
                    }
                }

                steps++;
            }
            //Koniec pętli po MAX_PROBA
            testErrorVect = SSE_test[0, 0, 0];
            for (int k = 0; k < MAX_PROBA; k++)
            {
                for (int i = 0; i < train.Klasy.Count; i++)     //Pętla po klasach
                {
                    for (int j = 1; j < train.LiczbaCech; j++)  //Pętla po cechach
                    {
                        if (SSE_test[k, i, j] < testErrorVect)
                        {
                            testErrorVect = SSE_test[k, i, j];
                        }
                    }
                }
            }
        }        

        

        private int Get_box_pnn1s(double SSE, int l_Tc)
        {
            int box = 0;
            for (int i =1;i<=l_Tc;i++)
            {
                if ((SSE >= (double)(i - 1) / (double)(l_Tc)) && (SSE < (double)i / (double)(l_Tc)))
                {
                    box = box + (i - 1);
                    break;
                }
            }
            return box;
        }
