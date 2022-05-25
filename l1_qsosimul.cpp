#include <iostream>
#include <sstream>
#include <string>
#include <fstream>
#include <ctime>            // std::time
#include <cassert>
#include <cstdlib>

#include <gmpxx.h>
#include <boost/numeric/ublas/matrix.hpp>
#include <boost/numeric/ublas/vector.hpp>
#include <boost/numeric/ublas/io.hpp>

using namespace std;

#define myRealType mpq_class
#define myIntType mpz_class
#define myEnumType int
#define mySpaceType int


int main(int argc, char* argv[]){
    using namespace boost::numeric::ublas;
    myEnumType n=2;
    myEnumType N=1;
    myEnumType iter=0;
    myEnumType samp=0;
    //matrix<myRealType> Q1(3,3);
    //matrix<myRealType> Q2(3,3);
    //matrix<myRealType> Q3(3,3);
    //vector<myRealType> y(3);
    //vector<myRealType> currprob(3);
    //vector<myRealType> currprob1(3);
    matrix<myRealType> Q1(2,2);
    matrix<myRealType> Q2(2,2);
    vector<myRealType> y(2);
    vector<myRealType> currprob(2);
    vector<myRealType> currprob1(2);
    mySpaceType x=0;
    myRealType unifdraw=0.0;
    myRealType probcalc=0.0;
    
    y(0)=0.5;
    y(1)=0.5;
    
    Q1(1,1)=1;Q1(1,2)=0.5;Q1(2,1)=0.5;Q1(2,2)=1;
    Q2(1,1)=0;Q2(1,2)=0.5;Q2(2,1)=0.5;Q2(2,2)=0;
    

// setup the random number generator uniform on (-1,1) 
    unsigned int seed=static_cast<unsigned int>(std::time(0));        
    gmp_randclass r(gmp_randinit_default);         
//-------------------------------------------------------------    
    
    while(samp++ < N){
	currprob=y;
	while(iter++ < n){		    
            unifdraw = r.get_f();           // random number, 512 bits
	    x=0;
	    probcalc=currprob(x);
	    while(probcalc<=unifdraw){x++;probcalc+=currprob(x);}
	    currprob1[0]=inner_prod(currprob, prod(Q1,currprob));
	    currprob1[1]=inner_prod(currprob, prod(Q2,currprob));
//	    currprob1[2]=inner_prod(currprob, prod(Q3,currprob));
	    currprob=currprob1;
	    cout << x << " " << endl;
	}
        cout << endl;
    }
    

    return 0;
}

