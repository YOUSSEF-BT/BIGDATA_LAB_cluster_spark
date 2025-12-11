# 📘 TP BIG DATA - Cluster Spark avec Docker, Hadoop, YARN et MongoDB Atlas

## 📋 Description
TP réalisé dans le cadre du cours de Big Data (Année Universitaire 2025-2026). 
Ce TP a pour objectif de mettre en place un cluster Big Data complet avec Docker, incluant Hadoop HDFS, YARN, Spark, et d'effectuer des analyses de données avec PySpark sur Google Colab avec intégration MongoDB Atlas.

## 🎯 Objectifs du TP
- ❖ Installer un cluster Spark avec Docker
- ❖ Exécuter des premiers exemples sur Apache Spark
- ❖ Installer PySpark sur Google Colab
- ❖ Charger et manipuler des données avec Spark
- ❖ Étude de cas : Intégration de Spark avec MongoDB Atlas
- ❖ Visualisation des résultats avec Matplotlib et Seaborn

---

## 📁 Structure du Projet
```
BIGDATA_LAB_cluster_spark/
├── README.md                           # Documentation principale
├── screenshots/                        # Captures d'écran des interfaces
│   ├── hadoop/hadoop.png              # Interface Hadoop HDFS
│   ├── yarn/Yarn.png                  # Interface YARN ResourceManager
│   └── spark/Spark.png                # Interface Spark Master
├── colab_notebooks/                    # Notebooks Google Colab
│   └── TP_Cluster_spark_colab.ipynb   # Notebook principal avec analyses
├── docker_config/                      # Fichiers de configuration Docker
│   ├── docker-compose.yml             # Configuration du cluster
│   ├── spark-defaults.conf            # Configuration Spark
│   └── start-scripts/                 # Scripts de démarrage
├── data/                               # Jeux de données utilisés
│   └── transactions.csv               # Données de transactions financières
├── scripts/                            # Scripts utilitaires
│   ├── start-cluster.sh               # Script de démarrage du cluster
│   └── submit-jobs.sh                 # Soumission de jobs Spark
├── examples/                           # Exemples de code
│   ├── wordcount.py                   # Exemple WordCount Python
│   ├── sparkpi.py                     # Calcul de Pi avec Spark
│   └── mongodb-integration.py         # Intégration MongoDB
└── documentation/                      # Documentation complémentaire
    └── lab_cluster_spark_25-26.pdf    # Énoncé du TP
```

---

## 📸 Captures d'écran des Interfaces

### 1. Interface Hadoop HDFS NameNode
![Hadoop HDFS Interface](screenshots/hadoop/hadoop.png)
*Interface web du NameNode montrant l'état du système de fichiers distribué HDFS*

### 2. Interface YARN ResourceManager
![YARN ResourceManager Interface](screenshots/yarn/Yarn.png)
*YARN gérant l'allocation des ressources CPU et mémoire sur le cluster*

### 3. Interface Spark Master
![Spark Master Interface](screenshots/spark/Spark.png)
*Spark Master avec les workers connectés et les applications en cours d'exécution*

---

## 🔬 Notebook Google Colab - Analyses PySpark avec MongoDB

### Notebook d'analyse disponible :
[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/YOUSSEF-BT/BIGDATA_LAB_cluster_spark/blob/main/colab_notebooks/TP_Cluster_spark_colab.ipynb)

### 📓 Contenu du Notebook Principal : `TP_Cluster_spark_colab.ipynb`

**Partie 1 : Installation et Configuration**
1. Installation d'Apache Spark et PySpark sur Colab
2. Configuration des variables d'environnement (JAVA_HOME, SPARK_HOME)
3. Démarrage d'une session Spark

**Partie 2 : Premiers Exemples avec Spark**
- Création de DataFrames simples
- Opérations de base (sélection, filtrage, schéma)
- Vérification de la version de Spark

