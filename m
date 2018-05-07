Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752412AbeEGRRN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 13:17:13 -0400
Received: from mail1.bemta12.messagelabs.com ([216.82.251.2]:58016 "EHLO
        mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751923AbeEGRRK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 13:17:10 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTfUxbVRjGe+73Ri+7FJDXZiyxOgWSNmMuy9U
  tRrMsuX+oMTMxyox4u125Df3Ae4uiJlqGTCl1kIWUQQsCU8aXQztGVrNgVmZks8sMOHSNG2MW
  dUigOqNkxGEvt5v6z8nvPc/znvOck3MY3PQebWakGq+kuEWnhVpPyL/MYtY8f6psS2+Y58PDQ
  xTfMybzrbUXaX4w8hQ/9XmY4q8OrZL8qY/HMP7XP3txvn48SvChdxdJPlR7CPEry2HqcaMwvr
  CEC9FPBjDhRF+JEBlooITI74dpYeLICiH8NpcghHjXWVo48fVbwslbjwn1f+ULNyObnjGWkQ6
  33VPzMil/v7hMV13aWdM6fRD3odQOP1rPmLgkgkTbHNKLMwiuHGqitYLgAjgMx/2ErjRhULfa
  R+nFDwiO3jhP+tE6huKK4dzCNO5HDJPHFcHCyFbNg3MzBPS1RChtPpfbC4MXHtLsedyL0BmqQ
  zo/B7GrCVpjgnsAjn3zKaUxm/ZcHmwg9b2mcTjzd+uaaR23E748MIFpjLhCCF6fWWOcK4COYP
  taHuA4+Oj0RVznfLjx421Sy4C4PbA48pI+bYHo1MGMpRAmP2xEOjeTsBou17kUvur/AtcyANd
  AwYGOMVIvRhEcOx7GdFcJtEbjGa6EiWQqwzugfz6VCbQJBj6YJfTmfhyafcGMsBFCLddQM7K1
  /+cQOpdAp28F0/k+aGmcpdvXbiYHzrUliS5EDKAiVVJekxTrtu02u+KokL0u0eG0lpZutbkkV
  RUrJKdoV237PK4ISj/EdwwGdApd6t4bQ/cymCWfzbq2VGbKtnv2vyGLqlyuVDslNYY2MowF2G
  /fT5WZchSpQqp5xeFMv+Y7MjBGSx57UpNZtUp0qY4KXTqPHmGCvYEAzgyNHE6PyalgADcRbo9
  bMhewSa2B0xrkavfd5e78j0lUaM5lkcFgMBmrJMXl8P5fn0cFDLLkske1VYwOt/furvPpQFg6
  UI52Flb1iv9KZh96Qo73LG/5qehhJfZHDzEy15148vXKiXAjXLn/0aynd69+Zh6/2cy/fXv/6
  HfbN5/tZYs764att2IXCmnb5ZBvsq2yQXlww0y9Zz5C/ZxtrztdXT7aJC4lX90c2xVgzLtr39
  xw5IVE8eJ1LLty3/Pd1qxnXfFtx6PRqtg9Sx3ZK127LIQqi6UluKKK/wDdfp9kGgQAAA==
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-12.tower-168.messagelabs.com!1525713426!68855537!1
X-Originating-IP: [104.232.225.2]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Huaisheng HS1 Ye <yehs1@lenovo.com>
To: Matthew Wilcox <willy@infradead.org>
CC: Michal Hocko <mhocko@kernel.org>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
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
Thread-Index: AQHT46zY0MF6WC61BUed7IoviL30RKQftP0AgAKu3ZCAAFaOAIAAIzywgAAyoACAAV5skA==
Date: Mon, 7 May 2018 17:16:50 +0000
Message-ID: <HK2PR03MB1684BF10B3B515BFABD35F8B929B0@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1525416729-108201-1-git-send-email-yehs1@lenovo.com>
 <1525416729-108201-3-git-send-email-yehs1@lenovo.com>
 <20180504133533.GR4535@dhcp22.suse.cz>
 <20180504154004.GB29829@bombadil.infradead.org>
 <HK2PR03MB168459A1C4FB2B7D3E1F6A4A92840@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180506134814.GB7362@bombadil.infradead.org>
 <HK2PR03MB168447008C658172FFDA402992840@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180506185532.GA13604@bombadil.infradead.org>
In-Reply-To: <20180506185532.GA13604@bombadil.infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.120.83.217]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB0868;7:l0Xrlbj1gq+XkTKCE7hZFowJvwChgfytUr67ggu4818f7O1w8D0/y2hpHtnKTD8tVe4//l3+3fHTi9IUEyIVI6CJGC5K5WWiNFWr6IiZiVmiSHZJ8LRjefLGsD1/PSNZI+iITQV1ZQoWyURfmJcomKualAoC1sKEBHzITZNOfdZl0fjcjZeGVzpMwPQT54udd4bXLBkjYfqLZhe3Vu3sAmx4n2O9WcZunzjMyQMHai3MKhPOnjhkb73gmZo1+8C4;20:juKFVZIT8YpNCafY3KrSg6R+En+QHSW6BrUe4NadW1bQbpFx9pNeLRi7mWtDBh20MxZGkV/eLMDu3K5h/7u544nboV5xavS00iqyFoe6rI20AhmpOyxNTl8FceIRoVrc0SwJQObTmSXvD1CWhpXhk12Qij6+GjLJF44w+ieKZ1RhicZD4khq1dpqjiub4GIf/D/dAPRVYwgBRxks7eiaTPmgERMLNsXNCLGuTVG8b99hJHNwKKCrD9NbpMc05kmYpQkuIWdJNRcVkQFVq8R+eGrSTN/DDvRxjjAZ0fCWUxR2Kys1a5IkXf4kippzYte3PCijgUL65s0yaBM5v+6qAg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(376002)(396003)(39850400004)(346002)(39380400002)(366004)(199004)(189003)(476003)(3846002)(33656002)(11346002)(99286004)(102836004)(5250100002)(186003)(26005)(76176011)(53936002)(7696005)(59450400001)(6506007)(6116002)(7736002)(229853002)(105586002)(106356001)(316002)(74316002)(6436002)(305945005)(5660300001)(7416002)(66066001)(6916009)(486006)(446003)(54906003)(86362001)(2900100001)(413944005)(25786009)(97736004)(14454004)(8936002)(2906002)(3280700002)(4326008)(55016002)(9686003)(81166006)(81156014)(3660700001)(8676002)(93886005)(478600001)(6246003)(68736007)(9126004);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB0868;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB0868;
x-ms-traffictypediagnostic: HK2PR03MB0868:
x-microsoft-antispam-prvs: <HK2PR03MB08682B8CB7C4DA7517C5620E929B0@HK2PR03MB0868.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(93006095)(93001095)(10201501046)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123564045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123558120)(20161123562045)(6072148)(201708071742011);SRVR:HK2PR03MB0868;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB0868;
x-forefront-prvs: 066517B35B
x-microsoft-antispam-message-info: wortlpvVoVFIuM6Fowi3nxl174dJUvQ4VzK+APtKbSfuT3I5FFr1r+R+lsnCQ65gdfNLAUcM8R1HwEDGBpgDP1duiBair9n5hkupx3g/5LKma86XwLPyFoGUWXGQAhkOfiZNSFfijHRp7iRjaJP10fNCbVjUtbxGFFVrb29FMRB9caZVbfsRkbwsPN83ya34
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="gb2312"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: e901e31d-5188-45da-e629-08d5b43e5253
X-MS-Exchange-CrossTenant-Network-Message-Id: e901e31d-5188-45da-e629-08d5b43e5253
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 May 2018 17:16:50.3273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB0868
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w47HHHva006220

