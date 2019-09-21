# Zadanie testowe 'Swift Trending Repos'
Wrzesień 2019  
<br> 

![](Screenshots.png)


## Treść zadania:
Zadanie polega na stworzeniu aplikacji która, korzystając z podanego niżej API wyświetli listę popularnych repozytoriów z serwisu GitHub.

Dokumentacja API: <https://github.com/huchenme/github-trending-api>

## Wymagania:
- ekran z listą repozytoriów Swift'owych popularnych w danym miesiącu
	- musi zawierać: avatar autora, nazwę autora, nazwę repozytorium, ilość gwiazdek
- możliwość wybrania danego repozytorium i wyświetlenie jego szczegółów w osobnym oknie
	- ekran powinien zawierać dodatkowo: opis, liczbę fork'ów, adres URL repo
	- klinknięcie w adres repozytorium odpala WebView

Forma prezentacji wymaganych danych jest dowolna, aplikacja nie musi (ale może) posiadać żadnych wodotrysków wizualnych.
**Głównej ocenie podlegać będzie architektura aplikacji.**

## Zastosowane technologie:
- Swift 5
- MVVM + Dependency Injection
- URLSession networking
- no Storyboards
- no Cocoa Pods
- image cache ( NSCache) + Codable
- custom Controller Presentation Transition

## Wykonano dodatkowo:
- dwa style wyświetlania listy z repozytoriami w oparciu o:
	- UITableView
	- UITableView + UICollectionView
- zapisywanie wybranego stylu (UserDefaults)
- cache plików graficznych avatarów
- customowy efekt prezentowania kolejnego kontrolera z wykorzystaniem UIViewControllerAnimatedTransitioning
- odświeżanie danych (UIRefreshControl)
