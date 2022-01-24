#include "LettersListViewModel.h"


LettersListViewModel::LettersListViewModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

QVariant LettersListViewModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    if (role == Qt::UserRole)
        return m_letters.at(index.row());

    return QVariant();
}

void LettersListViewModel::pushLetter(const QChar letter)
{
    int row = m_letters.size();

    beginInsertRows(QModelIndex(), row, row);
    m_letters.append(letter);
    endInsertRows();
}

void LettersListViewModel::popFront()
{
    if (m_letters.isEmpty())
        return;

    beginRemoveRows(QModelIndex(), 0, 0);
    m_letters.removeFirst();
    endRemoveRows();
}

void LettersListViewModel::clear()
{
    if (m_letters.isEmpty())
        return;

    beginRemoveRows(QModelIndex(), 0, m_letters.size());
    m_letters.clear();
    endRemoveRows();
}

Qt::ItemFlags LettersListViewModel::flags(const QModelIndex &index) const
{
    if (index.isValid())
        return (QAbstractListModel::flags(index)|Qt::ItemIsDragEnabled);

    return Qt::ItemIsDropEnabled;
}

bool LettersListViewModel::removeRows(int row, int count, const QModelIndex &parent)
{
    if (parent.isValid())
        return false;

    if (row >= static_cast<int>(m_letters.size()) || row + count <= 0)
        return false;

    int beginRow = qMax(0, row);
    int endRow = qMin(row + count - 1, static_cast<int>(m_letters.size() - 1));

    beginRemoveRows(parent, beginRow, endRow);

    while (beginRow <= endRow) {
        m_letters.removeAt(beginRow);
        ++beginRow;
    }

    endRemoveRows();

    return true;
}

int LettersListViewModel::rowCount(const QModelIndex &parent) const
{
    return parent.isValid() ? 0 : m_letters.size();
}

QHash<int, QByteArray> LettersListViewModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[Qt::UserRole] = "letter";
    return roles;
}

QChar LettersListViewModel::firstLetter() const
{
    return !m_letters.isEmpty() ? m_letters.first() : QChar();
}
