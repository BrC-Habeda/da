import re
from sqlalchemy import Column, Integer, String, ForeignKey, DateTime, func, UniqueConstraint
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
    
class Room(Base):
    __tablename__ = "rooms"
    
    id = Column(Integer, primary_key=True)
    room_number = Column(String, unique=True, nullable=False)
    
    #Define a relationship with the reservation table
    reservations = relationship('Reservation', back_populates='room')
    
class Reservation(Base):
    __tablename__ = 'reservations'
    
    id = Column(Integer, primary_key=True)
    guest_name = Column(String, nullable=False)
    check_in = Column(DateTime(timezone=True), default=func.now())
    check_out = Column(DateTime(timezone=True), nullable=False)
    
    # Foreign Key relationship to rooms
    room_id = Column(Integer, ForeignKey('rooms.id'))
    room = relationship('Room', back_populates='reservations')
    
    # Define an exclusion constraint to prevent overlapping reservations
    __table_args__ = (
        UniqueConstraint('room_id', 'check_in', 'check_out', name='unique_reservation'),
    )
