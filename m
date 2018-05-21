Return-Path: <yehs1@lenovo.com>
X-Google-Smtp-Source: AB8JxZq8OO+D/1Kz++2QmYzy5yjpBuH19+V546vxL1LKSlZV1JJ7wiUJFwh9zhx9UCugMTsUp7jA
ARC-Seal: i=1; a=rsa-sha256; t=1526925527; cv=none;
        d=google.com; s=arc-20160816;
        b=EY5wVzFqhUruTZiP9Y1LJX0ItZp/rFMhbKGfqLN0hbui3Yr9Jl9CmCoOqRvz4H7hrH
         mTx1SdBkHMgN0QhssjdFOgDpIjgJVSoi0og8YXpquOFVFusAv9nS4C9/mLcd47UVascZ
         FGjqi4Yf+oUGktp5jqySG3AnJCF33G4dt9YbERP3SWc/+dCVU8mlxOByZZoUtRlP/31J
         UpL1qbpa+ukMvwQFVeq938Dvjq8LGe/xUr4vAwO9WCdvPLnmSiwYNdZBUwjBFyqYMElb
         PyueiMbQsitk+cjq0jC4pfKcytmwN+p2z6OaiK3VW24MMj3m5Lb8XsHzNLMrTpxDdid3
         W08w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:message-id
         :date:thread-index:thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=6t5WR5hjN5Xb4a33xr8rcdnc+fEqVITo3g1LrEaZdEc=;
        b=fGp9jML8bHf1VfFTIphpHkuc4jGg16Q1hqrkzvJZFFMTecACEevpDMsxQY8C3uj1qB
         QJuVfNAhVHz3kd5EAroWoHJPZ51atN4CQA6Lut0hECf4gvLsugoOQY5bfeY5fBlHTBRk
         GxiNS0kKqDPfMdiRd9L+rsHBqET74MshZWTuz7gOh6SgPw0oTMTDur6sp0cTB6Icw3F5
         C4qdO7osDl7Z16ngo+AxOPZ7fkr8ZBX5pV2zR5B5xVbjyHLm/7U/XIyJ+oh/EvZf3r1T
         bQmXUQNutGabkKGJNMkmfj2pHvduvRnuKhQ0UsruNrNvgBED3ES37ukGCmEE6sUz3B+2
         6UNA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@LenovoBeijing.onmicrosoft.com header.s=selector1-lenovo-com header.b=o1G2ke0i;
       spf=pass (google.com: domain of yehs1@lenovo.com designates 216.82.243.195 as permitted sender) smtp.mailfrom=yehs1@lenovo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=lenovo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@LenovoBeijing.onmicrosoft.com header.s=selector1-lenovo-com header.b=o1G2ke0i;
       spf=pass (google.com: domain of yehs1@lenovo.com designates 216.82.243.195 as permitted sender) smtp.mailfrom=yehs1@lenovo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=lenovo.com
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTf0wbZRjH995d705Cya1AeCSwxMYfGVvJpmZ
  5E+O2RP+4ZDFR/1KYuCueXLP+gF43IBJD1xEXKLABFoYl1o1fgy4gdIpCQDunK2M2oJuyJQIr
  040ZQJzCQJl3PTb1/vo+z+f7Ps/3Lu+xpKGDSWfFEpfotAtWI51ASbdmCNNVlszdEZtlsb8nS
  ONTwxIeb6ygcKM7ymDP6R4an+m+QODAyHPYP/k0bj99E2Gv/wjCE7FOBn/3uZ/GPwXv6/BA2z
  CBp2r24g/cNQivrSj95VA9sdfA93dm8X1LdQx/sWmN4kdaggxf/2MH4s8vfk/xg5PlNP/bzWs
  U3xO6QvFjga8Yvv/SO/y51d18xXIq/3vflpeTcnQWu9lRckAnLaxeJAtPJpRcPzGEytEwW4kS
  WAP3C4KG2ltIK75GUD72GaUWFNdJQuX1SUYjNQT4zsVIrZhC4D56SSGPsDS3FSK/Xo2DFK4Bw
  aTnY1otSM7HQO16hFBdyVwehE65KVWncPkwH6wnNZ0N4drLukrEKgufgMXxfWpbz+2H1raF+F
  HEZYLvxlRck1watPiadaoGjoPWoSip6VS4HVuPj0HcqzAfytPaj4F/sG3DkgkTH1YhTR/XQdR
  TrMYE7hME1xY7aA1kQW+kcmP+Qbhb8fdG/zXodK9Smt4CXdUzlHa4j4TelakNkAHRT39mNHBF
  B5dHZ+KrDZwE661/EWo6A2eGs2sWzRND0B2q0h1H25v/83Ka3g6BwSVa09ug/aM7ZHP8w2yGy
  MlZKoCoLvSULDoPi04TzjY7LQWSyyZYrKadO3C2TZRloUC0CmY5O99h60PKdd2kPAPovOeFMH
  qUJYyp+vUiIteQZHa8VSoJsvSm85BVlMMog2WNoI8yZK5hs1MsEEvetliVO/8AA5toTNE3qFg
  vFwo22VKgoVH0DOtr93pJNhiq85IGyu6wi+lp+ibVyqlW6ZD94aAH/88EykxP1iMlmiGxUHTa
  LK7/8zmUxiJjsv62OiXRYnc93DenRCGUKMfC93OUKC7hX5RejkwJDaXOFty9r0j646goPP/Dk
  /OvrIy8dC/p255pn/fwkXxX4EXTifnxO7Tnmze2zo5W5Sy3CsWL1Qe3Rfa8/+6xsqE5U9uuXQ
  NFdVzj444/u/ozqoih6dJ7ZcWJr5/5wvtexoW8sqU9vTkL4ZGk3c823a1eGGu8sUn6Mt+TOy0
  xhbYmIyVLws4s0ikL/wBTrBvsOgQAAA==
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-8.tower-37.messagelabs.com!1526925525!100776753!1
X-Originating-IP: [104.232.225.2]
X-SYMC-ESS-Client-Auth: outbound-route-from=pass
X-StarScan-Received: 
X-StarScan-Version: 9.9.15; banners=-,-,-
X-VirusChecked: Checked
From: Huaisheng HS1 Ye <yehs1@lenovo.com>
To: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "willy@infradead.org"
	<willy@infradead.org>
