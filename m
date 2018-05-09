Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935319AbeEIO5Y (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 10:57:24 -0400
Received: from mail1.bemta8.messagelabs.com ([216.82.243.199]:38786 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S935163AbeEIO5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 10:57:22 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTbUxTVxjHe+5bL9i7HAqMZ43woSNxY8JguOw
  mM4tLlux+0bAZZ1Ic7tZee7v1hfTWBbMFFQVd16Gi40UqwxeIIGZZESZqxFgI4ktYgDmimw6Z
  2QAHW+t8ASbr7UW3ffs95///P89zknNY0rhdb2KlEp/kdYtOM5NIyb+NEtkFhqglt6NyOR/8u
  o3hD5+T+ZptA3r+yOwDij8eWskPnQ4y/M22eZo/1XSO4CfvN5N8ebiL4ut3TNF8/bZKxM8+DD
  IrOCF8d5oUuk60EkL7sSwh1PoZI4QiVXrhYu0sJfx55zolXGns0Qvtlz8ROmbeEMofpArRUEa
  BwUI73FZPyQe03Ns1QhQHTCX3QvatqCnFjxJZI/4VQUNtA6UVvQjKKsbiBYUDJHQeqWQ0pZKA
  /vt9SCt+RPD3ofOkHyWwDH4R+u9ei3MKXgnhgw9p1UTiWxQc2x+KxVk2GRfC8atLNM86aKjfj
  jT+EO7MtcezFM6Eip5g3M7FPDNl72mz/DTMN/xOqZ4EvBzGdl3Uq4xwOlTfvkWoTOI0OFh9gF
  YZMIajZwdIjVNhfOwxrfZE+F2YOlnkR/rYsRnmlmiGdBj86vP4rQDvoaE8eG0hmQd9Ld2kJkR
  p2LtrhNGKTgRD34whtSfgLLg5bNACH0HT8O2F8OvQMvHHwjoZ0PrFKKVlW0i4PHOU0YTFMF77
  LbMHvXzgP1fQeCk0nokwGr8EzYcmSZU5nAT9db9QjYhqRS8okvdjyZu9bFmO1euwyz6X6HBm5
  +XyOS5JUUS75BStSs4GjyuEYk9xi06HTqG5nsIL6DmWMKdydcMRi/EZq8e2WRYVeb13k1NSLq
  DFLGsGLn9R1GJM8kp2qWSjwxl7z09kYA3mFO5tVeaUYtGlOOyadAnls9XNgQDJtp2sCpBGyu1
  xS6Y07jXVilWrvMn9tNGTvzGI0k3JHNLpdEZDseR1OXz/1ydQGovMyVym2sXgcPuezpuIrULE
  Vkn6eVpdxSf+K5m2oubsK9ara94qerNz6Zdnh07zq+Zrr/fuXlU4WUcUpUU+DZt36jueTdx8o
  3pf+JX5wdWjmRte/b67vhR9Z/PY+nprHhd0ro3K+6fLBv6a2pKuv7dvtyVhL3tj/UhGl7/UnY
  vfyT9hW/So1Pb+JeNPNc65naszsp7/YUfOeV1dRWQcda+tMlOKLOZlkV5F/AfFrvTyFgQAAA=
  =
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-3.tower-144.messagelabs.com!1525877840!24709235!1
X-Originating-IP: [104.232.225.2]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Huaisheng HS1 Ye <yehs1@lenovo.com>
To: Matthew Wilcox <willy@infradead.org>,
        "dsterba@suse.cz" <dsterba@suse.cz>
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
Thread-Index: AQHT46zY0MF6WC61BUed7IoviL30RKQftP0AgAKu3ZCAAFaOAIAAIzywgAAyoACAAV5skIAAMLwAgAAs8ICAArXhkA==
Date: Wed, 9 May 2018 14:57:07 +0000
Message-ID: <HK2PR03MB1684C9AC9D21C628CCA977FD92990@HK2PR03MB1684.apcprd03.prod.outlook.com>
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
 <20180507212500.bdphwfhk55w6vlbb@twin.jikos.cz>
In-Reply-To: <20180507212500.bdphwfhk55w6vlbb@twin.jikos.cz>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.240.70.199]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB1571;7:2+lTw14N4rmXBDiHoTuqpVx2MJNwStSGIL0TbLmkouVddZ2ARZFHIjgy6elJBKlZLG8E+k5dJVn4EejuiQjua5TNptzDqFyjTg+iOc8izaO8NckPihEck6h5trrcpJOSkvLa7TKuk+A7rkJrxTZmW5ISJsNuaeCKJVb61dG80pKfJnQh894ZIlgexyx3qqwjL8V5ogqep1eUCdF9yw6F3OVy5ISeUhxGsMTJINY/S4xM7aI8JvgvcirviJGcBgvr;20:8p2tqRNiV5vFGvcQLhhVaZKc8+Ia2G6bCJ9h3rw1giR6MUxrogf+eVJWgPMBv76FQYNXQ0gbShoNcQddQXhMwGUSALC9Q9Mk+Fu5L638gb6KtFs6OAGZooEaaPordfhuRhnGjqIhacvDCQpGUU6sloTCcef3EPjzNdEYRiIzFVjDUqnm9iN3WQmxkIYIDW6+OWsq5lIqjatxwO9BkYZTdBmrMDqleb/oGcTZRX886XuOONY3NrFQM0hA9ZHMj7EfcnlThFJJXcEzwPpLtMheLqHMjSoZDz+74zybn6JUoNA5wv2siI8I+tSo9VgrRlMc92r3JUxPQQPUkDHQrhPG7A==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(346002)(396003)(376002)(39380400002)(366004)(39850400004)(189003)(199004)(97736004)(3660700001)(26005)(186003)(93886005)(81166006)(2501003)(55016002)(229853002)(86362001)(4326008)(105586002)(305945005)(102836004)(5660300001)(9686003)(68736007)(81156014)(8676002)(99286004)(5250100002)(11346002)(476003)(478600001)(6246003)(7416002)(106356001)(446003)(486006)(8936002)(6436002)(7736002)(6116002)(2900100001)(74316002)(66066001)(54906003)(76176011)(33656002)(14454004)(7696005)(316002)(3846002)(3280700002)(110136005)(53936002)(6506007)(2906002)(25786009);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB1571;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB1571;
x-ms-traffictypediagnostic: HK2PR03MB1571:
x-microsoft-antispam-prvs: <HK2PR03MB15715C70DAA0F28CAE75C07092990@HK2PR03MB1571.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(158342451672863);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123560045)(20161123562045)(6072148)(201708071742011);SRVR:HK2PR03MB1571;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB1571;
x-forefront-prvs: 0667289FF8
x-microsoft-antispam-message-info: tCpvIn1Uh7DiwHNRCCX6nVnQUI3ratZYH39zT9Asbp2Tf9tG6GxshIDSCVneS6ohVtqBGc42KvQTzrpz2abuPbG7A3bqdv555v0FcF/hzbq6HQQm6aLjblrJBeyqkjvvVTygkCfqCUYgZDEknAP6INl92J7OxPrN+/3VwfwCvXFqKeFad3HqQKvIUklpHoed
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5166d2c9-171a-4cf0-f3ad-08d5b5bd22a9
X-MS-Exchange-CrossTenant-Network-Message-Id: 5166d2c9-171a-4cf0-f3ad-08d5b5bd22a9
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2018 14:57:07.6802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB1571
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w49EvU6q015633


