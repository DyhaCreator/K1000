#include <iostream>
#include <fstream>
#include <vector>

using namespace std;

int share(vector<string>tokens,string link) {
    int ret = 0;
    for (int i = 0; i < tokens.size(); i++) {

        if (link + ":" == tokens[i]) {
            return ret;
        }
        ret++;
        if (tokens[i] == "lda" ||
            tokens[i] == "add" ||
            tokens[i] == "sub" ||
            tokens[i] == "jum") {
            i++;
        }
        else if (tokens[i] == "cop" ||
            tokens[i] == "jmp" ||
            tokens[i].back() == ':') {
            i += 2;
        }
        //cout << hex << ret << endl;
    }
    return 0;
}

vector<short> lexer(vector<string>tokens) {
    vector<short> byte;
    for (int i = 0; i < tokens.size(); i++) {
        cout << tokens[i] << endl;
        if (tokens[i] == "lda") {
            short a = 0b10100000;
            a += int(tokens[i + 1].at(1)) - 48;
            byte.push_back(a);
            i++;
        }
        else if (tokens[i] == "clc") {
            byte.push_back(0b10110000);
        }
        else if (tokens[i] == "push") {
            byte.push_back(0b00010000);
        }
        else if (tokens[i] =="pop") {
            byte.push_back(0b00100000);
        }
        else if (tokens[i] == "jum") {
            short a = 0b00110000;
            int ret = share(tokens, tokens[i + 1]);
            a += ret;
            byte.push_back(a);
            i++;
        }
        else if (tokens[i] == "cop") {
            if (tokens[i + 1] == "a") {
                if (tokens[i + 2] == "x") {
                    byte.push_back(0b01000000);
                }
                else if (tokens[i + 2] == "y") {
                    byte.push_back(0b01010000);
                }
            }
            else if (tokens[i + 1] == "x") {
                byte.push_back(0b01100000);
            }
            else if (tokens[i + 1] == "y") {
                byte.push_back(0b01110000);
            }
            i += 2;
        }
        else if (tokens[i] == "add") {
            short a = 0;
            if (tokens[i + 1] == "x") {
                a = 0b10000000;
            }
            else if (tokens[i + 1] == "y") {
                a = 0b10010000;
            }
            byte.push_back(a);
            i++;
            cout << byte.back() << endl;
        }
        else if (tokens[i] == "jmp") {
            short a;
            if (tokens[i + 1] == "a0") {
                a = 0b11000000;
            }
            else if (tokens[i + 1] == "c0") {
                a = 0b11010000;
            }
            else if (tokens[i + 1] == "a1") {
                a = 0b11100000;
            }
            else if (tokens[i + 1] == "c1") {
                a = 0b11110000;
            }
            int ret = share(tokens, tokens[i + 2]);
            a += ret;
            byte.push_back(a);
            i += 2;
        }
    }
    return byte;
}

int main()
{
    ifstream fin;
    fin.open("code.asm");

    string str = "";

    vector<string>tokens;

    while (fin >> str) {
        tokens.push_back(str);
    }

    vector<short>byteCode = lexer(tokens);

    ofstream fout;
    fout.open("ROM");

    for (int i = 0; i < byteCode.size(); i++) {
        char ch = byteCode[i];
        fout << ch;
    }

    system("pause");
}