**Partie 3 : Analyse de Données de Transactions Financières**
- Chargement de fichiers CSV
- Exploration et manipulation des données
- Filtrage des transactions supérieures à 1000€
- Calcul du montant total par type de transaction
- Tri des transactions par montant décroissant

**Partie 4 : Intégration avec MongoDB Atlas**
- Installation du connecteur MongoDB Spark
- Configuration de la connexion à MongoDB Atlas
- Chargement des transactions depuis MongoDB
- Analyses avancées avec les données MongoDB
- Utilisation de Spark SQL pour les requêtes

**Partie 5 : Visualisation des Résultats**
- Graphique barplot : Montant total des transactions par type
- Histogramme : Distribution des montants des transactions
- Comparaison des transactions réussies vs échouées
- Visualisations avec Seaborn et Matplotlib

---

## 🏗️ Architecture du Cluster Déployé

```
┌─────────────────────────────────────────┐
│          Cluster Docker (Local)         │
├─────────────────────────────────────────┤
│  ┌────────────┐  ┌────────────┐        │
│  │  Hadoop    │  │    YARN    │        │
│  │  NameNode  │  │ Resource   │        │
│  │  (HDFS)    │  │  Manager   │        │
│  │   :9870    │  │   :8088    │        │
│  └────────────┘  └────────────┘        │
│         │              │                │
│  ┌──────┴──────┐ ┌─────┴──────┐        │
│  │   Spark     │ │  Spark     │        │
│  │   Master    │ │  Workers   │        │
│  │   :8080     │ │ (x2)       │        │
│  └─────────────┘ └────────────┘        │
└─────────────────────────────────────────┘
         │
         ▼
┌─────────────────────────────────────────┐
│        Google Colab (Cloud)             │
│  ┌─────────────────────────────┐        │
│  │  Notebook PySpark           │        │
│  │  - Analyse de données       │        │
│  │  - Connexion MongoDB Atlas  │        │
│  │  - Visualisations           │        │
│  └─────────────────────────────┘        │
└─────────────────────────────────────────┘
         │
         ▼
┌─────────────────────────────────────────┐
│        MongoDB Atlas (Cloud)            │
│  ┌─────────────────────────────┐        │
│  │  Base de données            │        │
│  │  bankdb.transactions        │        │
│  │  Collections NoSQL          │        │
│  └─────────────────────────────┘        │
└─────────────────────────────────────────┘
```

---

## 🔧 Travail Réalisé

### Phase 1 : Installation du Cluster avec Docker
- **Docker Compose** : Configuration complète des services
- **Services déployés** :
  - Hadoop NameNode (port 9870)
  - YARN ResourceManager (port 8088)
  - Spark Master (port 8080)
  - 2x Spark Workers / YARN NodeManagers
  - 2x Hadoop DataNodes
- **Scripts de démarrage** : `start-hadoop.sh`, `start-spark.sh`

### Phase 2 : Configuration et Tests
- **Hadoop HDFS** : Configuration avec réplication (facteur 2)
- **YARN** : Allocation des ressources (mémoire, CPU)
- **Spark** : Intégration avec YARN comme cluster manager
- **Tests de fonctionnement** : Accès aux interfaces web, soumission de jobs

### Phase 3 : Premiers Exemples Spark
1. **SparkPi** : Calcul de π avec différentes valeurs
   ```bash
   spark-submit --class org.apache.spark.examples.SparkPi \
                --master local[*] \
                $SPARK_HOME/examples/jars/spark-examples_{version}.jar 100
   ```

2. **WordCount en Scala** : Comptage de mots dans un fichier texte
   ```scala
   val data = sc.textFile("hdfs://hadoop-master:9000/user/root/input/alice.txt")
   val count = data.flatMap(line => line.split(" "))
                   .map(word => (word, 1))
                   .reduceByKey(_+_)
   count.saveAsTextFile("hdfs://hadoop-master:9000/user/root/output/respark")
   ```