> On Mon, May 07, 2018 at 11:44:10AM -0700, Matthew Wilcox wrote:
> > On Mon, May 07, 2018 at 05:16:50PM +0000, Huaisheng HS1 Ye wrote:
> > > I hope it couldn't cause problem, but based on my analyzation it has the potential
> to go wrong if users still use the flags as usual, which are __GFP_DMA, __GFP_DMA32
> and __GFP_HIGHMEM.
> > > Let me take an example with my testing platform, these logics are much abstract,
> an example will be helpful.
> > >
> > > There is a two sockets X86_64 server, No HIGHMEM and it has 16 + 16GB memories.
> > > Its zone types shall be like this below,
> > >
> > > ZONE_DMA		0		0b0000
> > > ZONE_DMA32		1		0b0001
> > > ZONE_NORMAL		2		0b0010
> > > (OPT_ZONE_HIGHMEM)	2		0b0010
> > > ZONE_MOVABLE		3		0b0011
> > > ZONE_DEVICE		4		0b0100 (virtual zone)
> > > __MAX_NR_ZONES	5
> > >
> > > __GFP_DMA	= ZONE_DMA ^ ZONE_NORMAL= 0b0010
> > > __GFP_DMA32	= ZONE_DMA32 ^ ZONE_NORMAL= 0b0011
> > > __GFP_HIGHMEM = OPT_ZONE_HIGHMEM ^ ZONE_NORMAL = 0b0000
> > > __GFP_MOVABLE	= ZONE_MOVABLE ^ ZONE_NORMAL | ___GFP_MOVABLE = 0b1001
> > >
> > > Eg.
> > > If a driver uses flags like this below,
> > > Step 1:
> > > gfp_mask  |  __GFP_DMA32;
> > > (0b 0000		|	0b 0011	= 0b 0011)
> > > gfp_mask's low four bits shall equal to 0011, assuming no __GFP_MOVABLE
> > >
> > > Step 2:
> > > gfp_mask  & ~__GFP_DMA;
> > > (0b 0011	 & ~0b0010   = 0b0001)
> > > gfp_mask's low four bits shall equal to 0001 now, then when it enter gfp_zone(),
> > >
> > > return ((__force int)flags & ___GFP_ZONE_MASK) ^ ZONE_NORMAL;
> > > (0b0001 ^ 0b0010 = 0b0011)
> > > You know 0011 means that ZONE_MOVABLE will be returned.
> > > In this case, error can be found, because gfp_mask needs to get ZONE_DMA32 originally.
> > > But with existing GFP_ZONE_TABLE/BAD, it is correct. Because the bits are way of
> 0x1, 0x2, 0x4, 0x8
> >
> > Yes, I understand your point here.  My point was that this was already a bug;
> > the caller shouldn't simply be clearing __GFP_DMA; they really mean to clear
> > all of the GFP_ZONE bits so that they allocate from ZONE_NORMAL.  And for
> > that, they should be using ~GFP_ZONEMASK
> >
> > Unless they already know, of course.  For example, this one in
> > arch/x86/mm/pgtable.c is fine:
> >
> >         if (strcmp(arg, "nohigh") == 0)
> >                 __userpte_alloc_gfp &= ~__GFP_HIGHMEM;
> >
> > because it knows that __userpte_alloc_gfp can only have __GFP_HIGHMEM set.
> >
> > But something like btrfs should almost certainly be using ~GFP_ZONEMASK.
> 
> Agreed, the direct use of __GFP_DMA32 was added in 3ba7ab220e8918176c6f
> to substitute GFP_NOFS, so the allocation flags are less restrictive but
> still acceptable for allocation from slab.
> 
> The requirement from btrfs is to avoid highmem, the 'must be acceptable
> for slab' requirement is more MM internal and should have been hidden
> under some opaque flag mask. There was no strong need for that at the
> time.

Hi Matthew,

Should we add an error detection in gfp_zone? How about this?

@@ -377,6 +377,8 @@ static inline enum zone_type gfp_zone(gfp_t flags)
                z = OPT_ZONE_HIGHMEM +
                        !!((__force unsigned int)flags & ___GFP_MOVABLE);
        }
+
+       VM_BUG_ON(z > ZONE_MOVABLE);
        return z;
 }


Sincerely,
Huaisheng Ye
