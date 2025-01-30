#include <iostream>
#include <chrono>
using namespace std;

void ClearUsingIndex(int Array[], int size);
void ClearUsingPointers(int *Array, int size);

static int Array[10000] =  {0};

int main()
{
	int size = 10000;

	auto start1 = chrono::high_resolution_clock::now();

        ClearUsingIndex(Array, size);

	auto end1 = chrono::high_resolution_clock::now();
	chrono::duration<double, milli> duration1 = end1 - start1;

	cout << "Elapsed Time Using Index: " << duration1.count() << " ms" << endl;

	auto start2 = chrono::high_resolution_clock::now();

        ClearUsingPointers(Array, size);

        auto end2 = chrono::high_resolution_clock::now();
        chrono::duration<double, milli> duration2 = end2 - start2;

        cout << "Elapsed Time Using Pointer: " << duration2.count() << " ms" << endl;
}

void ClearUsingIndex(int Array[], int size)
{
        int i;
        for (i = 0; i < size; i += 1)
        {
                Array[i] = 0;
        }
}

void ClearUsingPointers(int *Array, int size)
{
        int *p;
        for (p = &Array[0]; p < &Array[size]; p += 1)
        {
                *p = 0;
        }
}
