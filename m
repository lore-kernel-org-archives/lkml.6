Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751591AbeEFJcb (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 05:32:31 -0400
Received: from mail1.bemta8.messagelabs.com ([216.82.243.203]:35806 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751041AbeEFJc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 05:32:29 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTe0wTWRTGvTPT6UjazTiInK1islWjoqBIYsa
  NMb5iZnE1xMR/ilGnONLRPshMMRjd+EBEXVCo2a5SVpAogQoxFqsUDQi+QUXFGDVGrfhAQFB2
  WRWM2ulU3Z2/ft/9vjnn3Jt7KZzZrjVQQrZTkOy81UhGEZbOIJbgbe01Ta96P4stOV5NsuUNF
  vbPbW1a9phvCdteX0Kyj6o/a9i6ow0Y2/1vBc7mng8QrGdHr4b1bNuL2KH3JeRcHXe+pw/nAj
  VejKutjOd83t0k5+t3abkrB4YI7u3zBwR3reyClqtt3cT5B+dwue9iuL99Y1N1Jo1oNzuyV2s
  slYNtZOYTQ3ZTmYfYijyj9qAoiqGfIXjUfoJQRTMCX1GtRhEEnY9D8NxZrersw6D+1U6kiocI
  rtzcT+5BwymSngxXe+7iCo+kU+BaZ1G4Fk4HCBgcOBwSFBVNp8Gx6xPVzAo45MlBKv8MJ0/na
  RQm6PGQV3E/vK4PZfzeckxtdgvBS3dH2BhOz4aLL/oJhREdB+6njzGFcToW/nIXhwsBTcORs2
  24yjHwquNTZN0IR5vqIxwHt0t/D+8G6EIN5L0dIFQjCS5XNeKq4Sah358TEacQ1BfnITUVDwO
  BA5jK6+Gg/02kHQt9Tx5HeCx4C4KE+nMVDp11H7WqMQaCLT2kci4MbYaaIbEQJRb/ZxcqT4Wy
  M/2kylOg4nA3Xhw+mhFw9eAzogwRXjRRFqQNgpSQnGiWxAyL08aL1oSk6WyiTZBlPkOw8mY5M
  d1h86HQTRwW+upQ46f5zehHCjPG6FNW9piYH8yONRstvGxZJWVZBbkZjaEoI+iXtvSamBGSkC
  FkrxWtoev81QZKZxypv6TYejmTt8lihmq1oGTKXZGfj1PVJ135OEPYHXbBEKs3KVFaiVqy7N8
  KfX0at1GcIVqPQqMxukxBsonO//tdKJZCxmh9ulJFJ9qd3/p1hUbBQqNE93Urozj575ZhK0qq
  XPRHYapt8U/e1PbWZZ64BTVRv34uXSZ0HF8w6U7ywiPSP6/vPNiwvtw1+lbgt4TTa1tXHEpeu
  Nw5TGtocKxal1Ua/2Hevo8aJjfY9HTGlkUfXP7N6UUTxo1f3Lf/xr20gl9WpgykOfZu2eF4Pm
  Pai7kzd3kNzpLNvaLrNdPVWFWQU/jQSMgWPikel2T+C6/a980VBAAA
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-8.tower-37.messagelabs.com!1525599146!99217316!1
X-Originating-IP: [104.232.225.2]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Huaisheng HS1 Ye <yehs1@lenovo.com>
To: Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@kernel.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "vbabka@suse.cz" <vbabka@suse.cz>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "pasha.tatashin@oracle.com" <pasha.tatashin@oracle.com>,
        "alexander.levin@verizon.com" <alexander.levin@verizon.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "penguin-kernel@I-love.SAKURA.ne.jp"
        <penguin-kernel@I-love.SAKURA.ne.jp>,
        "colyli@suse.de" <colyli@suse.de>, NingTing Cheng <chengnt@lenovo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [External]  Re: [PATCH 2/3] include/linux/gfp.h: use unsigned int
 in gfp_zone
Thread-Topic: [External]  Re: [PATCH 2/3] include/linux/gfp.h: use unsigned
 int in gfp_zone
Thread-Index: AQHT46zY0MF6WC61BUed7IoviL30RKQftP0AgAKu3ZA=
Date: Sun, 6 May 2018 09:32:15 +0000
Message-ID: <HK2PR03MB168459A1C4FB2B7D3E1F6A4A92840@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1525416729-108201-1-git-send-email-yehs1@lenovo.com>
 <1525416729-108201-3-git-send-email-yehs1@lenovo.com>
 <20180504133533.GR4535@dhcp22.suse.cz>
 <20180504154004.GB29829@bombadil.infradead.org>
In-Reply-To: <20180504154004.GB29829@bombadil.infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.253.21.154]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB0739;7:BcP8/n+FzBDVCB6npAJFUr3av55pMm93gmA+unLOk3J3Uz831PTebskaz7hRPUbVops4MIAOXDwmHG7G/E4EQZKHhG9azroYM9c2OKoDsTWD1xYGW09Yspusg2Y6wCEdeQ6K4Ctsx7PfyfWnVzlQRJxfPP45v7xGMLZ+Xfy3ZiBETl8vgp8JEJ0YemyaT6Na92TY2TOIBUMcHfJg9qGdExGCqIJbIgUre82VHCYoiU9EjmcjCqbSgdumYe0BZY3G;20:4p+fX7f8l14tGLOKpTfh61Arfrkn7JzpbRwDAYOdPwBInwoTg9O/Q/O0As4Pny1VmnziTxBggXOB+xdp5RHLMMBCw0A2ekYRZ6Qw0hJfQObrpfDq2Dp5gidKD6qcltZ70SLqeYDS/wWCNVQL29D4CHwFzISCjdVWA8Wt8IsIGFPCuEppbPArftWigo3IVc9JSbkGckngL8DBjRaTDO8LSIxay3UfiJnSuiPJfJQKbuKn/eeOci+NlK6YzDU7JOJlO4AFOIp6Rl+E3Cmg1hc3uVqpTVgFMFm0mhgHFGKUve0n50lhhWSVN62qnMVyCNP/NMW0w2dUBwSe7z5tKx89IQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(366004)(39380400002)(39840400004)(396003)(376002)(346002)(189003)(199004)(377424004)(68736007)(93886005)(33656002)(446003)(11346002)(476003)(97736004)(2900100001)(5250100002)(486006)(14454004)(7416002)(305945005)(5660300001)(7736002)(6436002)(74316002)(8936002)(81166006)(575784001)(81156014)(86362001)(8676002)(316002)(66066001)(478600001)(110136005)(54906003)(229853002)(76176011)(106356001)(105586002)(7696005)(9686003)(99286004)(2906002)(3280700002)(3660700001)(6246003)(6116002)(3846002)(53936002)(186003)(6506007)(6346003)(102836004)(26005)(55016002)(25786009)(59450400001)(4326008);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB0739;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB0739;
x-ms-traffictypediagnostic: HK2PR03MB0739:
x-microsoft-antispam-prvs: <HK2PR03MB0739F9BC1269F1D187632A4B92840@HK2PR03MB0739.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(10201501046)(3002001)(93006095)(93001095)(3231254)(944501410)(52105095)(149012)(150012)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:HK2PR03MB0739;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB0739;
x-forefront-prvs: 06640999CA
x-microsoft-antispam-message-info: nBpSTYWO/p7KLrFn3ZahTjCrK17p5FJ4honHDWNm52Z8vm/nE39bsZmXcW4rUfIgS7cwafIIJyfLrvqbsBiT2lTte+URbtdgDzx8Q80k0cP79b1K1xJmLio85xDAuaTOZaWBBwjBxRSJpiIW0ayKxfQYorS4JpnnYKD4FMXzRYmhz4anfuoZ98IbvYePoHI6
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 7542f571-e773-4fc0-44b5-08d5b3344114
X-MS-Exchange-CrossTenant-Network-Message-Id: 7542f571-e773-4fc0-44b5-08d5b3344114
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2018 09:32:15.2940
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB0739
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w469WbkE016634


> On Fri, May 04, 2018 at 03:35:33PM +0200, Michal Hocko wrote:
> > On Fri 04-05-18 14:52:08, Huaisheng Ye wrote:
> > > Suggest using unsigned int instead of int for bit within gfp_zone.
> > > @@ -401,7 +401,7 @@ static inline bool gfpflags_allow_blocking(const
> gfp_t gfp_flags)
> > >  static inline enum zone_type gfp_zone(gfp_t flags)
> > >  {
> > >  	enum zone_type z;
> > > -	int bit = (__force int) (flags & GFP_ZONEMASK);
> > > +	unsigned int bit = (__force unsigned int) (flags & GFP_ZONEMASK);
> > >
> > >  	z = (GFP_ZONE_TABLE >> (bit * GFP_ZONES_SHIFT)) &
> > >  					 ((1 << GFP_ZONES_SHIFT) - 1);
> 
> That reminds me.  I wanted to talk about getting rid of GFP_ZONE_TABLE.
> Instead, we should encode the zone number in the bottom three bits of
> the gfp mask, while preserving the rules that ZONE_NORMAL gets encoded
> as zero (so GFP_KERNEL | GFP_HIGHMEM continues to work) and also leaving
> __GFP_MOVABLE in bit 3 so that it can continue to be used as a flag.
> 
> So I was thinking ...
> 
> -#define ___GFP_DMA             0x01u
> -#define ___GFP_HIGHMEM         0x02u
> -#define ___GFP_DMA32           0x04u
> +#define ___GFP_ZONE_MASK	0x07u
> 
> #define __GFP_DMA	((__force gfp_t)OPT_ZONE_DMA ^ ZONE_NORMAL)
> #define __GFP_HIGHMEM	((__force gfp_t)OPT_ZONE_HIGHMEM ^
> ZONE_NORMAL)
> #define __GFP_DMA32	((__force gfp_t)OPT_ZONE_DMA32 ^
> ZONE_NORMAL)
> #define __GFP_MOVABLE	((__force gfp_t)ZONE_MOVABLE ^ ZONE_NORMAL | \
> 			 ___GFP_MOVABLE)
> #define GFP_ZONEMASK	((__force gfp_t)___GFP_ZONE_MASK |
> ___GFP_MOVABLE)
> 
> Then we can delete GFP_ZONE_TABLE and GFP_ZONE_BAD.
> gfp_zone simply becomes:
> 
> static inline enum zone_type gfp_zone(gfp_t flags)
> {
> 	return ((__force int)flags & ___GFP_ZONE_MASK) ^ ZONE_NORMAL;
> }
> 
> Huaisheng Ye, would you have time to investigate this idea?

