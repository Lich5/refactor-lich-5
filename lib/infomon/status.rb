# API for char Status
# todo: should include jaws / condemn / others?

require "ostruct"

module Status
  def self.thorned? # added 2024-09-08
    heirarchy_thorns = /Wall of Thorns Poison (?:1|2|3|4|5)/
    (Infomon.get_bool("status.thorned") && Effects::Debuffs.active?(heirarchy_thorns))
  end

  def self.bound?
    Infomon.get_bool("status.bound") && (Effects::Debuffs.active?('Bind') || Effects::Debuffs.active?(214))
  end

  def self.calmed?
    Infomon.get_bool("status.calmed") && (Effects::Debuffs.active?('Calm') || Effects::Debuffs.active?(201))
  end

  def self.cutthroat?
    Infomon.get_bool("status.cutthroat") && Effects::Debuffs.active?('Major Bleed')
  end

  def self.silenced?
    Infomon.get_bool("status.silenced") && Effects::Debuffs.active?('Silenced')
  end

  def self.sleeping?
    Infomon.get_bool("status.sleeping") && (Effects::Debuffs.active?('Sleep') || Effects::Debuffs.active?(501))
  end

  # deprecate these in global_defs after warning, consider bringing other status maps over
  def self.webbed?
    XMLData.indicator['IconWEBBED'] == 'y'
  end

  def self.dead?
    XMLData.indicator['IconDEAD'] == 'y'
  end

  def self.stunned?
    XMLData.indicator['IconSTUNNED'] == 'y'
  end

  def self.muckled?
    return Status.webbed? || Status.dead? || Status.stunned? || Status.bound? || Status.sleeping?
  end

  # todo: does this serve a purpose?
  def self.serialize
    [self.bound?, self.calmed?, self.cutthroat?, self.silenced?, self.sleeping?]
  end
end
