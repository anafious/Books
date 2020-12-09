using { my.bookshop as my } from '../db/schema';
using { metadata as external} from './external/metadata.csn';
service CatalogService @(path:'/browse') {

  @readonly entity Books as SELECT from my.Books {*,
    author.name as author
  } excluding { createdBy, modifiedBy };

@readonly entity BusinessPartners as projection on external.A_BusinessPartner{
Key BusinessPartner as ID,
FirstName,
MiddleName,
LastName,
BusinessPartnerIsBlocked

};

  @requires_: 'authenticated-user'
  action submitOrder (book : Books.ID, amount: Integer);
}
