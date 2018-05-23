Return-Path: <yehs1@lenovo.com>
X-Google-Smtp-Source: AB8JxZrYZj6SC3/CjUu82U+TXrXSw71FgocwNzUnmp9EnMzhuuo/2P+d7RNoUkAjbGOTtEgKgnXJ
ARC-Seal: i=1; a=rsa-sha256; t=1527091655; cv=none;
        d=google.com; s=arc-20160816;
        b=l8cPujbLi9I1IlURukDqzlzNDWVXh+GJXY72DZ9Dj5ggc6qr10oDqIqoRFlGm6vc1k
         vnGCDV8rswkfeke3heoK3kRQZGPQ1XRGId0eVv1jKS9FrfVcXdS8LpWfJBQDICxdlNpJ
         1J9quqg9l16CtYJqKdQVFXbtizHLZlmTdoRHW1PbDsfYILpR56xc+dfbtHGWONnxkSqR
         EcaK74lojOWh6UTTxyko8mLCeApGUZsQxnJPkUl46N3OqOoR+6HR0egvyEWnlX9Y/UdJ
         OZQ96VbZXp5OZchFH3t5+XOg5U+su08cRk3IYX+rLX5miBOTX3KAsAcdpCYMFA/EkRq6
         oEYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=BEBlT4DvJPFsNDnF0alqXJ0eQ6urfegqF4dPE2qbdF8=;
        b=UaIJrNTGKJ9K4zWjbuDdE90+InbI5NWbiK7DUznSkZM60S3aj+ZGl67ZK/R0Jxj6fA
         2cpsl7WCMEdwM0vwiyLgZw+gHvAOCNWG9Dpmr7TWip8Im8564IxBc4nXsRTq63xX+SCR
         Rha/lZCyqSMa4DMeltaMIeOJXTgbpfJv/fFOmJRUfZ6kE9GbICiQOcRaGyngjjF5p+la
         XBvRYto1wzNwMQaqtaxH0oY0q04woHIRKMfmQqL7C3WQvsh8d25pra2bzGJBaQYUjFxp
         BQDumg0hnH5yaeTr+ja9SGAzLtP405tgvudKMhKvvypy5euAtBilTQDxsb6whB0d9F5X
         XDdA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@LenovoBeijing.onmicrosoft.com header.s=selector1-lenovo-com header.b=nMmGaDbu;
       spf=pass (google.com: domain of yehs1@lenovo.com designates 216.82.251.3 as permitted sender) smtp.mailfrom=yehs1@lenovo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=lenovo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@LenovoBeijing.onmicrosoft.com header.s=selector1-lenovo-com header.b=nMmGaDbu;
       spf=pass (google.com: domain of yehs1@lenovo.com designates 216.82.251.3 as permitted sender) smtp.mailfrom=yehs1@lenovo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=lenovo.com
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTfWwTZRzH+9xbb0tPj27LfkyKrEAig1XKNLk
  EY0xI9P4yw7+MW4TbPNtq2827DkYIuo1MHNZlFFNgDhgqeyk1Dd2LbBg24dDVYdD5xstCYVv2
  SnSZRrYWp709A/W/z/P7fvP9fZ/LcyxpDhhzWLnSJyteyW1l0inn5B0i//IhumjzXz2M0BQJM
  8LHF5zCkeqrRmH/JxFGaD9zmRCa+7YK/qYaJAyNthmFH3qbGOFW+G9aOHf6AiHM/NlCCh9V1y
  MhOZ8S7nUeJp57VOxoyxOjoTpGjM4FjOLA0SQl9h0PG8XD11qReGn2R0o8f72KEa80a0axY3C
  v2JV4Vqy9lyX+Hl1dyL1Cu7wlZZU7aWdDJL+8xVJZPdFDVKF49kGUzpr5MQSHosM0PlxCsDhw
  hTqI0liKbyPh7C8bsVBPQP9P1yh8iCOo6/7QqLsYfgPE7v5M6pzJr4NI/bBRN5F8PwO14+NLU
  Rl8ISS1WgqbtsPdgTYG8xaIvxtl8Lr1MN6L/RxfDL1d3y3NzfwbEDpwNMUsm8Y/Bcci6/Qx4i
  0QHIkTOpN8NhwPNtI6A8/Dp19cJTFnwdTo4vI8F/rnpgjMFhg6+T7C3EDD4pfbMdvh6/Y+Uu8
  PfDsDyRGNwUI3grMTazHnQc3QkaU+iH8Jfu18FY/fhBO3ZpZ3vQDBmq+Wd62G0Ad3KJwZJeF+
  Yv9y5ir4vHOBbEC2xv/cAfMmaD4/x2DeCC2nZsjGpc+yAmLHxqhmRIXQE6qs7JKV/IICW4nic
  jh9Hsnlzrfbt9g8sqpKDtktlai20jJPFKVe5jsGAzqHYqeKLqKVLGHN4nY20EXmR0rKXtvjlF
  TnDqXCLasX0SqWtQI3pmsrFNkhV77ucqee9wMZWJM1k+vTZU4tlzyqy4Glb1ABG2zx+0k23Bn
  wk2bKW+aVc7K5Xt3K61Znhfdh0INfZQhZcjI4ZDAYzKZyWfG4fP/Xp1E2i6wZnKanmFxe38N9
  06kqRKrK962kXsUn/SvlVKHup2NrVp68OTlfGE/kJiRB6yrvSN92fywYmDDnup4sHgnHvHWlb
  2u/le6dmCylZgODt9MyQ88XK/MJU+D06OPPbLM07p76drbixY5cS5Kg1nx2xrFh62PTgzf/WP
  D3rK9eyAub2l8OuH022pY4odUOH9jEaT1vae7W9/ZZ7DfcVkp1SvY8UlGlfwCu5DpFJQQAAA=
  =
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-7.tower-168.messagelabs.com!1527091649!70296938!1
X-Originating-IP: [104.232.225.2]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Huaisheng HS1 Ye <yehs1@lenovo.com>
To: Michal Hocko <mhocko@kernel.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "willy@infradead.org"
	<willy@infradead.org>, "vbabka@suse.cz" <vbabka@suse.cz>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>, "alexander.levin@verizon.com" <alexander.levin@verizon.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "colyli@suse.de"
	<colyli@suse.de>, NingTing Cheng <chengnt@lenovo.com>, Ocean HY1 He
	<hehy1@lenovo.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org"
	<iommu@lists.linux-foundation.org>, "xen-devel@lists.xenproject.org"
	<xen-devel@lists.xenproject.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, Christoph Hellwig <hch@lst.de>
