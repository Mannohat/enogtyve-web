import { defineCollection, z } from 'astro:content';

const blog = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    description: z.string(),
    pubDate: z.date(),
    author: z.string(),
    tags: z.array(z.string()).optional(),
    language: z.enum(['da', 'en']),
  }),
});

export const collections = { blog };

const videos = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    description: z.string(),
    embedUrl: z.string(),
    pubDate: z.date(),
    category: z.string(),
    tags: z.array(z.string()).optional(),
    language: z.enum(['da', 'en']),
  }),
});

const podcasts = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    description: z.string(),
    embedUrl: z.string(),
    pubDate: z.date(),
    tags: z.array(z.string()).optional(),
    language: z.enum(['da', 'en']),
  }),
});

const resources = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    description: z.string(),
    url: z.string().optional(),
    category: z.string(),
    tags: z.array(z.string()).optional(),
    language: z.enum(['da', 'en']),
  }),
});

const deals = defineCollection({
  type: 'content',
  schema: z.object({
    companyName: z.string(),
    description: z.string(),
    promoCode: z.string(),
    website: z.string(),
    logo: z.string().optional(),
    category: z.string(),
    language: z.enum(['da', 'en']),
  }),
});

const support = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    description: z.string(),
    language: z.enum(['da', 'en']),
  }),
});

export const collections = { blog, videos, podcasts, resources, deals, support };