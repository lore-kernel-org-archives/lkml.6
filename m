Return-Path: <yehs1@lenovo.com>
X-Google-Smtp-Source: AB8JxZpZlfDi/lBSYi/J3R/QSKuDvWGitqEPW1azfVRuSVb4s/04Z0hq002I8yMLAwGT9oJIrhCz
ARC-Seal: i=1; a=rsa-sha256; t=1526984288; cv=none;
        d=google.com; s=arc-20160816;
        b=B2wBQ6tQuQ6ZBNmZGoPO5/zSbWo3M+6NPpMa8XxwKBb5h5NOUryRss5O+2NZJeg0Sg
         zWt4RKH3KU+yttlaRW0pPW51/IyeoR3hs8A0WC4rr6lJwml/e8fB+rZUvGt3ATlk+KfC
         lME9u6oHebycIup+3hdRp4rQt1f6IPs8tUd/D9ZknTWB2JxHYVM7wk2dpjpFJJlKxtP/
         lt5d5ft9GLJdXUA04Q7tV9eztJXIx95Hcm38oVx3cvzGxgYfiE/J2hm0m4aWeSHLsYJH
         E8IaiMGZSKv6RpzMOrN5bYfZhSrPI+Py95MKBIw8Jhg550pON1WrxxSZ9mOer3X2qATw
         ee4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:in-reply-to
         :references:message-id:date:thread-index:thread-topic:subject:cc:to
         :from:dkim-signature:arc-authentication-results;
        bh=oeWQZ8f49OpYkHUvfXo7FjwJEWYpA0LcSVKkaUbhk4U=;
        b=e5D9HyAaTpSV6qxXMEgOU4YW//a3TXidh5yFUNdmg2Al0LzRMI8g2v6J33+aI56vXU
         46sa02jHjURo2s0kAvmbDS1y1mmO3rupOqxeH+r3WJb9sIxo4kBoRbKV6PqOxvp1bZFG
         mDX+YaE1f/uy89fMKf9apreAYxfgV3Gu2VZMt2C6/oOCSOL42x6vUC/5/kzS0+Xp2K7/
         5gdQJ4v1TOhdRueycyfolz+6NBRX+GESdbJZaDALeQIiWlB1vw/VZuxlEuzlMzA5oMde
         YHBnDIWCPBPpJf+MX50Fw3V0bU5FndjWi8yUKTbHxl47SHPTk2VL6c8CxnNAi0lcn7qh
         SfmA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@LenovoBeijing.onmicrosoft.com header.s=selector1-lenovo-com header.b=FUhHL0eQ;
       spf=pass (google.com: domain of yehs1@lenovo.com designates 216.82.251.7 as permitted sender) smtp.mailfrom=yehs1@lenovo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=lenovo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@LenovoBeijing.onmicrosoft.com header.s=selector1-lenovo-com header.b=FUhHL0eQ;
       spf=pass (google.com: domain of yehs1@lenovo.com designates 216.82.251.7 as permitted sender) smtp.mailfrom=yehs1@lenovo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=lenovo.com
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTf0xTVxTHe9977Xs4qo9HSc+Y1a2JicMVBfb
  HDS7ELFl8+xGz+AdL1DDb+dY2toX1FYGYOH7MkW1IELfiGEqnMpBUCW23oTNliLKpm251EOcc
  BKEblAmomA7L3N7rQ7f99znn+z3nnnNzL0NyQTqTEco9gttldhg1SyjbxChhKpomt67z3uJwS
  5dfg4+Ebbip6gqNa452afClhiME9nbrsa93Pa5rqUY4MtZB46unWzR42P+3Gve0hQk8Ur8BR7
  72EbhvdlyNg4GPSPxJVT3CiT8lWzx0gMCJ+HvUBh3vP+xH/KnmX2k+2JHFB+400vz05cs0/+3
  BBMX3HvLT/IFr7Yjvn/2J4mfCgxq+KzRI8d/5zkkFl3bzn98v4PfGM/i7gRWvpm1R212W4vLt
  alt0cIYuCaaUR/dWoUo0Qb+PljAcO47g8PcPkBL0I7j4YYyQA4rtIGG0Y3jRVk/AD3P7SSUYQ
  TC5b0YKUhgN+zRc+GMoyTqJr7fXJk0kO09D8MwALQvp7C740h8iFFMZ9PVUSsxInAv1Q5vlNM
  Wugqmqc0hmLbsN4vvbFg/zIfjl5ila9qewedBWvU32INYA3psjyZYkq4dD3ma1zMCycOzMFVL
  hDJgce6CWSxG7GaZDRUr6Kbg3+g2lsAEirR8k1we2QQ1HEzWkEnyB4Pbc+UVXFgzGbpByI2B3
  QqK3QklvBG/1AKHwCujcN0optQESuv6KUIp/OcTPr1Hys2rovHctuQvHWuBEwt6ATM3/WUHhZ
  8D31R2Nwmvgs0+nyObktaTBhY/HKR+iOtFqUXDvEtymXJxtcdutNo/TbHeYcnJys52CKJqtgs
  NsEbPfKHYGkPSA31apUA/qbnrpLHqcIYwZ2sIouZVbaineUWEzi7bX3aUOQTyLljOMEbSv3JK
  0NLdgFcrftDukX/BQBibVqNOqZFkrlpidot2qSBeRifGHGutIjnIVu4RMvfZn2cTKJlup61GL
  h38pggyZ6VqkUqm41BLB7bR7/q/HkJ5BxnTtdrlLqt3leXRSTBqCkIb4sT05hMf8r5RZiTbtj
  sy/Q7uIY5F8btlkXtPtPdGN7Mp83ctF+XmPvSA8z8zeWHjLGk4vU/2+dNPKd1V3fc9u6Z86Pb
  /uyRN96vU1+sboTubFhdULQ8Oesav3J8IqrqiWqFi74/pcoWgg6dKT3QVP7CHSYvrW5wqWGX6
  rG6jVTbSuLTuoWUUMF752vMBIiTZzThbpFs3/AH7jxqxGBAAA
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-10.tower-143.messagelabs.com!1526984282!7012542!1
X-Originating-IP: [104.232.225.2]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Huaisheng HS1 Ye <yehs1@lenovo.com>
To: Christoph Hellwig <hch@infradead.org>
CC: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "mhocko@suse.com"
	<mhocko@suse.com>, "willy@infradead.org" <willy@infradead.org>, "vbabka@suse.cz" <vbabka@suse.cz>, "mgorman@techsingularity.net"
	<mgorman@techsingularity.net>, "kstewart@linuxfoundation.org"
	<kstewart@linuxfoundation.org>, "alexander.levin@verizon.com"
	<alexander.levin@verizon.com>, "gregkh@linuxfoundation.org"
	<gregkh@linuxfoundation.org>, "colyli@suse.de" <colyli@suse.de>, "NingTing
 Cheng" <chengnt@lenovo.com>, Ocean HY1 He <hehy1@lenovo.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "xen-devel@lists.xenproject.org" <xen-devel@lists.xenproject.org>, "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>, Thomas Gleixner
	<tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin"
	<hpa@zytor.com>, Robin Murphy <robin.murphy@arm.com>, Huaisheng Ye
	<yehs2007@gmail.com>