CC: "mhocko@suse.com" <mhocko@suse.com>, "vbabka@suse.cz" <vbabka@suse.cz>, "mgorman@techsingularity.net" <mgorman@techsingularity.net>, "kstewart@linuxfoundation.org" <kstewart@linuxfoundation.org>, "alexander.levin@verizon.com" <alexander.levin@verizon.com>, "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>, "colyli@suse.de"
	<colyli@suse.de>, NingTing Cheng <chengnt@lenovo.com>, Ocean HY1 He
	<hehy1@lenovo.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org"
	<iommu@lists.linux-foundation.org>, "xen-devel@lists.xenproject.org"
	<xen-devel@lists.xenproject.org>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "konrad.wilk@oracle.com" <konrad.wilk@oracle.com>, "konrad.wilk@oracle.com"
	<konrad.wilk@oracle.com>, "boris.ostrovsky@oracle.com"
	<boris.ostrovsky@oracle.com>, "jgross@suse.com" <jgross@suse.com>
Subject: [RFC PATCH v2 06/12] drivers/xen/swiotlb-xen: update usage of address
 zone modifiers
Thread-Topic: [RFC PATCH v2 06/12] drivers/xen/swiotlb-xen: update usage of
 address zone modifiers
Thread-Index: AdPxLG9r48ANY+BQSoWslfGsqoInVQ==
Date: Mon, 21 May 2018 17:58:29 +0000
Message-ID: <HK2PR03MB1684F5870EE8D64A2B54635692950@HK2PR03MB1684.apcprd03.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [125.33.105.40]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB0690;7:1Tuwzd17ROMLv13Dnx0OcybdN/1/8WxJe1Vstr1c6PgbKHrAfzX66gATev6sCiWY46GS35RpBS9Bc2z7Y+U2CPSRl4idVZ0MuQIVXx6qylu/Ln+8jOoa5ckiHa+QMwFHGu8AJ8KKbWv2+DUHI5hPn3oODjsuLubB4ingVPKEVP4KcyD0RgyE6V1N91pFSdNiTEhsSwv2+z/+ajOMW7aG1bUy8Hh8GHihSunVUvbHWdVfas3UQric7FO3gmoRiL8f;20:vU1tTJgsWKjedxbmMGmZI6zZTUCUWkGEHp2jhhIW2OpPxqWMZaKV9sKdioEBnQtwWW6VMwl1YvBw4e8kAHGiaW4JyJ8+FZoGJQu78zA+NlVqFYJkWCJunVGbKGG5jVHkhw6FqXp9R6FPYPCxbgh9mUs3mkEEO5mDCioZiwVneRFS4ZveVImgq+qSX9GIjcfh7/wqosvl6BSG/R7Kbby6lgz1U0oDphTDjBQ3GH8onkh/INojjxCztdKjhUK3iRx0sBy0ReulW2y+lxnyQHU4fd/Cf2pAjsKE935fSmOhbgo9bfkDQxaZXbsoWrOiBklGcy5msuIP7zOTBFjhsH/aXg==
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB0690;
x-ms-traffictypediagnostic: HK2PR03MB0690:
x-microsoft-antispam-prvs: <HK2PR03MB0690BEA01D128571ABCD9A1092950@HK2PR03MB0690.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(3940261145250)(788757137089)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HK2PR03MB0690;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB0690;
x-forefront-prvs: 06793E740F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(366004)(376002)(39850400004)(189003)(199004)(316002)(68736007)(4326008)(81156014)(110136005)(14066004)(7416002)(6116002)(3846002)(3280700002)(74316002)(2900100001)(5250100002)(7696005)(81166006)(86362001)(9686003)(8936002)(97736004)(14454004)(5660300001)(33656002)(486006)(53936002)(8676002)(2201001)(54906003)(476003)(55016002)(66066001)(105586002)(99286004)(25786009)(106356001)(59450400001)(7736002)(6506007)(305945005)(186003)(26005)(3660700001)(2906002)(2501003)(478600001)(6436002)(102836004)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB0690;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: dMssCYWoL5RSsKj4FDDSvrkfZ5ry4BJLaI4aEaLKDiKIFQxNGLgcJ1rOkMVWLb9MIsZsPE8oXyQ7edxbwDlyx6bUJh5s1uQiKFmgKywVxL7+EWd4/T3SL84+TCWKwBbeQMOwdu9CuJr/1VPS8Nuod0yweQK/hHUhXmCu24RXNO9x3xDMvkhYf7qodGnxfSva
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 921704f0-e03e-4b97-319a-08d5bf44760f
X-MS-Exchange-CrossTenant-Network-Message-Id: 921704f0-e03e-4b97-319a-08d5bf44760f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2018 17:58:29.8838
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB0690
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601097461490729977?=
X-GMAIL-MSGID: =?utf-8?q?1601097461490729977?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use __GFP_ZONE_MASK to replace (__GFP_DMA | __GFP_HIGHMEM).

In function xen_swiotlb_alloc_coherent, it is obvious that __GFP_DMA32
is not the expecting zone type.

___GFP_DMA, ___GFP_HIGHMEM and ___GFP_DMA32 have been deleted from GFP=20
bitmasks, the bottom three bits of GFP mask is reserved for storing
encoded zone number.
__GFP_DMA, __GFP_HIGHMEM and __GFP_DMA32 should not be operated with
each others by OR.=20

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
---
 drivers/xen/swiotlb-xen.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/swiotlb-xen.c b/drivers/xen/swiotlb-xen.c
index 5bb72d3..00e8368 100644
--- a/drivers/xen/swiotlb-xen.c
+++ b/drivers/xen/swiotlb-xen.c
@@ -315,7 +315,7 @@ int __ref xen_swiotlb_init(int verbose, bool early)
        * machine physical layout.  We can't allocate highmem
        * because we can't return a pointer to it.=20
        */
-       flags &=3D ~(__GFP_DMA | __GFP_HIGHMEM);
+       flags &=3D ~__GFP_ZONE_MASK;
=20
        /* On ARM this function returns an ioremap'ped virtual address for=
=20
         * which virt_to_phys doesn't return the corresponding physical
--=20
1.8.3.1
