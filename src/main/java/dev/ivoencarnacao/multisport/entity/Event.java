package dev.ivoencarnacao.multisport.entity;

import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.UniqueConstraint;

@Entity
@Table(name = "events", uniqueConstraints = {
    @UniqueConstraint(columnNames = { "event_name", "event_date" }) })
public class Event {

  @Id
  @GeneratedValue(strategy = GenerationType.UUID)
  @Column(name = "event_id", updatable = false, nullable = false)
  private UUID eventId;

  @Column(name = "event_edition")
  private Integer eventEdition;

  @Column(name = "event_name", nullable = false)
  private String eventName;

  @Column(name = "event_date", nullable = false)
  private OffsetDateTime eventDate;

  @Column(name = "event_website")
  private String eventWebsite;

  @Column(name = "event_has_expo")
  private Boolean eventHasExpo;

  @CreationTimestamp
  @Column(name = "created_at", nullable = false, updatable = false)
  private OffsetDateTime createdAt;

  @UpdateTimestamp
  @Column(name = "updated_at", nullable = false)
  private OffsetDateTime updatedAt;

  @OneToMany(mappedBy = "event", orphanRemoval = true)
  private List<EventRace> eventRaces = new ArrayList<>();

  protected Event() {
  }

  public Event(String eventName, OffsetDateTime eventDate) {
    this.eventName = eventName;
    this.eventDate = eventDate;
  }

  public UUID getEventId() {
    return eventId;
  }

  public void setEventId(UUID eventId) {
    this.eventId = eventId;
  }

  public Integer getEventEdition() {
    return eventEdition;
  }

  public void setEventEdition(Integer eventEdition) {
    this.eventEdition = eventEdition;
  }

  public String getEventName() {
    return eventName;
  }

  public void setEventName(String eventName) {
    this.eventName = eventName;
  }

  public OffsetDateTime getEventDate() {
    return eventDate;
  }

  public void setEventDate(OffsetDateTime eventDate) {
    this.eventDate = eventDate;
  }

  public String getEventWebsite() {
    return eventWebsite;
  }

  public void setEventWebsite(String eventWebsite) {
    this.eventWebsite = eventWebsite;
  }

  public Boolean getEventHasExpo() {
    return eventHasExpo;
  }

  public void setEventHasExpo(Boolean eventHasExpo) {
    this.eventHasExpo = eventHasExpo;
  }

  public OffsetDateTime getCreatedAt() {
    return createdAt;
  }

  public void setCreatedAt(OffsetDateTime createdAt) {
    this.createdAt = createdAt;
  }

  public OffsetDateTime getUpdatedAt() {
    return updatedAt;
  }

  public void setUpdatedAt(OffsetDateTime updatedAt) {
    this.updatedAt = updatedAt;
  }

  public List<EventRace> getEventRaces() {
    return eventRaces;
  }

  public void setEventRaces(List<EventRace> eventRaces) {
    this.eventRaces = eventRaces;
  }

}
