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
    da: "Den 21. i hver måned · Falkoner Alle 24a, 2000 Frederiksberg",
    en: "21st every month · Falkoner Alle 24a, 2000 Frederiksberg",
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
  location: { da: string; en: string };
  description: { da: string; en: string };
  linkLabel: { da: string; en: string };
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
    image: "/images/logos/oslofreedomforum.png",
    location: { da: "Oslo, Norge", en: "Oslo, Norway" },
    description: {
      da: "Afholdes årligt i Oslo, hvor Bitcoin og financial freedom track fylder stadig mere i programmet. En konference med fokus på menneskerettigheder, frihed og teknologi – med Bitcoin som et centralt tema.",
      en: "Held annually in Oslo, where the Bitcoin and financial freedom track is taking up more and more of the program. A conference focused on human rights, freedom, and technology — with Bitcoin as a central theme.",
    },
    linkLabel: { da: "Køb billet", en: "Buy ticket" },
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
    location: { da: "Prag, Tjekkiet", en: "Prague, Czech Republic" },
    description: {
      da: "En super velorganiseret og rigtig god konference i Prag. Her kommer der 7.500–10.000 mennesker, og der er et bredt og tætpakket program, så man helt sikkert kan finde noget eller nogen, som beskæftiger sig med lige præcis det, du selv finder allermest interessant i og omkring Bitcoin. BTCPrague har også en stor palette af side-events, som kan anbefales.",
      en: "A very well-organized and really good conference in Prague. Around 7,500–10,000 people attend, and there's a broad, packed program, so you're sure to find something or someone working on exactly what you find most interesting in and around Bitcoin. BTCPrague also has a wide range of side events that are well worth checking out.",
    },
    linkLabel: { da: "Køb billet", en: "Buy ticket" },
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
    location: { da: "Helsinki, Finland", en: "Helsinki, Finland" },
    description: {
      da: "BTCHEL 2025 var den første større Bitcoin-konference i Norden, og det var en stor succes. To dage med fokus på Bitcoin, fyldt med keynotes, paneler og workshops. Talere ved BTCHEL kommer fra hele verden, og der vil være et fokus på Bitcoin i de nordiske lande. Sørg for også at tjekke side-events ud og tilmeld dig i tide, da der ofte er stor interesse og begrænsede pladser.",
      en: "BTCHEL 2025 was the first major Bitcoin conference in the Nordics, and it was a big success. Two days focused on Bitcoin, packed with keynotes, panels, and workshops. Speakers at BTCHEL come from all over the world, and there's a focus on Bitcoin in the Nordic countries. Be sure to also check out the side events and sign up in time, as there's often a lot of interest and limited spots.",
    },
    linkLabel: { da: "Køb billet", en: "Buy ticket" },
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
    location: { da: "København, Danmark", en: "Copenhagen, Denmark" },
    description: {
      da: "Afholdt 21. marts 2026. En dansk Bitcoin-konference – en endagsbegivenhed, som giver nysgerrige mulighed for at få et indblik i, hvad Bitcoin er, og hvilke udfordringer det kan være løsningen på. Vi håber, at konferencen er tilbage igen næste år.",
      en: "Held on 21 March 2026. A Danish Bitcoin conference — a one-day event that gives curious minds a chance to get an insight into what Bitcoin is and which challenges it can be the solution to. We hope the conference will be back again next year.",
    },
    linkLabel: { da: "Se event", en: "See event" },
  },
];

/** Conferences whose last day is today or later (drops past events). */
export function upcomingConferences(now: Date = new Date()): Conference[] {
  const today = new Date(now);
  today.setHours(0, 0, 0, 0);
  return conferences.filter((c) => new Date(c.endISO) >= today);
}

/**
 * schema.org Event JSON-LD for upcoming conferences only — past events are
 * excluded (Google flags expired events). Each Event includes image + address
 * so it is eligible for event rich results.
 */
export function conferenceEventSchema(
  lang: "da" | "en",
  origin = "https://enogtyve.org",
) {
  return {
    "@context": "https://schema.org",
    "@graph": upcomingConferences().map((conf) => ({
      "@type": "Event",
      "name": conf.name,
      "startDate": conf.startISO,
      "endDate": conf.endISO,
      "eventStatus": "https://schema.org/EventScheduled",
      "eventAttendanceMode": "https://schema.org/OfflineEventAttendanceMode",
      "image": [origin + conf.image],
      "location": {
        "@type": "Place",
        "name": conf.location[lang],
        "address": conf.location[lang],
      },
      "url": conf.url,
      "description": conf.description[lang],
    })),
  };
}
