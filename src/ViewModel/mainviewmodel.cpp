#include "MainViewModel.h"

#include <random>
#include <vector>


MainViewModel::MainViewModel(QObject *parent)
    : QObject(parent), m_lettersList(std::make_unique<LettersListViewModel>())
{
}

LettersListViewModel *MainViewModel::lettersList()
{
    return m_lettersList.get();
}

void MainViewModel::popLetter()
{
    m_lettersList->popFront();
}

QChar MainViewModel::getCurrentLetter()
{
    return m_lettersList->firstLetter();
}

void MainViewModel::generateLetters(const int level)
{
    std::vector<char> letters;
    switch (level)
    {
    case 1:
        letters = { ' ', 'r', 'f', 'v', 'u', 'j', 'm' };
        break;

    case 2:
        letters = { ' ', 'r', 'f', 'v', 'u', 'j', 'm',
                    't', 'g', 'b', 'y', 'h', 'n' };
        break;

    case 3:
        letters = { ' ', 'r', 'f', 'v', 'u', 'j', 'm',
                    't', 'g', 'b', 'y', 'h', 'n',
                    'e', 'd', 'c', 'i', 'k' };
        break;

    case 4:
        letters = { ' ', 'r', 'f', 'v', 'u', 'j', 'm',
                    't', 'g', 'b', 'y', 'h', 'n',
                    'e', 'd', 'c', 'i', 'k',
                    'w', 's', 'x', 'o', 'l' };
        break;

    case 5:
        letters = { ' ', 'r', 'f', 'v', 'u', 'j', 'm',
                    't', 'g', 'b', 'y', 'h', 'n',
                    'e', 'd', 'c', 'i', 'k',
                    'w', 's', 'x', 'o', 'l',
                    'q', 'a', 'z', 'p' };
        break;

    default:
        break;
    }

    m_lettersList->clear();

    std::random_device rd;
    std::mt19937 gen(rd());
    std::uniform_int_distribution<> distrib(0, letters.size() - 1);

    for (int i = 0; i < 15; i++)
        m_lettersList->pushLetter(letters[distrib(gen)]);
}
