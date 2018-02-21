import { Component, OnInit } from '@angular/core';
import { Book } from '../books/book';
import { BOOKS } from '../books/mock-book-service';


@Component({
  selector: 'app-books',
  templateUrl: './books.component.html',
  styleUrls: ['./books.component.css']
})
export class BooksComponent implements OnInit {
  
  selectedBook: Book;
  books = BOOKS;

  constructor() { }

  ngOnInit() {
  }

  onSelect(book: Book): void {
    this.selectedBook = book;
  }

}
