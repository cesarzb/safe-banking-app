Bernard Cesarz 313 534

Aplikacja używa docker compose, ponieważ do jej uruchomienia używany jest kontener uruchamiający aplikację oraz osobny kontener z zawierający obraz selenium przeglądarki chrome.

Dockerfile:

![Dockerfile](./dockerfile.png)

docker-compose.yml:

![docker-compose.yml](./docker-compose.png)

Testy aplikacji odbywają się z użyciem frameworka minitest (domyślny dla frameworka Ruby on Rails). Wszystkie warstwy MVC są realizowane we frameworku Ruby on Rails (w celu uproszczenia procesu i uniknięcia dodawania kolejnych kontenerów do całej operacji).
Do testowania z użyciem selenium użyłem gema nazywającego się Capybara, który daje właśnie taką możliwość, poniżej znajdują pliki w których jest on konfigurowany. Plik test_helper konfiguruje, jak Capybara uruchomi aplikację, a plik application_system_test_case, jakiej przeglądarki użyje do przeprowadzenia testów, w tym przypadku jest to selenium uruchomione w osobnym kontenerze.

test_helper.rb:

![test_helper.rb](./test_helper.png)

application_system_test_case.rb:

![application_system_test_case.rb](./application_system_test_case.png)

W pliku posts_tests znajdują się testy widoków dla poszczególnych operacji CRUD.

posts_test.rb:

![posts_test 1](./posts_test_1.png)
![posts_test 2](./posts_test_2.png)

W zdalnym repozytorium Github ustawione są zasady chroniące branch main przed umieszczeniem na nim niepoprawnego kodu, które automatycznie uruchamiają workflow Github Actions, aby sprawdzić jego działanie przed umożliwieniem zcalenia go z główną gałęzią.

Zasady ochrony branch main:

![Branch protection](./branch_protection.png)

W celu przeprowadzenia zaawansowanych testów sprawdzających poprawność kodu do zcalenia użyty jest workflow Github Actions. Używając narzędzia docker-compose, ten plik stawia aplikację i uruchamia w niej testy, a w wypadku ich niepowodzenia używając odpowiedniego narzędzia, przesyła informację do Azure Devops, w celu utworzenia Work Item informującego o zaistniałym bugu.

Github Actions workflow:

![Github Actions workflow 1](./github_actions_workflow.png)
![Github Actions workflow 2](./github_actions_workflow_2.png)

Workflow nie działałby poprawnie bez zdefiniowania sekretów dla repozytorium Github, dlatego wygenerowane zostały sekrety uprawniające do wprowadzania zmian w repozytorium Github or projekcie Azure Devops.

Github secrets:

![Github secrets](./secrets.png)

Poniżej znajduje się komunikat dla przypadku, w którym scenariusz działania aplikacji oczekiwany przez testy (po celowej ingerencji), nie pokrywa się z faktycznym działaniem aplikacji.

Failed checks:

![Failed checks](./failed_checks.png)

W wyniku wykonania workflow w Github Actions został utworzony nowy work item w projekcie w Azure Devops.

Stworzony work item w Azure Devops:

![Azure Devops work item](./created_work_item.png)
