/*
Tyler Spring
3/2/23
Project 4
This is the symbols header file. Here is the added findDup function. This is used to find duplicate terms of an input file.
*/
template <typename T>
class Symbols
{
public:
	void insert(char* lexeme, T entry);
	bool find(char* lexeme, T& entry);
	bool findDup(char* lexeme, T& entry);
private:
	map<string, T> symbols;
};

template <typename T>
void Symbols<T>::insert(char* lexeme, T entry)
{
	string name(lexeme);
	symbols[name] = entry;
}

template <typename T>
bool Symbols<T>::find(char* lexeme, T& entry)
{
	string name(lexeme);
	typedef typename map<string, T>::iterator Iterator;
	Iterator iterator = symbols.find(name);
	bool found = iterator != symbols.end();
	if (found)
		entry = iterator->second;
	return found;
}
/* Added findDup function. Takes the same inputs as find function. It is nearly the same,
but adds the appendError call to display the error.*/
template <typename T>
bool Symbols<T>::findDup(char* lexeme, T& entry)
{
	string name(lexeme);
	typedef typename map<string, T>::iterator Iterator;
	Iterator iterator = symbols.find(name);
	bool found = iterator != symbols.end();
	if (found)
		appendError(GENERAL_SEMANTIC, "Duplicate variable error.");
		entry = iterator->second;
	return found;
}