Dear Matthew,

I will try to explain them in depth. Correct me if anything wrong.
> 
> On Sun, May 06, 2018 at 04:17:06PM +0000, Huaisheng HS1 Ye wrote:
> > Upload my current patch and testing platform info for reference. This patch
> has been tested
> > on a two sockets platform.
> 
> Thank you!
My pleasure.

> > It works, but some drivers or subsystem shall be modified to fit
> > these new type __GFP flags.
> > They use these flags directly to realize bit manipulations like this
> > below.
> >
> > eg.
> > swiotlb-xen.c (drivers\xen):    flags &= ~(__GFP_DMA | __GFP_HIGHMEM);
> > extent_io.c (fs\btrfs):         mask &= ~(__GFP_DMA32|__GFP_HIGHMEM);
> >
> > Because of these flags have been encoded within this patch, the
> > above operations can cause problem.
> 
> I don't think this actually causes problems.  At least, no additional
> problems.  These users will successfully clear __GFP_DMA and
> __GFP_HIGHMEM
> no matter what values GFP_DMA and GFP_HIGHMEM have; the only problem
> will be if someone calls them with a zone type they're not expecting (eg DMA32
> for the first one or DMA for the second; or MOVABLE for either of them).
> The thing is, they're already buggy in those circumstances.

I hope it couldn't cause problem, but based on my analyzation it has the potential to go wrong if users still use the flags as usual, which are __GFP_DMA, __GFP_DMA32 and __GFP_HIGHMEM.
Let me take an example with my testing platform, these logics are much abstract, an example will be helpful.

There is a two sockets X86_64 server, No HIGHMEM and it has 16 + 16GB memories.
Its zone types shall be like this below,

ZONE_DMA				0		0b0000
ZONE_DMA32				1		0b0001
ZONE_NORMAL			2		0b0010
(OPT_ZONE_HIGHMEM)	2		0b0010
ZONE_MOVABLE			3		0b0011
ZONE_DEVICE				4		0b0100 (virtual zone)
__MAX_NR_ZONES		5

