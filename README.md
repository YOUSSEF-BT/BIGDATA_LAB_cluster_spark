# 🚀 TP BIG DATA - Cluster Hadoop, YARN & Spark avec Google Colab

## 📋 Description complète
Ce TP a pour objectif de mettre en place un cluster Big Data complet avec Docker, incluant Hadoop HDFS, YARN et Spark, et d'effectuer des analyses de données avec PySpark sur Google Colab.

## 📸 Captures d'écran des interfaces

### 1. Interface Hadoop HDFS NameNode
![Hadoop HDFS Interface](screenshots/hadoop/hadoop.png)
*Interface web du NameNode montrant l'état du système de fichiers distribué HDFS*

### 2. Interface YARN ResourceManager
![YARN ResourceManager Interface](screenshots/yarn/Yarn.png)
*YARN gérant l'allocation des ressources CPU et mémoire sur le cluster*

### 3. Interface Spark Master
![Spark Master Interface](screenshots/spark/Spark.png)
*Spark Master avec les workers connectés et les applications en cours d'exécution*

## 🔬 Partie Google Colab - Analyses PySpark

### Notebook d'analyse disponible :
[![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/YOUSSEF-BT/BIGDATA_LAB_cluster_spark/blob/main/colab_notebooks/TP_Cluster_spark_colab.ipynb)

### 📓 Notebook principal : `TP_Cluster_spark_colab.ipynb`

**Contenu du notebook :**
1. **Installation et configuration** de PySpark sur Google Colab
2. **Création de session Spark** pour le traitement distribué
3. **Analyse de données** de transactions financières
4. **Transformations Spark** : filtrage, agrégations, jointures
5. **Visualisation** des résultats avec Matplotlib/Seaborn

**Technologies utilisées :**
- PySpark 3.5.0
- Google Colab
- Pandas, Matplotlib, Seaborn
- Spark DataFrames

## 🏗️ Architecture du cluster déployé

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
│  │  - Visualisations           │        │
│  └─────────────────────────────┘        │
└─────────────────────────────────────────┘
```

## 🔧 Travail réalisé

### Phase 1 : Installation et configuration Docker
- **Docker Compose** : Définition des services (Hadoop, YARN, Spark)
- **Réseau** : Configuration de la communication entre conteneurs
- **Volumes** : Persistance des données HDFS
- **Services déployés** :
  - Hadoop NameNode (port 9870)
  - YARN ResourceManager (port 8088)  
  - Spark Master (port 8080)
  - 2x Spark Workers / YARN NodeManagers
  - 2x Hadoop DataNodes

### Phase 2 : Configuration des composants
- **Hadoop HDFS** : Configuration avec réplication (facteur 2)
- **YARN** : Allocation des ressources (mémoire, CPU)
- **Spark** : Intégration avec YARN comme gestionnaire de ressources
- **Environnement** : Variables d'environnement et fichiers de configuration

### Phase 3 : Analyses sur Google Colab
- **Installation PySpark** : Configuration sur l'environnement Colab
- **Session Spark** : Création et configuration
- **Traitement de données** : Opérations sur DataFrames Spark
- **Visualisation** : Génération de graphiques

### Phase 4 : Tests et validation
- ✅ Accès aux 3 interfaces web (Hadoop, YARN, Spark)
- ✅ Communication entre tous les services
- ✅ Soumission de jobs Spark sur YARN
- ✅ Exécution du notebook sur Colab
- ✅ Traitement et analyse de données

## 📊 Commandes exécutées

```bash
# 1. Démarrer le cluster
docker-compose up -d

# 2. Vérifier l'état des services
docker-compose ps

# 3. Tester Hadoop HDFS
hdfs dfsadmin -report
hdfs dfs -ls /

# 4. Tester YARN
yarn node -list
yarn application -list

# 5. Soumettre un job Spark
spark-submit --master yarn --deploy-mode cluster app.py

# 6. Accéder aux interfaces web
# Hadoop  : http://localhost:9870
# YARN    : http://localhost:8088  
# Spark   : http://localhost:8080

# 7. Arrêter le cluster
docker-compose down
```

## 📁 Structure du projet

```
BIGDATA_LAB_cluster_spark/
├── README.md                           # Documentation principale
├── docker-compose.yml                  # Configuration du cluster Docker
├── spark-defaults.conf                 # Configuration Spark
├── screenshots/                        # Captures d'écran
│   ├── hadoop/hadoop.png              # Interface Hadoop
│   ├── yarn/Yarn.png                  # Interface YARN
│   └── spark/Spark.png                # Interface Spark
├── colab_notebooks/                    # Notebooks Google Colab
│   └── TP_Cluster_spark_colab.ipynb   # Notebook principal PySpark
├── docker_config/                      # Fichiers de configuration avancés
├── notebooks/                          # Notebooks locaux
├── scripts/                            # Scripts utilitaires
│   └── start_cluster.sh               # Script de démarrage
├── data/                               # Jeux de données
└── .gitignore                         # Fichiers ignorés par Git
```

## ✅ Validation technique

| Service | Port | Statut | Commentaire |
|---------|------|--------|-------------|
| Hadoop NameNode | 9870 | ✅ Opérationnel | Interface HDFS accessible |
| YARN ResourceManager | 8088 | ✅ Opérationnel | Gestion des ressources active |
| Spark Master | 8080 | ✅ Opérationnel | 2 workers connectés |
| Hadoop DataNodes | 9864 | ✅ Opérationnel | 2 nodes disponibles |
| Spark History Server | 18080 | ✅ Opérationnel | Historique des jobs |

**Paramètres de configuration :**
- **Mémoire totale** : 4 GB RAM
- **Cœurs CPU** : 4
- **Stockage HDFS** : 100 GB (répliqué x2)
- **Facteur de réplication HDFS** : 2
- **Workers Spark** : 2 instances

## 🎓 Apprentissages et compétences acquises

### Techniques
1. **Orchestration Docker** : Gestion de clusters multi-conteneurs avec docker-compose
2. **Architecture Hadoop** : Compréhension de l'écosystème HDFS + YARN
3. **Spark sur YARN** : Exécution de jobs Spark via le gestionnaire de ressources YARN
4. **Traitement distribué** : Utilisation de PySpark pour l'analyse de données à grande échelle
5. **Monitoring** : Utilisation des interfaces web pour le suivi des services

### Pratiques
- Configuration réseau entre conteneurs Docker
- Allocation dynamique des ressources avec YARN
- Gestion des volumes persistants pour HDFS
- Débogage de services distribués
- Intégration entre environnement local (Docker) et cloud (Google Colab)

## 🚀 Démarrage rapide

### Pour le cluster Docker :
```bash
# Cloner le dépôt
git clone https://github.com/YOUSSEF-BT/BIGDATA_LAB_cluster_spark.git
cd BIGDATA_LAB_cluster_spark

# Démarrer le cluster
docker-compose up -d

# Accéder aux interfaces :
# - Hadoop:  http://localhost:9870
# - YARN:    http://localhost:8088
# - Spark:   http://localhost:8080
```

### Pour les analyses Colab :
1. Cliquez sur le badge [![Open In Colab]](https://colab.research.google.com/github/YOUSSEF-BT/BIGDATA_LAB_cluster_spark/blob/main/colab_notebooks/TP_Cluster_spark_colab.ipynb)
2. Exécutez les cellules du notebook dans l'ordre
3. Les résultats s'afficheront directement dans Colab

## 👨‍💻 Auteur
**Youssef Bouzit**  
Étudiant en Data Science  
Année universitaire 2025/2026

## 📧 Contact
- GitHub : [YOUSSEF-BT](https://github.com/YOUSSEF-BT)
- Dépôt du TP : [BIGDATA_LAB_cluster_spark](https://github.com/YOUSSEF-BT/BIGDATA_LAB_cluster_spark)

## 📄 Licence
Ce projet est disponible sous licence MIT. Voir le fichier LICENSE pour plus de détails.

---

*Ce TP a été réalisé dans le cadre du cours de Big Data.  
L'ensemble du code, configurations et documentations est ouvert et modifiable selon les termes de la licence MIT.*
