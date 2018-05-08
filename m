Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753666AbeEHAZv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 20:25:51 -0400
Received: from mail1.bemta12.messagelabs.com ([216.82.251.7]:52084 "EHLO
        mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1752969AbeEHAZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 20:25:49 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTa0xTZxjH+55bD65HXwqEZw3w4cRFZYMMnfE
  kmoVs+3DidDF+0KSY4el2bBt7YT11QbdkVIeJ2jFiGTjoBiyIlqLDAxpgs4hoHLvIApvLvAFe
  opaLHRp2Mcz1cKrbvv2e5/9/n8ub92VJc8BoYeVyv+zzSC6eWUA57o4TBQemE9YX+3avEcJft
  jPCFzGHUBcYMgpRdb0w0htmhOvtj2mh+3CMECZmW0mhcqCHEho+nKaFhkAVEh79EWaKTeLA5H
  1S7DnWRoidR/NFtW0fI6ozB43iN4ceUeJvty9T4vdN54xi53fviSf/elms/D1LfKDmbTBZaaf
  H5i3fSjumTidQWSKv/GJfgKhA52A/WsCa8S0EEz0Box70Iwg1DlJaQOEgCRdDKqkrHxNwb6Aj
  ZbuKIJAIJ5U0lsHLYHDyUpJZNhMvhcmu5ZqHxKMUHK1RGS2fgUsg+sMSzZ6Jt8DnDXuQzjZov
  POJUWMKL4aJyG1GYy7pqdl/PNXrVwqOB0fmhTS8Bo5cSsz3RTgXam+MEhqTOBs+q62nNQaMoe
  XrIVLnLLh3829amwHhjTDd9aae5qG+vyVlz4XhxgNI52oa6mbW6VwEFyJ988sDPsHAw84QrQe
  nEBy78ieju/Lh7thcirdDpKcyxashEk+kOuRB20fjlH44QsL1Ye2CNSEHwtdiVDUqrP/PEjq/
  AE1fzTA6Pw+tzRNk/fzNpMPgp7eoJkS1oaWK7HtX9hW8tKLQ5nPaHX635HQVFBUtL3TLiiLZZ
  ZdkUwrf8rpVlHyIHxgMqBuNNJecRc+yBJ/FPTN232peaPO+vdMhKY5S3w6XrJxFOSzLA2ebSl
  jN6T7ZLpdvc7qSr/mJDKyJz+RmNZlTyiS34rTr0rdoBVvbGgySbHvXwSBppjxej2zJ5vZpVqx
  ZHTs8Tws9+RnDKNeSwSGDwWA2lck+t9P/fz2OslnEZ3DVWhWT0+N/2i+eHIVIjpKubcEpfulf
  yVKBSrm0+PvhH7Orzpxu7pXGikOVNze9en7R2qj9SIW3NL5ws/WG+Tm7faX/4U8tUNX1CtFdt
  /raY0a14JLXyubeGM3Kv3K48Z2f92ZEtv5ibV22t6lD3dXJ9/bz62pWbdsdW0RFi0u3H+qIQn
  DxbOad9Zs3jg+doTfUnJpamxMLvT7XzFOKQyrKJ32K9A/XO4cgFAQAAA==
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-12.tower-138.messagelabs.com!1525739145!97716285!1
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
Thread-Index: AQHT46zY0MF6WC61BUed7IoviL30RKQftP0AgAKu3ZCAAFaOAIAAIzywgAAyoACAAV5skIAAMLwAgABY5iA=
Date: Tue, 8 May 2018 00:25:31 +0000
Message-ID: <HK2PR03MB1684F0E4DFF0184486BB285B929A0@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1525416729-108201-1-git-send-email-yehs1@lenovo.com>
 <1525416729-108201-3-git-send-email-yehs1@lenovo.com>
 <20180504133533.GR4535@dhcp22.suse.cz>
 <20180504154004.GB29829@bombadil.infradead.org>
 <HK2PR03MB168459A1C4FB2B7D3E1F6A4A92840@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180506134814.GB7362@bombadil.infradead.org>
 <HK2PR03MB168447008C658172FFDA402992840@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180506185532.GA13604@bombadil.infradead.org>
 <HK2PR03MB1684BF10B3B515BFABD35F8B929B0@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180507184410.GA12361@bombadil.infradead.org>
In-Reply-To: <20180507184410.GA12361@bombadil.infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [111.197.250.78]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB0819;7:BpGSVw4R9BQqlVELIjxaoOSO8w5r66D2t1Xf4Q2zFwFBSfClpPp/hT3UU67+6hSdYstcbVr7SKXpsGdMUD+uvmmnNam3GMaLUnGpDMVHu+4fC2opI4QVWYTNYEI4PwwYEgY9UU1jvKBm1uNHqrWjNsr5pWpe51RYoQtV3B2kDsfTwbuIerb9rU8JP9KnipEmql7S4vW0NNsDbj5Y7c+M4YuJx9KgWczN0CX/aXM1PwSVj6YNsabU70tXkG+EVnJk;20:qE8lNbW16JnMaKo1WCpSuz/GCvV7/xXWSD9rMJwr72XdiIJDe862e+tldp6QJ/HeOUfWKMbVVBcTyM71fRFSwTvor9fT6YrJnf8AOTPRbNBecDYQIsNiCUpBB5ehT8/p8PHqhNCZ/EMm2/ADZ38TL7uKO2UmjxlS+l3fuUPgbOEZTf2vgwBYPF+4eoTfunHjuq2JjaZxM/QUXkePVqN1G+j7LQP9JLYlfSnSaPel0iHg85LxSQ9ntAfpVhTLqzB/8mlOcROD2MOVY0mtx8g22/hJeddJOdJvq1Y9nAj1NuUIhLK2z8wXfYk56yps9eFc7nd2lls99+9GKEiy1QuaRA==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(979002)(39850400004)(396003)(346002)(366004)(376002)(39380400002)(199004)(189003)(5250100002)(478600001)(97736004)(66066001)(186003)(305945005)(74316002)(68736007)(7416002)(6116002)(3846002)(106356001)(105586002)(14454004)(5660300001)(33656002)(99286004)(54906003)(6436002)(229853002)(2900100001)(11346002)(446003)(476003)(486006)(93886005)(316002)(7736002)(8936002)(6506007)(102836004)(81166006)(4326008)(59450400001)(81156014)(8676002)(26005)(25786009)(7696005)(3660700001)(55016002)(3280700002)(2906002)(6916009)(76176011)(6246003)(9686003)(86362001)(53936002)(13296004)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB0819;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB0819;
x-ms-traffictypediagnostic: HK2PR03MB0819:
x-microsoft-antispam-prvs: <HK2PR03MB081949C8B8D46E835B10EDE1929A0@HK2PR03MB0819.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(3002001)(149027)(150027)(6041310)(20161123562045)(20161123558120)(20161123564045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HK2PR03MB0819;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB0819;
x-forefront-prvs: 0666E15D35
x-microsoft-antispam-message-info: +sUkZ9C8AMt7KTKDD1q81HMTy85wpo7soEVFqoktX8pGgwq7Oq0v9FjTyKgGHzJ2R/9j1SHhgKh5BREDpLmIc7Nq7iRi6AbT308FV4M70p1LJSCgMLu6VIhlv51v7UjRIrq71Wl4Gf0CkJtj5Va+TGtXforw9Y/lLvcBW1pA8DD6YrNXdLaqLQ4UaElkmy1S
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 04b04c40-6e61-48e4-f653-08d5b47a3547
X-MS-Exchange-CrossTenant-Network-Message-Id: 04b04c40-6e61-48e4-f653-08d5b47a3547
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2018 00:25:31.4380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB0819
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w480PwVN031877


> On Mon, May 07, 2018 at 05:16:50PM +0000, Huaisheng HS1 Ye wrote:
> > I hope it couldn't cause problem, but based on my analyzation it has the
> potential to go wrong if users still use the flags as usual, which are __GFP_DMA,
> __GFP_DMA32 and __GFP_HIGHMEM.
> > Let me take an example with my testing platform, these logics are much
> abstract, an example will be helpful.
> >
> > There is a two sockets X86_64 server, No HIGHMEM and it has 16 + 16GB
> memories.
> > Its zone types shall be like this below,
> >
> > ZONE_DMA		0		0b0000
> > ZONE_DMA32		1		0b0001
> > ZONE_NORMAL		2		0b0010
> > (OPT_ZONE_HIGHMEM)	2		0b0010
> > ZONE_MOVABLE		3		0b0011
> > ZONE_DEVICE		4		0b0100 (virtual zone)
> > __MAX_NR_ZONES	5
> >
> > __GFP_DMA	= ZONE_DMA ^ ZONE_NORMAL= 0b0010
> > __GFP_DMA32	= ZONE_DMA32 ^ ZONE_NORMAL= 0b0011
> > __GFP_HIGHMEM = OPT_ZONE_HIGHMEM ^ ZONE_NORMAL = 0b0000
> > __GFP_MOVABLE	= ZONE_MOVABLE ^ ZONE_NORMAL |
> ___GFP_MOVABLE = 0b1001
> >
> > Eg.
> > If a driver uses flags like this below,
> > Step 1:
> > gfp_mask  |  __GFP_DMA32;
> > (0b 0000		|	0b 0011	= 0b 0011)
> > gfp_mask's low four bits shall equal to 0011, assuming no __GFP_MOVABLE
> >
> > Step 2:
> > gfp_mask  & ~__GFP_DMA;
> > (0b 0011	 & ~0b0010   = 0b0001)
> > gfp_mask's low four bits shall equal to 0001 now, then when it enter
> gfp_zone(),
> >
> > return ((__force int)flags & ___GFP_ZONE_MASK) ^ ZONE_NORMAL;
> > (0b0001 ^ 0b0010 = 0b0011)
> > You know 0011 means that ZONE_MOVABLE will be returned.
> > In this case, error can be found, because gfp_mask needs to get
> ZONE_DMA32 originally.
> > But with existing GFP_ZONE_TABLE/BAD, it is correct. Because the bits are
> way of 0x1, 0x2, 0x4, 0x8
> 
> Yes, I understand your point here.  My point was that this was already a bug;
> the caller shouldn't simply be clearing __GFP_DMA; they really mean to clear
> all of the GFP_ZONE bits so that they allocate from ZONE_NORMAL.  And for
> that, they should be using ~GFP_ZONEMASK
That is great, if they can follow this principle, I don't worry it. Maybe I am too cautious.

> 
> Unless they already know, of course.  For example, this one in
> arch/x86/mm/pgtable.c is fine:
> 
>         if (strcmp(arg, "nohigh") == 0)
>                 __userpte_alloc_gfp &= ~__GFP_HIGHMEM;
> 
> because it knows that __userpte_alloc_gfp can only have __GFP_HIGHMEM set.
> 
> But something like btrfs should almost certainly be using ~GFP_ZONEMASK.


> > > +#define __GFP_HIGHMEM  ((__force gfp_t)OPT_ZONE_HIGHMEM ^
> > > ZONE_NORMAL)
> > > -#define __GFP_MOVABLE  ((__force gfp_t)___GFP_MOVABLE)  /*
> > > ZONE_MOVABLE allowed */
> > > +#define __GFP_MOVABLE  ((__force gfp_t)ZONE_MOVABLE ^
> > > ZONE_NORMAL | \
> > > +					___GFP_MOVABLE)
> > >
> > > Then I think you can just make it:
> > >
> > > static inline enum zone_type gfp_zone(gfp_t flags)
> > > {
> > > 	return ((__force int)flags & ___GFP_ZONE_MASK) ^ ZONE_NORMAL;
> > > }
> > Sorry, I think it has risk in this way, let me introduce a failure case for
> example.
> >
> > Now suppose that, there is a flag should represent DMA flag with movable.
> > It should be like this below,
> > __GFP_DMA | __GFP_MOVABLE
> > (0b 0010       |   0b 1001   = 0b 1011)
> > Normally, gfp_zone shall return ZONE_DMA but with MOVABLE policy, right?
> 
> No, if you somehow end up with __GFP_MOVABLE | __GFP_DMA, it should give
> you ZONE_DMA.
Exactly, it should return ZONE_DMA, that's what I thought.

> 
> > But with your code, gfp_zone will return ZONE_DMA32 with MOVABLE
> >policy.
> > (0b 1011  ^  0b 0010 = 1001)
> 
> ___GFP_ZONE_MASK is 0x7, so it excludes __GFP_MOVABLE.
Sorry, I made a mistake here. I rewrite it as below.

((__GFP_DMA | __GFP_MOVABLE) & ___GFP_ZONE_MASK)
   ((0b 0010  |  0b 1001  = 0b 1011) & 0b 0111)	= 0b 0011

0b 0011 ^ 0b 0010 = 0b 0001
So ZONE_DMA32 will be returned, but what user needs is ZONE_DMA.

Thanks,
Huaisheng
