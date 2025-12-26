#include <iostream>
#include <cmath>
#include <vector>
#include <numbers>

using namespace std;

static double en3x(double x) {
    return exp(3 * x);
}

double calcAtan(double* x, int* N_steps) {
    double sum = 0.0;
    for (int n = 0; n < *N_steps; n++) {
        sum += pow(-1.0, n) * pow(*x / 2, 2 * n + 1) / (2 * n + 1);
    }
    return sum;
}

static double f_x(double* x, int* N_steps) {
    return en3x(*x) * calcAtan(x, N_steps);
}

int main() {
    int N_steps = 1000; //spremenimo natančnost racunanja Tylorjeve vrste 

    int n_vozlisc = 1000; //spreminjamo velikost koraka integriranja

    double h = (numbers::pi / 4) / n_vozlisc;

    vector<double> xx;
    for (double i = 0; i <= numbers::pi / 4; i += h) {
        xx.push_back(i);
    }

    double integral = 0.0;

    for (int i = 0; i < n_vozlisc; i++) {
        integral += f_x(&xx[i], &N_steps) + f_x(&xx[i + 1], &N_steps);
    }

    integral = integral * (h/2);

    cout << "Vrednost integrala je: " << integral << endl;
}