Dear Matthew and Michal,

This idea is great, we can replace GFP_ZONE_TABLE and GFP_ZONE_BAD with it.
I have realized it preliminarily based on your code and tested it on a 2 sockets platform. Fortunately, we got a positive test result.

I made some adjustments for __GFP_HIGHMEM, this flag is special than others, because the return result of gfp_zone has two possibilities, which depend on ___GFP_MOVABLE has been enabled or disabled.
When ___GFP_MOVABLE has been enabled, ZONE_MOVABLE shall be returned. When disabled, OPT_ZONE_HIGHMEM shall be used.

#define __GFP_DMA	((__force gfp_t)OPT_ZONE_DMA ^ ZONE_NORMAL)
#define __GFP_HIGHMEM	((__force gfp_t)ZONE_MOVABLE ^ ZONE_NORMAL)
#define __GFP_DMA32	((__force gfp_t)OPT_ZONE_DMA32 ^ ZONE_NORMAL)
#define __GFP_MOVABLE	((__force gfp_t)___GFP_MOVABLE)  /* ZONE_MOVABLE allowed */
#define GFP_ZONEMASK	((__force gfp_t)___GFP_ZONE_MASK | ___GFP_MOVABLE)

The present situation is that, based on this change, the bits of flags, __GFP_DMA and __GFP_HIGHMEM and __GFP_DMA32, have been encoded.
That is totally different from existing code, you know in kernel scope, there are many drivers or subsystems use these flags directly to realize bit manipulations like this below,
swiotlb-xen.c (drivers\xen):	flags &= ~(__GFP_DMA | __GFP_HIGHMEM);
extent_io.c (fs\btrfs):			mask &= ~(__GFP_DMA32|__GFP_HIGHMEM);

Because of these flags have been encoded, the above operations can cause problem.
I am trying to get a solution to resolve it. Any progress will be reported.

Sincerely,
Huaisheng Ye
Linux kernel | Lenovo
