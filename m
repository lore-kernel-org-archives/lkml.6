Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751533AbeELLfL (ORCPT <rfc822;w@1wt.eu>);
        Sat, 12 May 2018 07:35:11 -0400
Received: from mail1.bemta8.messagelabs.com ([216.82.243.208]:20039 "EHLO
        mail1.bemta8.messagelabs.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1750905AbeELLfJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 May 2018 07:35:09 -0400
X-Brightmail-Tracker: H4sIAAAAAAAAA1WSa0wTaRSG+3Wm0yky62cBOVYhbHUTQUFRf4y
  JUWOimV/GNRuN1SiDO8uMvZFORYzxHhODoIgGFUFglxLBJggt6opBiqwu4gUvyA9vqbcI1BsI
  eImwHWbx8u893/Oe95wvOTRhvE+ZaCHbLbgcvM1MRZDiy6A22XprwDJztyeeLa7xUuyfjSJ7Z
  OdNPXvnfDHFPvIO69hznkYt+3j/Qvb4zv2I/fyhmFpo4Hwnk7i63gI99+/RzyRX4+8guWtlLX
  rO17aFq/80n9szGMP11cUvM1h0kiPdmZ2mE9ubclDmo4TsOy8KiR3orSkHRdBG/AxBz8kgoRa
  XEHT+80mvFCTOJeDC8ANdDjKEyQEtHOnMUl0PEfQ++aJXAIUToTV0L9xO09F4KoT8sxQPgWsJ
  6A/s1iqeKLwOhgr9pKKjcRqU5g0iVS+CjndNI+8k/gWON3tJJYfBa8DXOF6d9R5BoKeRUjwGP
  A+qd70b8SMcB4VPHo/kEzgWSgqLRhYFjKHiwk1C1THQ9XRIp2QivBxe+9cqErAZDtZaVEcc3C
  7dh5RRgPN10NvdhlSQCleqLhIq6NdBqOH8/8UZBBU+H6W6kuBiq0evplph8Ozm0ee9LUVaVcd
  DdV6QVHurCLj04g2pgknwd2cnykcpRd/9QdXToayhl1L1NKgs7yEUzeBx0HrsGVmGyGo0VRZc
  WYIreXZqSrpLyhDddl6yJafOZFPsgizzGYKNT5dT1jvtdSh8aNs1GnQODVaubkYTaK05hjmb2
  28x/pTu/H2zyMviOtdGmyA3o0k0bQYmrX3AYhznEjKE7D8kW/haRzHQkeZopkDBjJzJ22UpQ0
  VXUTLt9RfkEkbS4XQIplgmTzFhxSRudHyNGL352yjOFMUgjUZjjMwUXHbJ/SPvRrE0MkcxxUp
  KpORwf53UHV5CG14i0NGnLOHmvyHTDrRyRiV2B2NXLEniBrZVb7h+47Aha09iySaanGKtvSJ9
  Kdc7mxPo8Zd/lV62r1q/QNp7or5g+K85B47mN+QFEj+GTOzQz6cnP73W9Kqkful8j8glrNU0e
  CuCXZfJUytPvJ6r/21r11irtfRM36EV5faITW0B6/OWxSHPAnl5YOKYkrtmUhb51CTCJfP/AZ
  pKM57uAwAA
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-12.tower-128.messagelabs.com!1526124907!69274828!1
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
Thread-Index: AQHT6HxSRcNgfj0RT02kxPWBEx8Dn6Qp2QqggACtQICAAWwJoA==
Date: Sat, 12 May 2018 11:35:00 +0000
Message-ID: <HK2PR03MB1684BC9802BC2E5C1BF2DC74929E0@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1525968625-40825-1-git-send-email-yehs1@lenovo.com>
 <20180510163023.GB30442@bombadil.infradead.org>
 <HK2PR03MB16843E14AD56B3E546D9F52D929F0@HK2PR03MB1684.apcprd03.prod.outlook.com>
 <20180511132613.GA30263@bombadil.infradead.org>
In-Reply-To: <20180511132613.GA30263@bombadil.infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.120.55.174]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB0753;7:lpntgWc3AbAUesMBbZQZeCh5RpPvQN9BSYAhH2SoTtS5gQ4OL4V2bwCFiTiX5KsYsP2LaDWfok74gHnrrmAm2TMkWZZN5YplDA5FHQDbdL/5y/dMU1E9iidg57R+ljf/JRO0i9tzln9WLTW4SLy6efsrZikcpn5LwvF+pNmeA0wO2OGK+hQDaiI8zN1g257xM/7OdBJTxtyTHw5KfQgZ9iuHqxdFONws6iYF8OP7BHglX4XCHsULICjKdu8itScS;20:VYqBzg+PuW0M0VkkC62EXE9m/wJSG17pb4MC5cl14E3LjKllTBs58m67AwEfJpHjVCWdk0T+pCg587FDyK0Ui2GnkRXS2CAod4wDc80E0P3GBRsMT7Zk5CepOwhd4arzSqOdb3Smc5Y3b8IqoZYvUojG2Bj4U18OugceMAL+lofSAAyfgXf3Du46xndy8qgjf6eTwVNZj5ODgY03/bDhbAs3j95ORTvB+jfvqbImZZBXJ0LJSH3wZ4oh5wNcwKtPu8Cwt+0kzdczdowxyWMmFW5Yaenfv7ctvbVVULlReXCHUz72QdVn2vo+maGV4OInHAEVotWm9tJ2zpMAPjWT+g==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39850400004)(396003)(376002)(366004)(39380400002)(346002)(189003)(199004)(33656002)(76176011)(81166006)(93886005)(54906003)(6116002)(8936002)(8676002)(99286004)(55016002)(6916009)(7696005)(316002)(3846002)(229853002)(305945005)(106356001)(9686003)(14454004)(81156014)(5660300001)(6436002)(6246003)(478600001)(105586002)(53936002)(74316002)(86362001)(486006)(4326008)(66066001)(2906002)(102836004)(5250100002)(25786009)(3280700002)(476003)(7736002)(186003)(68736007)(446003)(26005)(97736004)(59450400001)(11346002)(2900100001)(3660700001)(6506007)(9126004);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB0753;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(4534165)(4627221)(201703031133081)(201702281549075)(5600026)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB0753;
x-ms-traffictypediagnostic: HK2PR03MB0753:
x-microsoft-antispam-prvs: <HK2PR03MB0753E24594E33C2BDC48F631929E0@HK2PR03MB0753.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:;
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(10201501046)(93006095)(93001095)(3231254)(944501410)(52105095)(149027)(150027)(6041310)(20161123558120)(20161123564045)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(6072148)(201708071742011);SRVR:HK2PR03MB0753;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB0753;
x-forefront-prvs: 067071EFC8
x-microsoft-antispam-message-info: PJhyWYaOmHR7VsT26FQEyWMfx+xomsauhYh4HoqPmPeMIFzv8KaRWJQIDXcpwPj0NewU1MXiOtaRFZYB602AueMg9+Bmw3IM9jkts0bdKMrGzlwPo69SImqdinsaSH9t58TDlY29wujuj9H+IlqRmx6VXq8z+l8JWrctuk94v8FxeWWOy+QJlae0gt3Nbwhr
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: aebc6dac-c669-4f5d-8c43-08d5b7fc6557
X-MS-Exchange-CrossTenant-Network-Message-Id: aebc6dac-c669-4f5d-8c43-08d5b7fc6557
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2018 11:35:00.0919
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB0753
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w4CBZFse028231



