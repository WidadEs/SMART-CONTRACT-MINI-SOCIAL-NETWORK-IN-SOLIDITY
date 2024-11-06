// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract MiniSocial {
    // Définition de la structure Post
    struct Post {
        string message;   // Message du post
        address author;   // Adresse de l'auteur
        uint timestamp;   // Timestamp du moment où le post a été créé
    }

    // Tableau dynamique pour stocker tous les posts
    Post[] private posts;

    // Événement pour notifier lorsqu'un post est publié
    event PostPublished(string message, address indexed author, uint timestamp);

    // Fonction pour publier un post
    function publishPost(string memory _message) public {
        require(bytes(_message).length > 0, "Le message ne peut pas etre vide");

        // Crée un nouveau post avec le message, l'adresse de l'auteur et le timestamp actuel
        Post memory newPost = Post({
            message: _message,
            author: msg.sender,
            timestamp: block.timestamp
        });

        // Ajoute le post au tableau de posts
        posts.push(newPost);

        // Émet l'événement pour signaler la publication du post
        emit PostPublished(_message, msg.sender, block.timestamp);
    }

    // Fonction pour consulter un post spécifique par index
    function getPost(uint index) public view returns (string memory, address, uint) {
        require(index < posts.length, "Index hors limite");
        
        Post storage post = posts[index];
        return (post.message, post.author, post.timestamp);
    }

    // Fonction pour récupérer tous les posts publiés et le nombre total de posts
    function getAllPosts() public view returns (Post[] memory, uint) {
        return (posts, posts.length);
    }
}