Subject: RE: [External]  Re: [RFC PATCH v2 00/12] get rid of
 GFP_ZONE_TABLE/BAD
Thread-Topic: [External]  Re: [RFC PATCH v2 00/12] get rid of
 GFP_ZONE_TABLE/BAD
Thread-Index: AQHT8fwDC41BG7Nw7kKYsFRFURgRZqQ9b40g
Date: Wed, 23 May 2018 16:07:16 +0000
Message-ID: <HK2PR03MB16847646E90A10E2D48CEA8E926B0@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
 <20180522183728.GB20441@dhcp22.suse.cz>
In-Reply-To: <20180522183728.GB20441@dhcp22.suse.cz>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.120.56.60]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB0722;7:Gu6nytvTG5BB13LB5HLKPOw8wQWz/A/haJGuy3gqfvVlpTQGHDURXXjz9VWY+ugU/s2oP73x7BBuuCjQunolIi+mpR/n7jIM8x2OD8QuQUmCZx7tKyIMBwOjG+eo9lf5KbQr0yUeYGdCIYFDSQ+KAjPofdnfYOZsmLYqMBNj49ylmbZZTTobC0o4cRSqwTFoR6K1SeCOvWRh5GjVtOQ1lpsbvzsjd8ATU2Nu5H9Ca9iR7qsNWeA8E1rlxp38ZUOJ;20:NO0crhAf8JjiTZ/slY7hRP0IP5Tdal0hc5SDJJqcJm7u6L1p5/WmSPj1cXKRax4rIO6yV5iFNm6+6fcjMLeNmSCB4/HLdeTI8gulTnMgKuwvxaSeVMrYNDucGiFJKmZZMtrPcNf7J+1mbQprzR+t3932zpswZI9D+SIXciscXgOQlr8UIvcEdFpJsupoziQMCoDVCtaZ1CgaWJd6qokTwk84zuoOdnayqaP2BNFF3RPlBWzEChATc8096k1kJpVGyCVJqvzjGWSjlYFD1496ueBkuYBMywh3T1HQXEP8nmpI9f5qvGG0mFf6X/M/7CNa33ENyGiujgu6/+rZAZWSSQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39850400004)(346002)(376002)(39380400002)(396003)(366004)(189003)(199004)(377424004)(81166006)(81156014)(2906002)(575784001)(486006)(76176011)(59450400001)(55016002)(316002)(6506007)(5250100002)(97736004)(54906003)(99286004)(26005)(86362001)(5660300001)(186003)(229853002)(7736002)(68736007)(74316002)(8676002)(7416002)(6916009)(11346002)(102836004)(476003)(446003)(6436002)(7696005)(3280700002)(8936002)(3660700001)(305945005)(478600001)(14454004)(33656002)(105586002)(106356001)(6116002)(3846002)(25786009)(4326008)(2900100001)(53936002)(6246003)(9686003)(66066001)(26583001)(9126004)(21314002)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB0722;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB0722;
x-ms-traffictypediagnostic: HK2PR03MB0722:
x-microsoft-antispam-prvs: <HK2PR03MB072287DDAABA5E1B717265E5926B0@HK2PR03MB0722.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(3940261145250)(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3231254)(944501410)(52105095)(93006095)(93001095)(3002001)(10201501046)(149027)(150027)(6041310)(20161123558120)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123564045)(20161123562045)(20161123560045)(6072148)(201708071742011)(7699016);SRVR:HK2PR03MB0722;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB0722;
x-forefront-prvs: 06818431B9
x-microsoft-antispam-message-info: r8mQ2D+AqE1rcKFNp7jXNmaIcRtdGjosqE+XVE1htDKOdZKdtNvuR8+zKbGPOz8owJ96spx/NQoJ0LmxUrtQOY7TsJE0Yro0tChlio51pADKtkqOKC6GZNIyUOwhqxdNSvghZb14zE854y/vA7oeAvlviWhHCJFQgWXBXPMBdLS5bFm8DG3bYjSot261J8A9
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: cfad0748-6b4f-40ae-7683-08d5c0c74174
X-MS-Exchange-CrossTenant-Network-Message-Id: cfad0748-6b4f-40ae-7683-08d5c0c74174
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2018 16:07:16.9757
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB0722
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601087516393165793?=
X-GMAIL-MSGID: =?utf-8?q?1601271659760934212?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: Michal Hocko [mailto:mhocko@kernel.org]
Sent: Wednesday, May 23, 2018 2:37 AM
>=20
> On Mon 21-05-18 23:20:21, Huaisheng Ye wrote:
> > From: Huaisheng Ye <yehs1@lenovo.com>
> >
> > Replace GFP_ZONE_TABLE and GFP_ZONE_BAD with encoded zone number.
> >
> > Delete ___GFP_DMA, ___GFP_HIGHMEM and ___GFP_DMA32 from GFP bitmasks,
> > the bottom three bits of GFP mask is reserved for storing encoded
> > zone number.
> >
> > The encoding method is XOR. Get zone number from enum zone_type,
> > then encode the number with ZONE_NORMAL by XOR operation.
> > The goal is to make sure ZONE_NORMAL can be encoded to zero. So,
> > the compatibility can be guaranteed, such as GFP_KERNEL and GFP_ATOMIC
> > can be used as before.
> >
> > Reserve __GFP_MOVABLE in bit 3, so that it can continue to be used as
> > a flag. Same as before, __GFP_MOVABLE respresents movable migrate type
> > for ZONE_DMA, ZONE_DMA32, and ZONE_NORMAL. But when it is enabled with
> > __GFP_HIGHMEM, ZONE_MOVABLE shall be returned instead of ZONE_HIGHMEM.
> > __GFP_ZONE_MOVABLE is created to realize it.
> >
> > With this patch, just enabling __GFP_MOVABLE and __GFP_HIGHMEM is not
> > enough to get ZONE_MOVABLE from gfp_zone. All callers should use
> > GFP_HIGHUSER_MOVABLE or __GFP_ZONE_MOVABLE directly to achieve that.
> >
> > Decode zone number directly from bottom three bits of flags in gfp_zone=
.
> > The theory of encoding and decoding is,
> >         A ^ B ^ B =3D A
>=20
> So why is this any better than the current code. Sure I am not a great
> fan of GFP_ZONE_TABLE because of how it is incomprehensible but this
> doesn't look too much better, yet we are losing a check for incompatible
> gfp flags. The diffstat looks really sound but then you just look and
> see that the large part is the comment that at least explained the gfp
> zone modifiers somehow and the debugging code. So what is the selling
> point?

