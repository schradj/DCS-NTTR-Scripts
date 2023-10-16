
do -- Airfield Approaches
route_NELLIS_APRCH_VMC_ARCOE_21 = {
  COORDINATE:NewFromLLDD(list_NavFixes["ARCOE"][1], list_NavFixes["ARCOE"][2]):SetAltitude(UTILS.FeetToMeters(15000),TRUE),
  COORDINATE:NewFromLLDD(list_NavFixes["APEX"][1], list_NavFixes["APEX"][2]):SetAltitude(UTILS.FeetToMeters(4500),TRUE)
}
end

do -- Airfield Depatures
route_NELLIS_DPRT_FYTTR_SIX_03 = {
  COORDINATE:NewFromLLDD(list_NavFixes["FLEX"][1],list_NavFixes["FLEX"][2]):SetAltitude(UTILS.FeetToMeters(6000),TRUE),
  COORDINATE:NewFromLLDD(list_NavFixes["FYTTR"][1],list_NavFixes["FYTTR"][2]):SetAltitude(UTILS.FeetToMeters(14000),TRUE)
}
end

do -- Transit Routes
route_XST_NTTR_RED_AIR_CORRIDOR_EGRESS = {
  COORDINATE:NewFromLLDD(list_NavFixes["BELTED_PEAK"][1],list_NavFixes["BELTED_PEAK"][2]),
  COORDINATE:NewFromLLDD(list_NavFixes["GARTH"][1],list_NavFixes["GARTH"][2]),
  COORDINATE:NewFromLLDD(list_NavFixes["FLUSH"][1],list_NavFixes["FLUSH"][2]),
  COORDINATE:NewFromLLDD(list_NavFixes["JAYSN"][1],list_NavFixes["JAYSN"][2]),
  COORDINATE:NewFromLLDD(list_NavFixes["STRYK"][1],list_NavFixes["STRYK"][2]),
  COORDINATE:NewFromLLDD(list_NavFixes["GASS_PEAK"][1],list_NavFixes["GASS_PEAK"][2])
}
route_XST_NTTR_RED_AIR_CORRIDOR_INGRESS = {
  COORDINATE:NewFromLLDD(list_NavFixes["FYTTR"][1],list_NavFixes["FYTTR"][2]),
  COORDINATE:NewFromLLDD(list_NavFixes["JAYSN"][1],list_NavFixes["JAYSN"][2]),
  COORDINATE:NewFromLLDD(list_NavFixes["FLUSH"][1],list_NavFixes["FLUSH"][2]),
  COORDINATE:NewFromLLDD(list_NavFixes["GARTH"][1],list_NavFixes["GARTH"][2]),
  COORDINATE:NewFromLLDD(list_NavFixes["BELTED_PEAK"][1],list_NavFixes["BELTED_PEAK"][2])
}

end

