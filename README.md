# Test technique — API Événements

## Setup

```bash
make start
make setup
```

L'API est disponible sur https://localhost
Swagger UI : https://localhost/api

---

## Contexte

Tu rejoins une équipe qui a démarré une API de gestion d'événements. Le squelette est fonctionnel mais a été monté rapidement : il y a des problèmes de performance, d'architecture et de qualité de code.

L'API expose des événements (`Event`) liés à des catégories (`Category`).

---

## Ta mission

Auditer et améliorer cette API. Le code tourne, mais ne serait pas acceptable en production.

Tu es libre dans ton approche. Voici les axes sur lesquels on évaluera ton travail :

### Architecture & Code
- Le code est-il bien structuré ? Les responsabilités sont-elles bien découpées ?
- L'API est-elle correctement configurée ? (pagination, filtres, validation, sérialisation)
- Les opérations d'écriture (création, modification) sont-elles gérées proprement ?

### Performance
- Y a-t-il des problèmes de performance ? Comment les résoudre ?

### Qualité
- Des tests fonctionnels couvrent-ils les cas importants ?
- Le code passe-t-il les outils d'analyse statique ?

### Bonus
- Implémenter une commande console qui synchronise des événements depuis une source externe (API publique ou fichier CSV). La commande doit gérer l'idempotence et le reporting d'erreurs.
- Recherche full-text sur le titre et la description.

---

## Outils disponibles

| Outil | Commande |
|-------|----------|
| PHPStan | `make phpstan` |
| PHP-CS-Fixer | `make cs-check` / `make cs-fix` |
| Tests | `make test` |

---

## Critères d'évaluation

- Qualité et clarté du code (standards Symfony 7, typage strict)
- Choix d'architecture et justification
- Couverture de tests
- Historique git propre et messages clairs

---

## Livrable

- Lien vers le fork GitHub
- `NOTES.md` — Choix techniques, problèmes identifiés et solutions apportées