Subject: RE: [External]  Re: [RFC PATCH v2 02/12] arch/x86/kernel/amd_gart_64:
 update usage of address zone modifiers
Thread-Topic: [External]  Re: [RFC PATCH v2 02/12]
 arch/x86/kernel/amd_gart_64: update usage of address zone modifiers
Thread-Index: AQHT8bCxPP1RFiGBikCAC5+qplwdk6Q7hRrg
Date: Tue, 22 May 2018 10:17:50 +0000
Message-ID: <HK2PR03MB16847D58C0B62ED73DBD1B2392940@HK2PR03MB1684.apcprd03.prod.outlook.com>
References: <1526916033-4877-1-git-send-email-yehs2007@gmail.com>
 <1526916033-4877-3-git-send-email-yehs2007@gmail.com>
 <20180522093806.GA25671@infradead.org>
In-Reply-To: <20180522093806.GA25671@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [123.120.65.17]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB1396;7:8zGa8oo1CAxYhlUzPYZAVxumxY7dLbR3wWd91Pc9Dx+Me1cBue+/MUSuxw85JmR29WrvuT0CozLk7EAF92H1IUjKn6srFxo7To5rcFEYrMQhdvpIyUbm3lEJnVe1hadTcy4wHoC/mjkdZRuYEGRBCDQJAVoSOsSBQHtpyEXoTocVBAy9u4qMups9o7WkwDNQTILKiZio9gtMFQpV/pibA7V5sXwe5beLynFsJKSmAl10RSRRPXyajIiSSQy262eg;20:55rAwjOiP44noh23CNct7TmaoVdWzjA1qFTliHxrOBy3vSc6bGdjNbPRRB2fL35WHyKVDpQmjpNEz8jsr4wGWIT5TV+kpu0JuUZd1Snyr8zrmgaBa6Emb9zbL41V/TciFQII4milUb4NNzs5cjDfywufJYjsP0zD7mMEs4PNyhLrjExk+HqQDKktSYOLg43GbvgM9jXZm0VSoHl/HRLPMGeKr+EqiHSKa3EXYa9fISOuI8mFS2GA+5+T0BHnsS8Tu9wNjuhWtPP9SjQlRPx0RXmYj+s1Nl4ZfLLmE518fauMR6qTVBlOLDrz901dxwCkgUpZCylBrnBLft1FnfGlZw==
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB1396;
x-ms-traffictypediagnostic: HK2PR03MB1396:
x-microsoft-antispam-prvs: <HK2PR03MB1396F662005BFCA6DDFD91E792940@HK2PR03MB1396.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(3940261145250)(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(5005006)(8121501046)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123560045)(20161123562045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HK2PR03MB1396;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB1396;
x-forefront-prvs: 0680FADD48
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(376002)(346002)(39380400002)(396003)(366004)(39850400004)(189003)(199004)(3280700002)(3660700001)(6436002)(446003)(7416002)(316002)(6916009)(54906003)(5250100002)(5660300001)(86362001)(7696005)(11346002)(229853002)(76176011)(14454004)(66066001)(2900100001)(476003)(6506007)(8936002)(2906002)(186003)(486006)(102836004)(26005)(99286004)(81156014)(81166006)(53936002)(8676002)(25786009)(68736007)(6116002)(3846002)(33656002)(97736004)(478600001)(6246003)(305945005)(7736002)(4326008)(74316002)(39060400002)(9686003)(106356001)(55016002)(105586002)(9126004)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB1396;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: tqYgGupvna3GLYswcX6nwPcHzo0bXesaax/wjfJ/vu3K0xgcrUe2SaeOPntQjLgF74yo5UrOl3adNg4EYOUtNJi5LY7474NGRCJWYFXbKbRF8cruSoWJSliwCkG6VPqqUwQLuLqtkpY8MxmCpTogcJf/9Em608FULfCbErUsAEfQzpkZNDi26vUflL9WA2E0
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 08b83da7-5735-4644-2675-08d5bfcd460a
X-MS-Exchange-CrossTenant-Network-Message-Id: 08b83da7-5735-4644-2675-08d5bfcd460a
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2018 10:17:50.4542
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB1396
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601087527015520115?=
X-GMAIL-MSGID: =?utf-8?q?1601159077725036927?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

From: owner-linux-mm@kvack.org On Behalf Of Christoph Hellwig
>=20
> This code doesn't exist in current mainline.  What kernel version
> is your patch against?
>=20
> On Mon, May 21, 2018 at 11:20:23PM +0800, Huaisheng Ye wrote:
> > From: Huaisheng Ye <yehs1@lenovo.com>
> >
> > Use __GFP_ZONE_MASK to replace (__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32=
).
> >
> > ___GFP_DMA, ___GFP_HIGHMEM and ___GFP_DMA32 have been deleted from GFP
> > bitmasks, the bottom three bits of GFP mask is reserved for storing
> > encoded zone number.
> > __GFP_DMA, __GFP_HIGHMEM and __GFP_DMA32 should not be operated by OR.
>=20
> If they have already been deleted the identifier should not exist
> anymore, so either your patch has issues, or at least the description.

Dear Christoph,

The kernel version of my patches against is Linux 4.16, the most of
modifications come from include/Linux/gfp.h. I think they should be
pushed to Linux-mm, so I follow the requirement of maintainers to make
patches based on mmotm/master.

I just checked the current mainline, yes,
(__GFP_DMA | __GFP_HIGHMEM | __GFP_DMA32) has been deleted, I can
rebase my patches to mainline, and resend them to mail list.

Sincerely,
Huaisheng Ye
