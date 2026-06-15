/** Minimal shape needed to render a card in ShowcaseGrid */
export interface ShowcaseEvent {
  id: string;
  title: { da: string; en: string };
  url: string;
  dayLabel: string;
  monthLabel: { da: string; en: string };
  timeLocation: { da: string; en: string };
  discount?: { da: string; en: string };
  /** Far-future ISO date for recurring events that never expire */
  endISO: string;
}

export const meetup: ShowcaseEvent = {
  id: "meetup-copenhagen",
  title: {
    da: "Meetup på Lau's (Tidligere Café Kodan)",
    en: "Meetup at Lau's (formerly Café Kodan)",
  },
  url: "https://meetup.enogtyve.org",
  dayLabel: "21",
  monthLabel: { da: "HVER MD.", en: "MONTHLY" },
  timeLocation: {
    da: "Den 21. kl. 19:00 i hver måned · Falkoner Alle 24a, 2000 Frederiksberg",
    en: "21st, 7:00 p.m. every month · Falkoner Alle 24a, 2000 Frederiksberg",
  },
  endISO: "2099-12-31",
};

export interface Conference {
  id: string;
  name: string;
  /** ISO date string (YYYY-MM-DD) for the first day — used for filtering */
  startISO: string;
  /** ISO date string (YYYY-MM-DD) for the last day — past when this < today */
  endISO: string;
  url: string;
  /** Single day number shown in the ShowcaseGrid date block */
  dayLabel: string;
  monthLabel: { da: string; en: string };
  timeLocation: { da: string; en: string };
  discount?: { da: string; en: string };
  /** Konferencer page fields */
  image: string;
  location: string;
  description: string;
  linkLabel: string;
}

export const conferences: Conference[] = [
  {
    id: "oslofreedomforum-2027",
    name: "Oslo Freedom Forum",
    startISO: "2027-05-31",
    endISO: "2027-06-02",
    url: "https://oslofreedomforum.com/",
    dayLabel: "31",
    monthLabel: { da: "MAJ", en: "MAY" },
    timeLocation: {
      da: "31. maj–2. juni 2027 · Oslo, Norge",
      en: "31 May–2 June 2027 · Oslo, Norway",
    },
    image: "/images/logos/oslofreedomforum.svg",
    location: "Oslo, Norge",
    description:
      "Afholdes årligt i Oslo, hvor Bitcoin og financial freedom track fylder stadig mere i programmet. En konference med fokus på menneskerettigheder, frihed og teknologi – med Bitcoin som et centralt tema.",
    linkLabel: "Køb billet",
  },
  {
    id: "btcprague-2027",
    name: "BTCPrague",
    startISO: "2027-05-06",
    endISO: "2027-05-08",
    url: "https://btcprg.me/ENOGTYVE",
    dayLabel: "6",
    monthLabel: { da: "MAJ", en: "MAY" },
    timeLocation: {
      da: "6.–8. maj 2027 · Prag, Tjekkiet",
      en: "6–8 May 2027 · Prague, Czech Republic",
    },
    discount: {
      da: 'Spar 10% med rabatkoden "enogtyve"',
      en: 'Save 10% with code "enogtyve"',
    },
    image: "/images/logos/btcprague_w.png",
    location: "Prag, Tjekkiet",
    description:
      "En super velorganiseret og rigtig god konference i Prag. Her kommer der 7.500–10.000 mennesker, og der er et bredt og tætpakket program, så man helt sikkert kan finde noget eller nogen, som beskæftiger sig med lige præcis det, du selv finder allermest interessant i og omkring Bitcoin. BTCPrague har også en stor palette af side-events, som kan anbefales.",
    linkLabel: "Køb billet",
  },
  {
    id: "btchel-2026",
    name: "BTCHEL",
    startISO: "2026-09-25",
    endISO: "2026-09-26",
    url: "https://btchel.com/",
    dayLabel: "25",
    monthLabel: { da: "SEP.", en: "SEP" },
    timeLocation: {
      da: "25.–26. september 2026 · Helsinki, Finland",
      en: "25–26 September 2026 · Helsinki, Finland",
    },
    discount: {
      da: 'Spar 10% med rabatkoden "enogtyve"',
      en: 'Save 10% with code "enogtyve"',
    },
    image: "/images/logos/btchel.png",
    location: "Helsinki, Finland",
    description:
      "BTCHEL 2025 var den første større Bitcoin-konference i Norden, og det var en stor succes. To dage med fokus på Bitcoin, fyldt med keynotes, paneler og workshops. Talere ved BTCHEL kommer fra hele verden, og der vil være et fokus på Bitcoin i de nordiske lande. Sørg for også at tjekke side-events ud og tilmeld dig i tide, da der ofte er stor interesse og begrænsede pladser.",
    linkLabel: "Køb billet",
  },
  {
    id: "bitcoincopenhagen-2026",
    name: "Bitcoin Copenhagen",
    startISO: "2026-03-21",
    endISO: "2026-03-21",
    url: "https://www.bitcoincopenhagen.dk",
    dayLabel: "21",
    monthLabel: { da: "MARTS", en: "MAR" },
    timeLocation: {
      da: "21. marts 2026 · København, Danmark",
      en: "21 March 2026 · Copenhagen, Denmark",
    },
    image: "/images/logos/btccph.png",
    location: "København, Danmark",
    description:
      "Afholdt 21. marts 2026. En dansk Bitcoin-konference – en endagsbegivenhed, som giver nysgerrige mulighed for at få et indblik i, hvad Bitcoin er, og hvilke udfordringer det kan være løsningen på. Vi håber, at konferencen er tilbage igen næste år.",
    linkLabel: "Se event",
  },
];
