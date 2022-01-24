#pragma once
#include <QObject>

#include "LettersListViewModel.h"

class MainViewModel : public QObject
{
    Q_OBJECT
    Q_PROPERTY(LettersListViewModel *lettersList READ lettersList CONSTANT)

public:
    explicit MainViewModel(QObject *parent = nullptr);

    LettersListViewModel *lettersList();

    Q_INVOKABLE void popLetter();
    Q_INVOKABLE QChar getCurrentLetter();
    Q_INVOKABLE void generateLetters(int level);

private:
    std::unique_ptr<LettersListViewModel> m_lettersList;
};
