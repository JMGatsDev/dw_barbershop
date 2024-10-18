class RepositoryException implements Exception {
  RepositoryException({
    required this.messages,
  });

  final String messages;
}
