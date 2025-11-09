package dev.ivoencarnacao.multisport.entity;

import java.time.OffsetDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.hibernate.annotations.CreationTimestamp;
import org.hibernate.annotations.UpdateTimestamp;

import jakarta.persistence.CascadeType;
import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;

@Entity
@Table(name = "races")
public class Race {

  @Id
  @GeneratedValue(strategy = GenerationType.UUID)
  @Column(name = "race_id", updatable = false, nullable = false)
  private UUID raceId;

  @Column(name = "race_name", nullable = false)
  private String raceName;

  @Column(name = "race_distance")
  private Integer raceDistance;

  @CreationTimestamp
  @Column(name = "created_at", nullable = false, updatable = false)
  private OffsetDateTime createdAt;

  @UpdateTimestamp
  @Column(name = "updated_at", nullable = false)
  private OffsetDateTime updatedAt;

  @OneToMany(mappedBy = "race", cascade = CascadeType.ALL, orphanRemoval = true)
  private List<EventRace> eventRaces = new ArrayList<>();

  protected Race() {
  }

  public Race(String raceName, Integer raceDistance) {
    this.raceName = raceName;
    this.raceDistance = raceDistance;
  }

  public UUID getRaceId() {
    return raceId;
  }

  public void setRaceId(UUID raceId) {
    this.raceId = raceId;
  }

  public String getRaceName() {
    return raceName;
  }

  public void setRaceName(String raceName) {
    this.raceName = raceName;
  }

  public Integer getRaceDistance() {
    return raceDistance;
  }

  public void setRaceDistance(Integer raceDistance) {
    this.raceDistance = raceDistance;
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
