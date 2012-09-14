#include "testclass.h"
#include <iostream>

using namespace std;

Testclass::Testclass()
{
    TvShow fotc("Flight of the Conchords", 2, 4,"Comedy");
    TvShow breakbad("Breaking Bad", 3, 4, "Drama");
    TvShow docwho ("Doctor Who", 6, 4, "Science Fiction");
    TvShow lost ("Lost", 1, 1, "Mystery");
    TvShow bla;
    TvShow bla2("no name");

    TvShowData testcontainer;
    testcontainer.addShow(fotc);
    testcontainer.addShow(docwho);
    testcontainer.addShow(lost);
    testcontainer.addShow(bla);
    testcontainer.addShow(bla2);
    testcontainer.addShow(breakbad);

    cout << "Now containing: " << endl;
    cout << testcontainer.toString().toStdString() << endl;

    cout << "Removing doctor who and the empty 1 1 empty - show: " << endl;
    testcontainer.removeShow(docwho);
    testcontainer.removeShow(bla);

    cout << testcontainer.toString().toStdString() << endl;

    cout << "Sorting by Genre: " << endl;
    testcontainer.sortByGenre();
    cout << testcontainer.toString().toStdString() << endl;

    cout << "Sorting by Title: " << endl;
    testcontainer.sortByTitle();
    cout << testcontainer.toString().toStdString() << endl;

}
