augmented_gear = {}

-------------------
---- Merlinic -----
-------------------

augmented_gear.Merlinic = {}
augmented_gear.Merlinic.Damage = {
}

augmented_gear.Merlinic.Burst = { 
}

augmented_gear.Merlinic.Accuracy = { 
}
augmented_gear.Herculean = {}
augmented_gear.Herculean.Refresh = {
}
augmented_gear.Herculean.TH = {
    legs={ name="Herculean Trousers", augments={'Pet: DEX+6','INT+6','"Treasure Hunter"+2','Mag. Acc.+11 "Mag.Atk.Bns."+11',}},
}

augmented_gear.Herculean.WSD = {}
augmented_gear.Herculean.WSD.STR = {
    head={ name="Herculean Helm", augments={'Accuracy+24','Weapon skill damage +4%','AGI+4','Attack+15',}},
    legs={ name="Herculean Trousers", augments={'Attack+29','Weapon skill damage +4%','DEX+7','Accuracy+4',}},
    feet={ name="Herculean Boots", augments={'Accuracy+23 Attack+23','Weapon skill damage +4%','STR+4','Accuracy+10',}},
}

augmented_gear.Herculean.WSD.MAB = {
    head=augmented_gear.Herculean.WSD.STR.head,
    legs={ name="Herculean Trousers", augments={'Rng.Atk.+14','STR+8','Weapon skill damage +5%','Mag. Acc.+13 "Mag.Atk.Bns."+13',}},
    feet={ name="Herculean Boots", augments={'Mag. Acc.+17 "Mag.Atk.Bns."+17','Weapon skill damage +4%','STR+6',}},
}

augmented_gear.Herculean.WSD.AGI = {
    head=augmented_gear.Herculean.WSD.STR.head,
    legs=augmented_gear.Herculean.WSD.MAB.legs,
}

augmented_gear.Herculean.CritDMG = {}
augmented_gear.Herculean.CritDMG.DEX = {
}

augmented_gear.Herculean.TA = {
    feet={ name="Herculean Boots", augments={'Accuracy+6 Attack+6','"Triple Atk."+3','DEX+7','Accuracy+15',}},
}
augmented_gear.Herculean.Phalanx = {
}

augmented_gear.Valorous = {}
augmented_gear.Valorous.TP = {
}

augmented_gear.Valorous.WSD = {}
augmented_gear.Valorous.WSD.VIT = {
}

augmented_gear.Chironic = {}
augmented_gear.Chironic.macc = {
    legs={ name="Chironic Hose", augments={'Mag. Acc.+23 "Mag.Atk.Bns."+23','MND+6','Mag. Acc.+13',}},
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
    head={ name="Adhemar Bonnet +1", augments=augments.Adhemar.HQ.A},
    body={ name="Adhemar Jacket +1", augments=augments.Adhemar.HQ.A},
    hands={ name="Adhemar Wristbands +1", augments=augments.Adhemar.HQ.A},
}
augmented_gear.Adhemar.Atk = {
    head=augmented_gear.Adhemar.Acc.head,
    body=augmented_gear.Adhemar.Acc.body,
    hands=augmented_gear.Adhemar.Acc.hands,
}
augmented_gear.Adhemar.D = {
    legs={ name="Adhemar Kecks +1", augments={'AGI+12','"Rapid Shot"+13','Enmity-6',}}, 
}
augmented_gear.Adhemar.Rng = {
    legs=augmented_gear.Adhemar.D.legs,
}
augmented_gear.Lustratio = {}
augments.Lustratio = {}
augments.Lustratio.NQ = {
}
augments.Lustratio.HQ = {
}
augmented_gear.Lustratio.STR = {
}
augmented_gear.Lustratio.DEX = {
}

augmented_gear.Kaykaus = {}
augments.Kaykaus = {}
augments.Kaykaus.HQ = {
    A = {'MP+80','MND+12','Mag. Acc.+20',},
    C = {'MP+80','Spell interruption rate down +12%','"Cure" spellcasting time -7%',},
}
augmented_gear.Kaykaus.B = {
    body={ name="Kaykaus Bliaut +1", augments=augments.Kaykaus.HQ.B},
}
augmented_gear.Kaykaus.C = {
    head={ name="Kaykaus Mitra +1", augments=augments.Kaykaus.HQ.C},
}
augmented_gear.Kaykaus.D = {
    feet={ name="Kaykaus Boots +1", augments={'Mag. Acc.+20','"Cure" potency +6%','"Fast Cast"+4',}},
}