> From: Matthew Wilcox [mailto:willy@infradead.org]
> Sent: Friday, May 11, 2018 9:26 PM> 
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
I am afraid we couldn't do that, because __GFP_MOVABLE would be used potentially with other __GFPs like __GFP_DMA and __GFP_DMA32.
Let's go back to the previous example.
We assume ZONE_DMA equals to 0, and ZONE_DMA32 equals to 1. After encoding with ZONE_NORMAL (which equals to 2), we could get that.

#define __GFP_DMA		((__force gfp_t)OPT_ZONE_DMA ^ ZONE_NORMAL)
#define __GFP_DMA32	((__force gfp_t)OPT_ZONE_DMA32 ^ ZONE_NORMAL)
__GPF_DMA	= 0b 0010
__GPF_DMA32	= 0b 0011

We assume ZONE_MOVABLE equals to 3,
#define __GFP_MOVABLE   ((__force gfp_t)(___GFP_MOVABLE | (ZONE_MOVABLE ^ ZONE_NORMAL)))
__GFP_MOVABLE = 0b 1001

If we OR'ing __GFP_MOVABLE and either __GFP_DMA or __GFP_DMA32, we could get same result as '0b 1011'.
This is unacceptable, because inline function gfp_zone couldn't distinguish that is a request of ZONE_DMA or ZONE_DMA32 from parameter flags.

Once more, I think if we want to encode ZONE_MOVABLE to __GFP_MOVABLE, then the operation of __GFP_MOVABLE OR'ing with any other __GFP* would have risk.

Sincerely,
Huaisheng Ye

> One thing that does need to change is:
> 
> -#define GFP_HIGHUSER_MOVABLE    (GFP_HIGHUSER | __GFP_MOVABLE)
> +#define GFP_HIGHUSER_MOVABLE    (GFP_USER | __GFP_MOVABLE)
> 
> otherwise we'll be OR'ing ZONE_MOVABLE and ZONE_HIGHMEM together.
> 
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
