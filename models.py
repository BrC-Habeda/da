import re
from sqlalchemy import Column, Integer, String, ForeignKey
from sqlalchemy.orm import validates
from sqlalchemy.orm import declarative_base, relationship


Base = declarative_base()


class KenyanPhoneNumber:
    def __init__(self, number):
        if not self.is_valid(number):
            raise ValueError("Invalid Phone Number")
        self.number = number

    def is_valid(self, number):
        pattern = re.compile(r"^\+2547[0-9]{8}$")
        return bool(pattern.match(number))


class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True)
    name = Column(String)

    addresses = relationship("Address", back_populates="user")


class Address(Base):
    __tablename__ = "addresses"

    id = Column(Integer, primary_key=True)
    email = Column(String)
    user_id = Column(Integer, ForeignKey("users.id"))
    _phone_number = Column("phone_number", String, nullable=False)

    @validates("_phone_number")
    def validate_phone_number(self, key, phone_number):
        return KenyanPhoneNumber(phone_number).number

    user = relationship("User", back_populates="addresses")
