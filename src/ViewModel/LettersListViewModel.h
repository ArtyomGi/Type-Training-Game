#pragma once

#include <memory>

#include <QAbstractListModel>

class LettersListViewModel : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit LettersListViewModel(QObject *parent = nullptr);

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    Qt::ItemFlags flags(const QModelIndex &index) const override;
    bool removeRows(int row, int count, const QModelIndex &parent) override;

    int rowCount(const QModelIndex &parent) const override;
    QHash<int, QByteArray> roleNames() const override;

    QChar firstLetter() const;

    void pushLetter(const QChar letter);
    void popFront();
    void clear();

private:
    QList<QChar> m_letters;
};