__GFP_DMA		= ZONE_DMA    			^ ZONE_NORMAL= 0b0010
__GFP_DMA32		= ZONE_DMA32  		^ ZONE_NORMAL= 0b0011
__GFP_HIGHMEM = OPT_ZONE_HIGHMEM ^ ZONE_NORMAL = 0b0000
__GFP_MOVABLE	= ZONE_MOVABLE ^ ZONE_NORMAL | ___GFP_MOVABLE = 0b1001

Eg.
If a driver uses flags like this below,
Step 1:
gfp_mask  |  __GFP_DMA32;	
(0b 0000		|	0b 0011	= 0b 0011)
gfp_mask's low four bits shall equal to 0011, assuming no __GFP_MOVABLE

Step 2:
gfp_mask  & ~__GFP_DMA;	
(0b 0011	 & ~0b0010   = 0b0001)
gfp_mask's low four bits shall equal to 0001 now, then when it enter gfp_zone(),

return ((__force int)flags & ___GFP_ZONE_MASK) ^ ZONE_NORMAL;
(0b0001 ^ 0b0010 = 0b0011)
You know 0011 means that ZONE_MOVABLE will be returned.
In this case, error can be found, because gfp_mask needs to get ZONE_DMA32 originally.
But with existing GFP_ZONE_TABLE/BAD, it is correct. Because the bits are way of 0x1, 0x2, 0x4, 0x8

I just want to show a case of failure, please don't blame me that use case was invented.
Again, your idea is great in my eyes, which has much advantages than ZONE_TABLE/BAD.
But if we use this idea, that means other subsystem or driver shall not use the flags as existing way.
Of course, this limitation only exists in low 3 bits of gfp_t. The remaining high bits can be used as usual.

This is my opinion, maybe it is not accurate, but I really worry about it.

> >   */
> > -#define __GFP_DMA      ((__force gfp_t)___GFP_DMA)
> > -#define __GFP_HIGHMEM  ((__force gfp_t)___GFP_HIGHMEM)
> > -#define __GFP_DMA32    ((__force gfp_t)___GFP_DMA32)
> > +#define __GFP_DMA      ((__force gfp_t)OPT_ZONE_DMA ^
> ZONE_NORMAL)
> > +#define __GFP_HIGHMEM  ((__force gfp_t)ZONE_MOVABLE ^
> ZONE_NORMAL)
> > +#define __GFP_DMA32    ((__force gfp_t)OPT_ZONE_DMA32 ^
> ZONE_NORMAL)
> >  #define __GFP_MOVABLE  ((__force gfp_t)___GFP_MOVABLE)  /*
> ZONE_MOVABLE allowed */
> [...]
> >  static inline enum zone_type gfp_zone(gfp_t flags)
> > {
> >         enum zone_type z;
> > -       int bit = (__force int) (flags & GFP_ZONEMASK);
> > +       z = ((__force unsigned int)flags & ___GFP_ZONE_MASK) ^
> ZONE_NORMAL;
> >
> > -       z = (GFP_ZONE_TABLE >> (bit * GFP_ZONES_SHIFT)) &
> > -                                        ((1 << GFP_ZONES_SHIFT) - 1);
> > -       VM_BUG_ON((GFP_ZONE_BAD >> bit) & 1);
> > +       if (z > OPT_ZONE_HIGHMEM) {
> > +               z = OPT_ZONE_HIGHMEM +
> > +                       !!((__force unsigned int)flags & ___GFP_MOVABLE);
> > +       }
> >         return z;
> >  }
> 
> How about:
> 
> +#define __GFP_HIGHMEM  ((__force gfp_t)OPT_ZONE_HIGHMEM ^
> ZONE_NORMAL)
> -#define __GFP_MOVABLE  ((__force gfp_t)___GFP_MOVABLE)  /*
> ZONE_MOVABLE allowed */
> +#define __GFP_MOVABLE  ((__force gfp_t)ZONE_MOVABLE ^
> ZONE_NORMAL | \
> +					___GFP_MOVABLE)
> 
> Then I think you can just make it:
> 
> static inline enum zone_type gfp_zone(gfp_t flags)
> {
> 	return ((__force int)flags & ___GFP_ZONE_MASK) ^ ZONE_NORMAL;
> }
Sorry, I think it has risk in this way, let me introduce a failure case for example.

Now suppose that, there is a flag should represent DMA flag with movable.
It should be like this below,
__GFP_DMA | __GFP_MOVABLE
(0b 0010       |   0b 1001   = 0b 1011)
Normally, gfp_zone shall return ZONE_DMA but with MOVABLE policy, right?
But with your code, gfp_zone will return ZONE_DMA32 with MOVABLE policy.
(0b 1011  ^  0b 0010 = 1001)

You can find that something wrong happens, so that is why I make gfp_zone more complicated than yours.

> > @@ -370,42 +368,15 @@ static inline bool gfpflags_allow_blocking(const
> gfp_t gfp_flags)
> >  #error GFP_ZONES_SHIFT too large to create GFP_ZONE_TABLE integer
> >  #endif
> 
> You should be able to delete GFP_ZONES_SHIFT too.
Yes, you are right.

Sincerely,
Huaisheng Ye | Ò¶»³Ê¤
Linux kernel | Lenovo