Dear Michal,

Let me try to reply your questions.
Exactly, GFP_ZONE_TABLE is too complicated. I think there are two advantage=
s
from the series of patches.

1. XOR operation is simple and efficient, GFP_ZONE_TABLE/BAD need to do twi=
ce
shift operations, the first is for getting a zone_type and the second is fo=
r
checking the to be returned type is a correct or not. But with these patch =
XOR
operation just needs to use once. Because the bottom 3 bits of GFP bitmask =
have
been used to represent the encoded zone number, we can say there is no bad =
zone
number if all callers could use it without buggy way. Of course, the return=
ed
zone type in gfp_zone needs to be no more than ZONE_MOVABLE.

2. GFP_ZONE_TABLE has limit with the amount of zone types. Current GFP_ZONE=
_TABLE
is 32 bits, in general, there are 4 zone types for most ofX86_64 platform, =
they
are ZONE_DMA, ZONE_DMA32, ZONE_NORMAL and ZONE_MOVABLE. If we want to expan=
d the
amount of zone types to larger than 4, the zone shift should be 3. That is =
to say,
a 32 bits zone table is not enough to store all zone types.
And the most painful thing is that, current GFP bitmasks' space is quite
space-constrained it only have four ___GFP_XXX could be used as below,

	#define ___GFP_DMA		0x01u
	#define ___GFP_HIGHMEM	0x02u
	#define ___GFP_DMA32		0x04u
	(___GFP_NORMAL equals to 0x00)

If we use the implementation of these patches, there is a maximum of 8 zone=
 types
could be used. The method of encoding and decoding is quite simple and user=
s could
have an intuitive feeling for this as below, and the most important is that=
, there
is no BAD zone types eventually.

	A ^ B ^ B =3D A

And by the way, our v3 patches are ready, but the smtp of Gmail is quite un=
stable
for some firewall reason in my side, I will try to resend them ASAP.

Sincerely,
Huaisheng Ye
