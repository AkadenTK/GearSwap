augmented_gear = {}

augmented_gear.Taeon = {}

augmented_gear.Taeon.Phalanx = {
    head={ name="Taeon Chapeau", augments={'Spell interruption rate down -10%','Phalanx +2',}},
    body={ name="Taeon Tabard", augments={'Spell interruption rate down -3%','Phalanx +3',}},
    hands={ name="Taeon Gloves", augments={'Spell interruption rate down -4%','Phalanx +3',}},
    feet={ name="Taeon Boots", augments={'Spell interruption rate down -9%','Phalanx +3',}},
}

augmented_gear.Taeon.SIRD = {
    head=augmented_gear.Taeon.Phalanx.head,
    body=augmented_gear.Taeon.Phalanx.body,
    hands=augmented_gear.Taeon.Phalanx.hands,
    feet=augmented_gear.Taeon.Phalanx.feet,
}

augmented_gear.Taeon.TP = {
    head={ name="Taeon Chapeau", augments={'Accuracy+23','"Triple Atk."+2',}},
    legs={ name="Taeon Tights", augments={'Accuracy+17 Attack+17','"Triple Atk."+2',}},
    feet={ name="Taeon Boots", augments={'Accuracy+24','"Triple Atk."+2',}},
}

augmented_gear.Taeon.Snapshot = {
    head={ name="Taeon Chapeau", augments={'"Snapshot" +5','"Snapshot" +5'}},
}

augmented_gear.Telchine = {}
augmented_gear.Telchine.Enhancing = {
    head = { name="Telchine Cap", augments={'Enh. Mag. eff. dur. +7',}},
}

-------------------
---- Merlinic -----
-------------------

