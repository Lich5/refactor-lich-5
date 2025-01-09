# handles instances of modules that are game dependent

module Lich
  module Common
    module GameLoader
      def self.common_before
        require File.join(LIB_DIR, 'common', 'log.rb')
        require File.join(LIB_DIR, 'common', 'spell.rb')
        require File.join(LIB_DIR, 'util', 'util.rb')
      end

      def self.gemstone
        self.common_before
        require File.join(LIB_DIR, 'map', 'map_gs.rb')

        require File.join(LIB_DIR, 'gemstone', 'effects.rb')
        require File.join(LIB_DIR, 'gemstone', 'bounty.rb')
        require File.join(LIB_DIR, 'gemstone', 'claim.rb')
        require File.join(LIB_DIR, 'gemstone', 'infomon', 'infomon.rb')
        require File.join(LIB_DIR, 'attributes', 'resources.rb')
        require File.join(LIB_DIR, 'attributes', 'stats.rb')
        require File.join(LIB_DIR, 'attributes', 'spells.rb')
        require File.join(LIB_DIR, 'attributes', 'skills.rb')
        require File.join(LIB_DIR, 'attributes', 'society.rb')
        require File.join(LIB_DIR, 'gemstone', 'infomon', 'status.rb')
        require File.join(LIB_DIR, 'gemstone', 'experience.rb')
        require File.join(LIB_DIR, 'attributes', 'spellsong.rb')
        require File.join(LIB_DIR, 'gemstone', 'infomon', 'activespell.rb')
        require File.join(LIB_DIR, 'gemstone', 'psms.rb')
        require File.join(LIB_DIR, 'attributes', 'char.rb')
        require File.join(LIB_DIR, 'gemstone', 'infomon', 'currency.rb')
        require File.join(LIB_DIR, 'gemstone', 'character', 'disk.rb') # dup
        require File.join(LIB_DIR, 'gemstone', 'character', 'group.rb')
        require File.join(LIB_DIR, 'gemstone', 'critranks')
        self.common_after
      end

      def self.dragon_realms
        self.common_before
        require File.join(LIB_DIR, 'map', 'map_dr.rb')
        require File.join(LIB_DIR, 'attributes', 'char.rb')
        require File.join(LIB_DIR, 'DragonRealms', 'drinfomon', 'drinfomon.rb')
        require File.join(LIB_DIR, 'DragonRealms', 'commons', 'loader.rb')
        # self.common_after
      end

      def self.common_after
        ActiveSpell.watch!
        # nil
      end

      def self.load!
        sleep 0.1 while XMLData.game.nil? or XMLData.game.empty?
        return self.dragon_realms if XMLData.game =~ /DR/
        return self.gemstone if XMLData.game =~ /GS/
        echo "could not load game specifics for %s" % XMLData.game
      end
    end
  end
end