3. **WordCount en Python** : Version Python du comptage de mots
   ```python
   spark = SparkSession.builder.master("yarn").appName('wordcount').getOrCreate()
   data = spark.sparkContext.textFile("hdfs://hadoop-master:9000/user/root/input/alice.txt")
   words = data.flatMap(lambda line: line.split(" "))
   wordCounts = words.map(lambda word: (word, 1)).reduceByKey(lambda a,b:a +b)
   wordCounts.saveAsTextFile("hdfs://hadoop-master:9000/user/root/output/rr2")
   ```

### Phase 4 : Installation PySpark sur Google Colab
- **Installation des dépendances** : Java 8, Spark 3.2.1, PySpark
- **Configuration environnement** : Variables JAVA_HOME, SPARK_HOME
- **Initialisation Spark** : Utilisation de findspark pour l'initialisation
- **Session Spark** : Création d'une session avec configuration mémoire

### Phase 5 : Analyse de Données avec Spark
- **Chargement CSV** : Données de transactions financières
- **Manipulation DataFrames** : Filtrage, regroupement, tri
- **Transformations** : Opérations sur les colonnes, agrégations
- **Schéma** : Analyse de la structure des données

### Phase 6 : Intégration MongoDB Atlas (Étude de Cas)
- **Connecteur MongoDB Spark** : Installation et configuration
- **Connexion à MongoDB Atlas** : URI de connexion sécurisée
- **Chargement des données** : Lecture des collections MongoDB dans Spark
- **Analyses avec données MongoDB** :
  - Calcul du montant moyen des transactions par type
  - Identification des comptes avec plus de 5 transactions
  - Agrégations complexes avec Spark SQL
- **Configuration de sécurité** : Gestion des identifiants et permissions

### Phase 7 : Visualisation des Résultats
- **Graphiques avec Seaborn** : Barplots, histogrammes, comparaisons
- **Analyse statistique** : Distribution des montants, taux de réussite
- **Export des résultats** : Conversion Pandas pour visualisation
- **Dashboard** : Vue d'ensemble des transactions

### Phase 8 : Tests et Validation
- ✅ Accès aux interfaces web (Hadoop:9870, YARN:8088, Spark:8080)
- ✅ Communication entre tous les services Docker
- ✅ Soumission réussie de jobs Spark (SparkPi, WordCount)
- ✅ Connexion à MongoDB Atlas depuis Spark
- ✅ Lecture/écriture de données dans MongoDB
- ✅ Exécution complète du notebook sur Google Colab
- ✅ Génération des visualisations

---

## 📊 Commandes Principales Exécutées

### 1. Accès et Démarrage du Cluster
```bash
# Accéder au conteneur master
docker exec -it hadoop-master bash

# Démarrer Hadoop et YARN
./start-hadoop.sh
./start-spark.sh

# Vérifier les services
jps
```

### 2. Interfaces Web
- **YARN Web UI** : https://localhost:8088
- **Spark Web UI** : https://localhost:8080
- **Hadoop HDFS UI** : https://localhost:9870

### 3. Soumission de Jobs Spark
```bash
# Exemple SparkPi
spark-submit --class org.apache.spark.examples.SparkPi \
             --master yarn \
             $SPARK_HOME/examples/jars/spark-examples_*.jar 100

# WordCount Python
spark-submit --master yarn wordcount.py
```

### 4. Installation sur Google Colab
```python
# Installation des dépendances
!apt-get install openjdk-8-jdk-headless -qq > /dev/null
!wget -q https://dlcdn.apache.org/spark/spark-3.2.1/spark-3.2.1-bin-hadoop3.2.tgz
!tar xf spark-3.2.1-bin-hadoop3.2.tgz
!pip install -q findspark pyspark py4j pymongo matplotlib seaborn

# Configuration environnement
import os
os.environ["JAVA_HOME"] = "/usr/lib/jvm/java-8-openjdk-amd64"
os.environ["SPARK_HOME"] = "/content/spark-3.2.1-bin-hadoop3.2"
import findspark
findspark.init()

# Session Spark
from pyspark.sql import SparkSession
spark = SparkSession.builder \
    .appName("ColabSpark") \
    .config("spark.driver.memory", "2g") \
    .getOrCreate()
```

