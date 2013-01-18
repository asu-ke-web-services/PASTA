/*
 * $Date: $
 * $Author: dcosta $
 * $Revision: $
 *
 * Copyright 2011,2012 the University of New Mexico.
 *
 * This work was supported by National Science Foundation Cooperative
 * Agreements #DEB-0832652 and #DEB-0936498.
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * http://www.apache.org/licenses/LICENSE-2.0.
 *
 * Unless required by applicable law or agreed to in writing,
 * software distributed under the License is distributed on an
 * "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND,
 * either express or implied. See the License for the specific
 * language governing permissions and limitations under the License.
 *
 */

package edu.lternet.pasta.portal.search;

import java.util.Arrays;
import java.util.List;

/**
 * Class that supports auto complete of LTER terms in a search
 * input dialog. 
 * 
 * @author dcosta
 *
 */
public class LTERTerms {
 
  /* 
   * For now we can hard-code the list. If we like this approach
   * to auto-complete, this array should be re-factored to be
   * read in from a file or from a web service.
   */
  public static String[] lterTerms = {
  "CTD",
  "aboveground biomass",
  "aboveground production",
  "abundance",
  "accretion",
  "accumulation",
  "acid neutralizing capacity",
  "acid rain",
  "acidic",
  "actinorhizal plants",
  "adaptation",
  "advection",
  "aerial imagery",
  "agriculture",
  "air",
  "air pollution",
  "air quality",
  "air temperature",
  "algae",
  "alkalinity",
  "allometry",
  "alpine",
  "aluminum",
  "amino acids",
  "ammonia",
  "ammonium",
  "amphibians",
  "analytical tools",
  "animals",
  "anions",
  "annual net primary production",
  "antimony",
  "ants",
  "aquatic",
  "aquatic ecosystems",
  "aquatic invertebrates",
  "arthropods",
  "ascomycetes",
  "atmosphere",
  "atmospheric deposition",
  "atmospheric pressure",
  "atmospheric processes",
  "atmospheric properties",
  "bacteria",
  "bacterial abundance",
  "bacterial production",
  "bark",
  "basidiomycetes",
  "basins",
  "bathymetry",
  "beetles",
  "belowground biomass",
  "benthic",
  "bicarbonate",
  "biodiversity",
  "biogeochemical processes",
  "biogeochemistry",
  "biogeography",
  "biological events",
  "biological processes",
  "biological substances",
  "biology",
  "biomass",
  "birds",
  "bogs",
  "boreal forests",
  "boron",
  "brackish water",
  "browsing",
  "bryophytes",
  "buildings",
  "bulk density",
  "bulk deposition",
  "burning",
  "cadmium",
  "calcium",
  "canopies",
  "canopy cover",
  "canopy gaps",
  "carbohydrates",
  "carbon",
  "carbon assimilatio",
  "carbon cycling",
  "carbon dioxide",
  "carbon fluxes",
  "carbon monoxide",
  "carbon to nitrogen ratio",
  "cations",
  "cellulose",
  "census",
  "cesium",
  "charcoal",
  "chemical properties",
  "chemistry",
  "chloride",
  "chlorine",
  "chlorophyll",
  "chlorophyll a",
  "chromium",
  "chronosequences",
  "clearcuts",
  "clearcutting",
  "climate",
  "climate change",
  "climatology",
  "coarse woody debris",
  "colonization",
  "communities",
  "community composition",
  "community dynamics",
  "community patterns",
  "community respiration",
  "community structure",
  "competition",
  "conductivity",
  "conservation",
  "consumers",
  "copper",
  "coral reefs",
  "corals",
  "cores",
  "crabs",
  "crayfishes",
  "crops",
  "crustaceans",
  "dataloggers",
  "decay rates",
  "decomposition",
  "defoliation",
  "demography",
  "dendrochronology",
  "dendrometer",
  "denitrification",
  "deposition",
  "depth",
  "desertification",
  "deserts",
  "detritus",
  "deuterium",
  "dew point",
  "diatoms",
  "digital elevation model",
  "dimensions",
  "discharge",
  "disciplines",
  "disease",
  "dispersal",
  "dispersion",
  "dissolved inorganic carbon",
  "dissolved nutrients",
  "dissolved organic carbon",
  "dissolved oxygen",
  "disturbance",
  "disturbance patterns",
  "disturbance properties",
  "disturbances",
  "diversity",
  "drainage",
  "droughts",
  "dry deposition",
  "dunes",
  "ecology",
  "ecosystem ecology",
  "ecosystem properties",
  "ecosystems",
  "eddy covariance",
  "electric exclusion",
  "electrical conductivity",
  "elements and compounds",
  "elevation",
  "emissions",
  "endangered species",
  "erosion",
  "estuaries",
  "estuarine",
  "evaporation",
  "evapotranspiration",
  "events",
  "evolution",
  "extinction",
  "fauna",
  "ferns",
  "fertilization",
  "fertilizer",
  "field methods",
  "fine roots",
  "fire severity",
  "fires",
  "fishes",
  "floodplain",
  "floods",
  "flowering",
  "flowers",
  "fluorescence",
  "fluoride",
  "fluorine",
  "fluxes",
  "foliage",
  "food webs",
  "forbs",
  "forest disturbance",
  "forest ecology",
  "forest ecosystems",
  "forest floor",
  "forests",
  "freshwater",
  "frost",
  "fungi",
  "gas flux",
  "gases",
  "gastropods",
  "genetics",
  "geographic information systems",
  "geography",
  "geological processes",
  "geology",
  "geomorphology",
  "germination",
  "global positioning system",
  "grasses",
  "grasshoppers",
  "grasslands",
  "grazing",
  "groundwater",
  "growth",
  "habitat",
  "habitat selection",
  "habitats",
  "harvesting",
  "heat flux",
  "herbivores",
  "herbivory",
  "herbs",
  "hillslopes",
  "history",
  "holocene",
  "human disturbance",
  "humans",
  "humic soils",
  "humidity",
  "hurricane damage",
  "hurricanes",
  "hydraulic conductance",
  "hydrogen ions",
  "hydrography",
  "hydrologic processes",
  "hydrological properties",
  "hydrology",
  "hyporheic",
  "hyporheic zone",
  "ice",
  "imagery",
  "incubation",
  "infiltration",
  "inorganic matter",
  "inorganic nutrients",
  "insects",
  "interception",
  "invasive species",
  "invertebrates",
  "ions",
  "iron",
  "irradiance",
  "irrigation",
  "isotopes",
  "lake level",
  "lakes",
  "land cover",
  "land use",
  "land use history",
  "landsat",
  "landscape change",
  "larvae",
  "lead",
  "leaf area",
  "leaf area index",
  "leaf decomposition",
  "leaf litter",
  "leaf nutrients",
  "leaves",
  "leucine",
  "lichens",
  "life history",
  "light",
  "lightning",
  "limnology",
  "litter",
  "litter decomposition",
  "litterbags",
  "litterfall",
  "liverworts",
  "lizards",
  "logs",
  "long term",
  "long term monitoring",
  "lysimeter",
  "macroalgae",
  "macrofauna",
  "macroinvertebrates",
  "magnesium",
  "mammals",
  "manganese",
  "mangroves",
  "mapping",
  "marine",
  "marshes",
  "mass balance",
  "maximum temperature",
  "meadows",
  "measurements",
  "mesic soils",
  "metabolism",
  "meteorology",
  "methane",
  "methods",
  "microarthropods",
  "microbes",
  "microbial activity",
  "microbial biomass",
  "microclimate",
  "mineralization",
  "minimum temperature",
  "mites",
  "modeling",
  "models",
  "mollusks",
  "monitoring",
  "montane",
  "moorings",
  "mortality",
  "mosses",
  "mowing",
  "mud",
  "mutation",
  "mycorrhizae",
  "natural selection",
  "nekton",
  "nematodes",
  "net primary production",
  "net primary productivity",
  "net radiation",
  "neutron probe",
  "nickel",
  "nitrate",
  "nitric acid",
  "nitrification",
  "nitrite",
  "nitrogen",
  "nitrogen compounds",
  "nitrogen content",
  "nitrogen cycling",
  "nitrogen deposition",
  "nitrogen fixation",
  "nitrogen mineralization",
  "nitrogen-15",
  "nitrous oxide",
  "normalized vegetation index",
  "nutrient cycles",
  "nutrient cycling",
  "nutrients",
  "ocean biogeochemistry",
  "ocean currents",
  "oceanography",
  "oceans",
  "old growth forests",
  "organic carbon",
  "organic layer",
  "organic matter",
  "organic nitrogen",
  "organisms",
  "organizational units",
  "oxygen",
  "ozone",
  "paleoecology",
  "paleolimnology",
  "parasitism",
  "peatland",
  "percent carbon",
  "percent nitrogen",
  "percent organic carbon",
  "periphyton",
  "permafrost",
  "permanent plots",
  "ph",
  "phaeophytin",
  "phaeopigments",
  "phenology",
  "phermones",
  "phosphate",
  "phosphorus",
  "photosynthesis",
  "photosynthetically active radiation",
  "physical processes",
  "physical properties",
  "physiological processes",
  "physiology",
  "phytoplankton",
  "pitfall traps",
  "plankton",
  "plant biomass",
  "plant communities",
  "plant cover",
  "plant ecology",
  "plant growth",
  "plant phenology",
  "plant physiology",
  "plant species",
  "plant species composition",
  "plants",
  "playa",
  "pollen",
  "pollution",
  "population and community properties",
  "population dynamics",
  "populations",
  "porewater",
  "porosity",
  "potassium",
  "precipitation",
  "predation",
  "predators",
  "primary production",
  "processes",
  "production",
  "productivity",
  "protozoa",
  "rabbits",
  "radiation",
  "rain",
  "recovery",
  "recruitment",
  "redox",
  "reflectance",
  "regeneration",
  "relative abundance",
  "relative humidity",
  "remote sensing",
  "reproduction",
  "reptiles",
  "respiration",
  "respiration rates",
  "restoration",
  "revegetation",
  "rhizosphere",
  "riparian",
  "rivers",
  "roads",
  "root decomposition",
  "roots",
  "rotifers",
  "runoff",
  "salamanders",
  "salinity",
  "salt marshes",
  "sand",
  "satellite imagery",
  "scattering",
  "scientific activities",
  "seasonality",
  "seawater",
  "secchi depth",
  "sedimentation",
  "sediments",
  "seed banks",
  "seed dispersal",
  "seedling establishment",
  "seedlings",
  "seeds",
  "seston",
  "shrews",
  "shrubs",
  "silica",
  "silicon",
  "silviculture",
  "simulation",
  "slugs",
  "small mammals",
  "snails",
  "snow",
  "snow accumulation",
  "snow depth",
  "snow temperature",
  "snow water equivalence",
  "snowfences",
  "sodium",
  "soil",
  "soil bulk density",
  "soil carbon",
  "soil chemistry",
  "soil disturbance",
  "soil horizons",
  "soil microarthropods",
  "soil moisture",
  "soil nutrients",
  "soil organic matter",
  "soil properties",
  "soil respiration",
  "soil solution chemistry",
  "soil temperature",
  "soil texture",
  "soil warming",
  "soil water",
  "soil water content",
  "solar radiation",
  "soluble reactive phosphorus",
  "spatial methods",
  "spatial properties",
  "spatial variability",
  "speciation",
  "species",
  "species composition",
  "species diversity",
  "species interactions",
  "species lists",
  "species richness",
  "specific conductivity",
  "specific leaf area",
  "spores",
  "stable isotopes",
  "stage height",
  "standing crop",
  "stems",
  "storms",
  "stream discharge",
  "stream ecology",
  "stream order",
  "streamflow",
  "streams",
  "strontium",
  "subsidence",
  "substances",
  "substrates",
  "succession",
  "successional dynamics",
  "sulfate",
  "sulfide",
  "sulfur",
  "sulfur hexafluoride",
  "surface elevation table",
  "surveys",
  "survival",
  "suspended solids",
  "symbiosis",
  "taxonomy",
  "temperature",
  "temporal properties",
  "termites",
  "terrestrial",
  "terrestrial ecosystems",
  "thaw depth",
  "thickness",
  "thinning",
  "throughfall",
  "tides",
  "timber harvest",
  "time domain reflectometry",
  "topography",
  "total nitrogen",
  "total organic carbon",
  "total phosphorus",
  "tracers",
  "transects",
  "translocation",
  "transpiration",
  "trapping",
  "tree growth",
  "tree mortality",
  "tree rings",
  "treeline",
  "trees",
  "trophic dynamics",
  "trophic structure",
  "trout",
  "tundra",
  "turbidity",
  "understory vegetation",
  "urban",
  "vapor pressure",
  "vegetation",
  "vegetation dynamics",
  "vertebrates",
  "viruses",
  "water",
  "water balance",
  "water chemistry",
  "water column",
  "water content",
  "water level",
  "water properties",
  "water quality",
  "water table",
  "water temperature",
  "watersheds",
  "weather",
  "wet deposition",
  "wetlands",
  "wildfires",
  "wind",
  "wind direction",
  "wind speed",
  "winter",
  "wood",
  "woody debris",
  "zinc",
  "zooplankton"
  };
  
  
  /**
   * Returns a string holding a newline-separated list of
   * <option> elements for use inside an HTML5 <datalist>
   * element. For example:
   * 
   *  <option value="CTD">
   *  <option value="aboveground biomass">
   *  <option value="aboveground production">
   *  <option value="abundance">
   * 
   * This is used to support auto-complete in the search
   * input box.
   * 
   * @return   a string of option elements
   */
  public static String getOptionsString() {
    String optionsString = null;
    StringBuffer stringBuffer = new StringBuffer("");
    
    List<String> termsList = Arrays.asList(lterTerms);
    for (String s : termsList) {
      stringBuffer.append("<option value=\"" + s + "\">\n");
    }
    
    optionsString = stringBuffer.toString();
    return optionsString;
  }

}
