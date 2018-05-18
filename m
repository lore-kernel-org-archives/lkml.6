Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752129AbeERDEF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 23:04:05 -0400
Received: from mail1.bemta12.messagelabs.com ([216.82.251.16]:41154 "EHLO
        mail1.bemta12.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751734AbeERDEB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 23:04:01 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSbUxTZxTHfe5bbw2dD4WOMwLEdDEq2GaQjdw
  ly6LwwRtjFjazDxIjXNwdbdYWvLcQzDSAhkCUtxBFKRjqC45VjFqKOnGAWB3oYg0LSxwDUiXz
  hc5EhtHIUu3l8fV++p37/59z/k9yeNo4wSXzcoVbVlySw8wtZWz3w5TlcE40/5Pmq5TQcbqHE
  44O2ISD1SGd8MfFDk6Y6nnBChe6BihhunGt0F7diISFZx3cWr3Y250u+udadOLIoQVGPB0YZ8
  TfvUGd2HvjR7Hv+ZdizVOT+J8/LU+fz9pdRSUVhayt+f+bTOkDc8WtW7fZKjSWshct5Y14BsF
  gxzGaFFcQzEy1UVrB4G4afr3io4jSSMEl73GWFNMIRg8EmL1Iz3N4NYxG/oz183wiXgWRQJbm
  ofFZGp5c3kNpngRcANFW4k/EhdDZ8BQRzoHQnjZW62XwChjq+lhDA94CU0eXkVXzCC7PDnCaX
  Y+/AN/ux4tjEE6F1jvTi+NpnASHWz2sxoAxHL8Uogmb4MHd6OJ4hL+BR4Gt5Pdy6OvxU4RTYa
  xzH9J2AW5m4Ym/X0eETPjt50GaCNMsnJgY0ZHiHILzw5OLDwacDmcmk0jDDzAe7OUIp0Nd0PN
  qQxr4GsIM6fXT8NPVgVfpUmCoaTfdjKyedx5BeA14++c4whlw4sgsrbEBx8No2wzjRYwPrVRl
  pVxWLJ9aixR7sc3tlOwOS2ZmltUpq6pULDukItW6rcTpR7FDWxL7LiDfkdxh9BFPmU2GxuhCv
  vGDopLvdtgk1VaglDlkdRil8LwZDLXrovnGeEUuliu+tzti1/paBj7OnGhYp8kGtVRyqvZiIl
  1HFr4n0FJPGxlXiUtOTjLs1ExYM9nKXG9GvL75MZSanGBAsVDGuFJZcdrd7+sPURKPzAkkSZz
  d5X6z6WEsBBULgYYWtBBu6a2UXIU6xXDIXrOtYcNgdqdpvTSS1/Sh2/9P+bf1O03Ge5Gma44X
  51uXd4VzD7aPzH+utI/2W+Y/CzqiG4fCW/wb8aqcs31KxmbL9vub/qqqL8xNu7g1++a/1X/Hb
  xB2/XIydGpfRv9mqtLaXbe/K9KS602sE/Men9LPe4Ker2oLvuaDkUozo9qkzHRaUaWXmu6ucu
  4DAAA=
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-4.tower-143.messagelabs.com!1526612629!54362612!1
X-Originating-IP: [104.232.225.2]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Huaisheng HS1 Ye <yehs1@lenovo.com>
To: Matthew Wilcox <willy@infradead.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "mhocko@suse.com" <mhocko@suse.com>, "vbabka@suse.cz" <vbabka@suse.cz>,
        "mgorman@techsingularity.net" <mgorman@techsingularity.net>,
        "alexander.levin@verizon.com" <alexander.levin@verizon.com>,
        "colyli@suse.de" <colyli@suse.de>, NingTing Cheng <chengnt@lenovo.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [External]  Re: [PATCH v1] include/linux/gfp.h: getting rid of
 GFP_ZONE_TABLE/BAD
Thread-Topic: [External]  Re: [PATCH v1] include/linux/gfp.h: getting rid of
 GFP_ZONE_TABLE/BAD
Thread-Index: AQHT6HxSRcNgfj0RT02kxPWBEx8Dn6Qp2QqggACtQICACkWf8A==
Date: Fri, 18 May 2018 03:03:35 +0000
Message-ID: <HK2PR03MB1684A5EE7432CAF9763608D992900@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1525968625-40825-1-git-send-email-yehs1@lenovo.com>
 <20180510163023.GB30442@bombadil.infradead.org>
 <HK2PR03MB16843E14AD56B3E546D9F52D929F0@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180511132613.GA30263@bombadil.infradead.org>
In-Reply-To: <20180511132613.GA30263@bombadil.infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [114.245.9.79]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB0706;7:SmQlXtAUTsnKJ099R3kgCU5wtrDRyZkbUf0K3Yo2MT1JoX4bjVWjQ2NT79Tlnis+H1XnQ0+C46ekQNbOkHZ07bW7s5Pb8fFff7dfC299HPat9ZsgLmkZVRf+7uytXmzeTZAv/+85AjSjqu/9o9otG9nDnVUrNDwXEt5RUK8UjzuQiWlBHDoqakWq1mV8eg/xZtYsEWvInkd8kSnBDrDhj/Qaf++/LK9uGeOrJW8tLJCfCk5ETpPfzpdXVdt8CTYd;20:23c2ZTXNbo57iRbuYsfIYItpjSEoezwndyz01hbWnaiPXagF0CabgDsSQJhlEfqAFXb+W7/8k1YeTzMZwgUZJYRK9nFbP0LF6ZjmNDUI0TfCP4Z3+N3MsMEig77XLTdXq+jSEVsXZ0OUIb9cjpvmTSE2FxU7+wiIJU9GGmoqJ2Rk2DbwYb4ConxLx/TogZl/JDl0g9Kc+LIfqpuAZV63BEoPF1q3n/8kXCtuKq6Q1M5AiJiH2K+x/7FQ06nUQixHaWofO2lm8Zwlbfo9zWMcxl8QQnpKrg/QmT9eXfzvPHkGuh+4+Y+0UJZGHyBJYdXSAvipbjTkcZC5fojnbHtmEg==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(376002)(346002)(396003)(39850400004)(39380400002)(366004)(189003)(199004)(446003)(476003)(11346002)(486006)(102836004)(229853002)(26005)(186003)(6506007)(7696005)(54906003)(76176011)(99286004)(305945005)(6116002)(316002)(6436002)(86362001)(93886005)(66066001)(97736004)(7736002)(2906002)(25786009)(33656002)(9686003)(55016002)(74316002)(5660300001)(478600001)(8676002)(81156014)(81166006)(8936002)(2900100001)(4326008)(3280700002)(106356001)(3846002)(14454004)(6916009)(5250100002)(105586002)(53936002)(3660700001)(6246003)(68736007);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB0706;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB0706;
x-ms-traffictypediagnostic: HK2PR03MB0706:
x-microsoft-antispam-prvs: <HK2PR03MB070609D3FBA0FAD41157382792900@HK2PR03MB0706.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(10201501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(149027)(150027)(6041310)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123560045)(20161123564045)(20161123558120)(20161123562045)(6072148)(201708071742011)(7699016);SRVR:HK2PR03MB0706;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB0706;
x-forefront-prvs: 0676F530A9
x-microsoft-antispam-message-info: 82s7sLTsgx7IA3vCwZBe5MxDY8ksOy/eXcqUgNnteq33rCJdmEh57QEG1w2kZZHF5UUnln6sPoHGBOyOxmCRjVoMAEaX5lZNgZKMMaR+2yqZeIdDIpIY1dV9z6P/Yj4fspHdE0h5bwOzVnDfNcfdKRuad423/o8zczywbnqalqPtwkpt12sNOXGm3/QWoSH/
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: bf6dc84f-80b6-4f4b-1ede-08d5bc6bf25e
X-MS-Exchange-CrossTenant-Network-Message-Id: bf6dc84f-80b6-4f4b-1ede-08d5bc6bf25e
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 May 2018 03:03:35.4695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB0706
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4I34AF8000468

> From: Matthew Wilcox [mailto:willy@infradead.org]
> Sent: Friday, May 11, 2018 9:26 PM
> On Fri, May 11, 2018 at 03:24:34AM +0000, Huaisheng HS1 Ye wrote:
> > > From: owner-linux-mm@kvack.org [mailto:owner-linux-mm@kvack.org] On Behalf Of
> Matthew
> > > Wilcox
> > > On Fri, May 11, 2018 at 12:10:25AM +0800, Huaisheng Ye wrote:
> > > > -#define __GFP_DMA	((__force gfp_t)___GFP_DMA)
> > > > -#define __GFP_HIGHMEM	((__force gfp_t)___GFP_HIGHMEM)
> > > > -#define __GFP_DMA32	((__force gfp_t)___GFP_DMA32)
> > > > +#define __GFP_DMA	((__force gfp_t)OPT_ZONE_DMA ^ ZONE_NORMAL)
> > > > +#define __GFP_HIGHMEM	((__force gfp_t)ZONE_MOVABLE ^ ZONE_NORMAL)
> > > > +#define __GFP_DMA32	((__force gfp_t)OPT_ZONE_DMA32 ^ ZONE_NORMAL)
> > >
> > > No, you've made gfp_zone even more complex than it already is.
> > > If you can't use OPT_ZONE_HIGHMEM here, then this is a waste of time.
> > >
> > Dear Matthew,
> >
> > The reason why I don't use OPT_ZONE_HIGHMEM for __GFP_HIGHMEM	 directly is that,
> for x86_64 platform there is no CONFIG_HIGHMEM, so OPT_ZONE_HIGHMEM shall always be
> equal to ZONE_NORMAL.
> 
> Right.  On 64-bit platforms, if somebody asks for HIGHMEM, they should
> get NORMAL pages.
> 
> > For gfp_zone it is impossible to distinguish the meaning of lowest 3 bits in flags.
> How can gfp_zone to understand it comes from OPT_ZONE_HIGHMEM or ZONE_NORMAL?
> > And the most pained thing is that, if __GFP_HIGHMEM with movable flag enabled, it
> means that ZONE_MOVABLE shall be returned.
> > That is different from ZONE_DMA, ZONE_DMA32 and ZONE_NORMAL.
> 
> The point of this exercise is to actually encode the zone number in
> the bottom bits of the GFP flags instead of something which has to be
> interpreted into a zone number.  When somebody sets __GFP_MOVABLE, they
> should also be setting ZONE_MOVABLE:
> 
> -#define __GFP_MOVABLE   ((__force gfp_t)___GFP_MOVABLE)  /* ZONE_MOVABLE allowed */
> +#define __GFP_MOVABLE   ((__force gfp_t)(___GFP_MOVABLE | (ZONE_MOVABLE ^ ZONE_NORMAL)))
> 
> One thing that does need to change is:
> 
> -#define GFP_HIGHUSER_MOVABLE    (GFP_HIGHUSER | __GFP_MOVABLE)
> +#define GFP_HIGHUSER_MOVABLE    (GFP_USER | __GFP_MOVABLE)
> 
> otherwise we'll be OR'ing ZONE_MOVABLE and ZONE_HIGHMEM together.

Dear Matthew,

After thinking it over and over, I am afraid there is something needs to be discussed here.
You know current X86_64 config file of kernel doesn't enable CONFIG_HIGHMEM, that is to say from this below,

#define __GFP_HIGHMEM	((__force gfp_t)OPT_ZONE_HIGHMEM ^ ZONE_NORMAL)

__GFP_HIGHMEM should equal to 0b0000, same as the value of ZONE_NORMAL gets encoded.
If we define __GFP_MOVABLE like this,

#define __GFP_MOVABLE   ((__force gfp_t)(___GFP_MOVABLE | (ZONE_MOVABLE ^ ZONE_NORMAL)))

Just like your introduced before, with this modification when somebody sets __GFP_MOVABLE, they should also be setting ZONE_MOVABLE.
That brings us a problem, current mm (GFP_ZONE_TABLE) treats __GFP_MOVABLE as ZONE_NORMAL with movable policy, if without __GFP_HIGHMEM.
The mm shall allocate a page or pages from migrate movable list of ZONE_NORMAL's freelist.
So that conflicts with this modification. And I have checked current kernel, some of function directly set parameter gfp like this.

For example, in fs/ext4/extents.c __read_extent_tree_block,
	bh = sb_getblk_gfp(inode->i_sb, pblk, __GFP_MOVABLE | GFP_NOFS);

for these situations, I think only modify GFP_HIGHUSER_MOVABLE is not enough. I am preparing a workaround to solve this in the V2 patch.
Later I will upload it to email loop.

Sincerely,
Huaisheng Ye


> > I was thinking...
> > Whether it is possible to use other judgement condition to decide OPT_ZONE_HIGHMEM
> or ZONE_MOVABLE shall be returned from gfp_zone.
> >
> > Sincerely,
> > Huaisheng Ye
> >
> >
> > > >  static inline enum zone_type gfp_zone(gfp_t flags)
> > > >  {
> > > >  	enum zone_type z;
> > > > -	int bit = (__force int) (flags & GFP_ZONEMASK);
> > > > +	z = ((__force unsigned int)flags & ___GFP_ZONE_MASK) ^ ZONE_NORMAL;
> > > > +
> > > > +	if (z > OPT_ZONE_HIGHMEM)
> > > > +		z = OPT_ZONE_HIGHMEM +
> > > > +			!!((__force unsigned int)flags & ___GFP_MOVABLE);
> > > >
> > > > -	z = (GFP_ZONE_TABLE >> (bit * GFP_ZONES_SHIFT)) &
> > > > -					 ((1 << GFP_ZONES_SHIFT) - 1);
> > > > -	VM_BUG_ON((GFP_ZONE_BAD >> bit) & 1);
> > > > +	VM_BUG_ON(z > ZONE_MOVABLE);
> > > >  	return z;
> > > >  }
> >