augmented_gear.Merlinic = {}
augmented_gear.Merlinic.Damage = {
    head = { name="Merlinic Hood", augments={'Mag. Acc.+24 "Mag.Atk.Bns."+24','INT+8','Mag. Acc.+12','"Mag.Atk.Bns."+15',}},
    body = { name="Merlinic Jubbah", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','INT+2','Mag. Acc.+14','"Mag.Atk.Bns."+15',}},
    --hands= ,
    legs = { name="Merlinic Shalwar", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','"Conserve MP"+6','INT+1','"Mag.Atk.Bns."+13',}},
    feet = { name="Merlinic Crackows", augments={'Mag. Acc.+22 "Mag.Atk.Bns."+22','Magic burst dmg.+4%','Mag. Acc.+10','"Mag.Atk.Bns."+12',}},
}

augmented_gear.Merlinic.Burst = { 
    head={ name="Merlinic Hood", augments={'Mag. Acc.+20 "Mag.Atk.Bns."+20','Magic burst dmg.+4%','Mag. Acc.+8',}},
    body= augmented_gear.Merlinic.Damage.Body,
    --hands= ,
    legs={ name="Merlinic Shalwar", augments={'Mag. Acc.+25 "Mag.Atk.Bns."+25','Magic burst dmg.+4%','Mag. Acc.+10','"Mag.Atk.Bns."+5',}},
    feet= augmented_gear.Merlinic.Damage.Feet,
}

augmented_gear.Merlinic.Accuracy = { 
    head= augmented_gear.Merlinic.Damage.head,
    body= augmented_gear.Merlinic.Damage.Body,
    --hands= ,
    legs= augmented_gear.Merlinic.Damage.Legs,
    feet= augmented_gear.Merlinic.Damage.Feet,
}

augmented_gear.Merlinic.Pet = {}
augmented_gear.Merlinic.Pet.MAB = {
    hands={ name="Merlinic Dastanas", augments={'Pet: Mag. Acc.+16 Pet: "Mag.Atk.Bns."+16','Blood Pact Dmg.+8','Pet: DEX+4','Pet: "Mag.Atk.Bns."+5',}},
}
augmented_gear.Merlinic.Pet.Atk = {
    hands={ name="Merlinic Dastanas", augments={'Pet: Accuracy+28 Pet: Rng. Acc.+28','Blood Pact Dmg.+5','Pet: DEX+7','Pet: Mag. Acc.+10',}},
}


augmented_gear.Herculean = {}
augmented_gear.Herculean.Refresh = {
    hands={ name="Herculean Gloves", augments={'CHR+3','STR+1','"Refresh"+1',}},
    legs={ name="Herculean Trousers", augments={'Weapon skill damage +2%','"Store TP"+3','"Refresh"+2','Mag. Acc.+10 "Mag.Atk.Bns."+10',}},
    feet={ name="Herculean Boots", augments={'Attack+10','Weapon skill damage +2%','"Refresh"+2','Mag. Acc.+9 "Mag.Atk.Bns."+9',}},
}

augmented_gear.Herculean.WSD = {}
augmented_gear.Herculean.WSD.MAB = {
    hands={ name="Herculean Gloves", augments={'Pet: Accuracy+4 Pet: Rng. Acc.+4','"Dual Wield"+1','Weapon skill damage +8%','Mag. Acc.+12 "Mag.Atk.Bns."+12',}},
    head={ name="Herculean Helm", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Weapon skill damage +1%','MND+2','Mag. Acc.+3','"Mag.Atk.Bns."+10',}},
    legs={ name="Herculean Trousers", augments={'Mag. Acc.+19 "Mag.Atk.Bns."+19','Weapon skill damage +2%','STR+5','Mag. Acc.+11','"Mag.Atk.Bns."+11',}},
    feet={ name="Herculean Boots", augments={'"Mag.Atk.Bns."+24','Weapon skill damage +3%','INT+5','Mag. Acc.+13',}},
}

augmented_gear.Herculean.WSD.STR = {
    head={ name="Herculean Helm", augments={'Attack+27','Weapon skill damage +3%','STR+14','Accuracy+6',}},
    body={ name="Herculean Vest", augments={'Attack+13','Weapon skill damage +3%','STR+10','Accuracy+5',}},
    legs={ name="Herculean Trousers", augments={'Accuracy+16 Attack+16','Weapon skill damage +4%','STR+5','Attack+14',}},
    feet={ name="Herculean Boots", augments={'Accuracy+22 Attack+22','Weapon skill damage +4%','STR+9','Accuracy+9','Attack+12',}},
}

augmented_gear.Herculean.WSD.DEX = {
    body={ name="Herculean Vest", augments={'Accuracy+14 Attack+14','Weapon skill damage +2%','DEX+10',}},
}

augmented_gear.Herculean.WSD.AGI = {
    body={ name="Herculean Vest", augments={'Weapon skill damage +4%','STR+6','Rng.Acc.+13','Rng.Atk.+12',}},
    legs={ name="Herculean Trousers", augments={'Rng.Acc.+24 Rng.Atk.+24','Weapon skill damage +2%','AGI+7','Rng.Atk.+8',}},
    feet={ name="Herculean Boots", augments={'Rng.Atk.+24','Weapon skill damage +2%','AGI+6','Rng.Acc.+2',}},
}

augmented_gear.Herculean.CritDMG = {}
augmented_gear.Herculean.CritDMG.DEX = {
    legs={ name="Herculean Trousers", augments={'Accuracy+9','Crit. hit damage +3%','DEX+15','Attack+13',}},
}
augmented_gear.Herculean.CritDMG.STR = {
    feet={ name="Herculean Boots", augments={'Accuracy+10 Attack+10','Crit. hit damage +4%','STR+10',}},
}

augmented_gear.Herculean.TA = {
    feet={ name="Herculean Boots", augments={'Accuracy+28','"Triple Atk."+4','STR+3',}},
}
augmented_gear.Herculean.Phalanx = {
    legs={ name="Herculean Trousers", augments={'Enmity+1','"Mag.Atk.Bns."+19','Phalanx +4','Mag. Acc.+17 "Mag.Atk.Bns."+17',}},
}

augmented_gear.Herculean.FC = {
    legs={ name="Herculean Trousers", augments={'"Mag.Atk.Bns."+20','"Fast Cast"+4','STR+1',}},
    feet={ name="Herculean Boots", augments={'Mag. Acc.+3','"Fast Cast"+4','"Mag.Atk.Bns."+10',}},
}

augmented_gear.Herculean.TH = {
    hands={ name="Herculean Gloves", augments={'"Fast Cast"+3','INT+3','"Treasure Hunter"+2','Accuracy+10 Attack+10',}},
    feet={ name="Herculean Boots", augments={'Potency of "Cure" effect received+6%','Magic dmg. taken -4%','"Treasure Hunter"+1','Accuracy+17 Attack+17','Mag. Acc.+3 "Mag.Atk.Bns."+3',}},
}

augmented_gear.Valorous = {}
augmented_gear.Valorous.TP = {
    body="Valorous mail",
    feet={ name="Valorous Greaves", augments={'Accuracy+24 Attack+24','"Store TP"+4','DEX+9','Accuracy+8','Attack+5',}},
}

augmented_gear.Valorous.WSD = {}
augmented_gear.Valorous.WSD.VIT = {
    head="Valorous mask"
}

augmented_gear.Adhemar = {}
augments = {}
augments.Adhemar = {}
augments.Adhemar.NQ = {
    A = {'DEX+10','AGI+10','Accuracy+15',},
    B = {'STR+10','DEX+10','Attack+15',},
    C = {'AGI+10','Rng.Acc.+15','Rng.Atk.+15',},
}
augments.Adhemar.HQ = {
    A = {'DEX+12','AGI+12','Accuracy+20',},
    B = {'STR+12','DEX+12','Attack+20',},
    C = {'AGI+12','Rng.Acc.+20','Rng.Atk.+20',},
}
augmented_gear.Adhemar.Acc = {
    head={ name="Adhemar Bonnet", augments=augments.Adhemar.NQ.A},
    body={ name="Adhemar Jacket +1", augments=augments.Adhemar.HQ.B},
    hands={ name="Adhemar Wristbands +1", augments=augments.Adhemar.HQ.A},
}
augmented_gear.Adhemar.Atk = {
    head={ name="Adhemar Bonnet +1", augments=augments.Adhemar.HQ.B},
    body={ name="Adhemar Jacket +1", augments=augments.Adhemar.HQ.B},
    hands={ name="Adhemar Wristbands +1", augments=augments.Adhemar.HQ.B},
}
augmented_gear.Adhemar.Rng = {
    hands={ name="Adhemar Wristbands +1", augments=augments.Adhemar.HQ.C},
    legs={ name="Adhemar Kecks", augments=augments.Adhemar.NQ.C},
    feet={ name="Adhemar gamashes", augments=augments.Adhemar.NQ.D},
}
augmented_gear.Adhemar.D = {
    body={ name="Adhemar Jacket", augments={'HP+80','"Fast Cast"+7','Magic dmg. taken -3',}},
    legs={ name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}}, 
    feet={ name="Adhemar Gamashes", augments={'HP+50','"Store TP"+6','"Snapshot"+8',}},
}
augmented_gear.Lustratio = {}
augments.Lustratio = {}
augments.Lustratio.NQ = {
    A={'Attack+15','STR+5','"Dbl.Atk."+2',},
    B={'Accuracy+15','DEX+5','Crit. hit rate+2%',},
}
augments.Lustratio.HQ = {
    A={'Attack+20','STR+8','"Dbl.Atk."+3',},
    B={'Accuracy+20','DEX+8','Crit. hit rate+3%',},
}
augmented_gear.Lustratio.STR = {
    head={ name="Lustratio Cap +1", augments=augments.Lustratio.HQ.A},
    body={ name="Lustratio Harness +1", augments=augments.Lustratio.HQ.A},
}
augmented_gear.Lustratio.DEX = {
    head={ name="Lustratio Cap +1", augments=augments.Lustratio.HQ.B},
    legs={ name="Lustratio Subligar +1", augments=augments.Lustratio.HQ.B},
}
augmented_gear.Lustratio.D = {
    feet={ name="Lustratio Leggings +1", augments={'HP+65','STR+15','DEX+15',}},
}

augmented_gear.Ryuo = {}
augments.Ryuo = {}
augments.Ryuo.NQ = {
    A={'STR+10','DEX+10','Accuracy+15',},
}
augments.Ryuo.HQ = {
    A={'STR+12','DEX+12','Accuracy+20',},
}
augmented_gear.Ryuo.STR = {
    hands={ name="Ryuo Tekko +1", augments=augments.Ryuo.HQ.A},
}

augments.Apogee = {}
augments.Apogee.NQ = {
    A={'MP+60','Pet: "Mag.Atk.Bns."+30','Blood Pact Dmg.+7',},
    B={'MP+60','Pet: Attack+30','Blood Pact Dmg.+7',},
}
augments.Apogee.HQ = {
    A={'MP+80','Pet: "Mag.Atk.Bns."+35','Blood Pact Dmg.+8',},
    B={'MP+80','Pet: Attack+35','Blood Pact Dmg.+8',}
}
augmented_gear.Apogee = {}
augmented_gear.Apogee.Magic={
    head={ name="Apogee Crown", augments=augments.Apogee.NQ.A},
    legs={ name="Apogee Slacks", augments=augments.Apogee.NQ.A},
    feet={ name="Apogee Pumps", augments=augments.Apogee.NQ.A},
}
augmented_gear.Apogee.Physical = set_combine(augmented_gear.Apogee.Magic, {
    head={ name="Apogee Crown +1", augments=augments.Apogee.HQ.B},
    hands = { name= "Apogee Mitts", augments=augments.Apogee.NQ.B},
    feet = { name= "Apogee Pumps", augments=augments.Apogee.NQ.B},
})