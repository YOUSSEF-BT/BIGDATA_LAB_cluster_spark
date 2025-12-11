#!/bin/bash

echo "🚀 Démarrage du cluster Big Data..."
echo "======================================"

# Arrêter les anciens conteneurs
echo "1. Nettoyage des anciens conteneurs..."
docker-compose down 2>/dev/null

# Démarrer les nouveaux
echo "2. Démarrage du cluster..."
docker-compose up -d

# Attendre que les services soient prêts
echo "3. Attente du démarrage des services..."
sleep 15

# Vérification
echo "4. Vérification de l'état des services..."
docker-compose ps

echo ""
echo "✅ Cluster démarré avec succès !"
echo ""
echo "📡 Interfaces disponibles :"
echo "   Hadoop HDFS  : http://localhost:9870"
echo "   YARN RM      : http://localhost:8088"
echo "   Spark Master : http://localhost:8080"
echo ""
echo "🔧 Commandes utiles :"
echo "   Voir les logs : docker-compose logs -f"
echo "   Arrêter       : docker-compose down"
echo "   Scale workers : docker-compose up --scale spark-worker=3 -d"
