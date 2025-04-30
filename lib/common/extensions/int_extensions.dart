extension Genre on int {
  String getGenreFromNumber() {
    switch (this) {
      case 28:
        return 'Action';
      case 12:
        return 'Adventure';
      case 16:
        return 'Animation';
      case 35:
        return 'Comedy';
      case 80:
        return 'Crime';
      case 99:
        return 'Documentary';
      case 18:
        return 'Drama';
      case 10751:
      case 255:
        return 'Family';
      case 14:
        return 'Fantasy';
      case 36:
        return 'History';
      case 37:
        return 'Western';
      case 27:
        return 'Horror';
      case 10402:
      case 162:
        return 'Music';
      case 9648:
      case 176:
        return 'Mystery';
      case 10749:
      case 253:
        return 'Romance';
      case 878:
      case 110:
        return 'Science Fiction';
      case 10770:
      case 19:
        return 'TV Movie';
      case 53:
        return 'Thriller';
      case 10752:
      case 0:
        return 'War';
      default:
    }
    return '';
  }
}