### 5. Intégration MongoDB Atlas
```python
# Configuration connexion MongoDB
mongo_uri = "mongodb+srv://<username>:<password>@cluster0.mongodb.net/bankdb.transactions?retryWrites=true&w=majority"

# Session Spark avec MongoDB
spark = SparkSession.builder \
    .appName("MongoDBIntegration") \
    .config("spark.mongodb.input.uri", mongo_uri) \
    .config("spark.mongodb.output.uri", mongo_uri) \
    .getOrCreate()

# Chargement des données depuis MongoDB
df_mongo = spark.read.format("mongo").option("uri", mongo_uri).load()
```

### 6. Arrêt du Cluster
```bash
# Arrêter les conteneurs
docker stop hadoop-master hadoop-slave1 hadoop-slave2

# Ou utiliser docker-compose
docker-compose down
```

---

## 🎓 Compétences Acquises

### Techniques
1. **Orchestration Docker** : Gestion de clusters multi-conteneurs
2. **Architecture Big Data** : Compréhension HDFS + YARN + Spark
3. **Spark Distributed Computing** : Traitement distribué de données
4. **PySpark Programming** : Développement d'applications Spark en Python
5. **MongoDB Integration** : Connexion Spark à bases de données NoSQL
6. **Data Visualization** : Création de graphiques avec Seaborn/Matplotlib
7. **Cloud Integration** : Utilisation de Google Colab et MongoDB Atlas

### Pratiques
- Configuration et optimisation de clusters Spark
- Débogage d'applications distribuées
- Gestion de la mémoire et des ressources
- Sécurisation des connexions aux bases de données
- Automatisation des déploiements avec Docker
- Analyse de performances des jobs Spark

---

## 🔗 Liens Utiles

### Documentation Officielle
- [Apache Spark Documentation](https://spark.apache.org/docs/latest/)
- [Hadoop Documentation](https://hadoop.apache.org/docs/current/)
- [YARN Documentation](https://hadoop.apache.org/docs/current/hadoop-yarn/hadoop-yarn-site/YARN.html)
- [MongoDB Spark Connector](https://www.mongodb.com/docs/spark-connector/current/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)

### Ressources du TP
- [Notebook Colab](https://colab.research.google.com/github/YOUSSEF-BT/BIGDATA_LAB_cluster_spark/blob/main/colab_notebooks/TP_Cluster_spark_colab.ipynb)
- [Énoncé du TP (PDF)](documentation/lab_cluster_spark_25-26.pdf)
- [Dépôt GitHub](https://github.com/YOUSSEF-BT/BIGDATA_LAB_cluster_spark)

---

## 👨‍💻 Auteur
**Youssef Bouzit**  
Étudiant en Data Science  
Année Universitaire 2025-2026

## 📧 Contact
- **GitHub** : [YOUSSEF-BT](https://github.com/YOUSSEF-BT)
- **Dépôt du TP** : [BIGDATA_LAB_cluster_spark](https://github.com/YOUSSEF-BT/BIGDATA_LAB_cluster_spark)
- **Notebook Colab** : [Lien Direct](https://colab.research.google.com/github/YOUSSEF-BT/BIGDATA_LAB_cluster_spark/blob/main/colab_notebooks/TP_Cluster_spark_colab.ipynb)

---

## 📄 Licence
Ce projet est disponible sous licence MIT. Voir le fichier LICENSE pour plus de détails.

---

*Ce TP a été réalisé dans le cadre du cours de Big Data (Année Universitaire 2025-2026) sous la supervision de Yasser El Madani El Alami.  
L'ensemble du code, configurations et documentations est ouvert et modifiable selon les termes de la licence MIT.*
