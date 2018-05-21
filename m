Return-Path: <yehs1@lenovo.com>
X-Google-Smtp-Source: AB8JxZoBARAesc4Xuw1rIKkXvZbprB+/Gjv4RLwTtZUO2eUySDVm4BFGsKahA8zMbGij7VQQ7U/C
ARC-Seal: i=1; a=rsa-sha256; t=1526926022; cv=none;
        d=google.com; s=arc-20160816;
        b=Q8Oo6N1vqN8nOsVg5B3Z07N3O0cOWgE8lnjlUKducldd3AloUpL3aWsANF/ZhbMAyn
         6FHyIoV+BTnw3E/b4azJLwMqfyoW56iPwmeShsfPKwX3pOTUueBcMLTXUA3y8NQp2Oas
         wGpTXpASZykf8G7RkN26oE++QZ0uQYyjj53tbck9O5cgKdobmH08iUJ5iLG01CMilg/C
         KWVOkC8WDwWCqvimgiPdpXG01gYlMGl4lL6lXd/VD+MvxAYDe5S/KCWgi07i/QsZEHa3
         V2gGYDnmWItu2Ar3gp1PygTXYqQPZdKhXuEf769jesZh+cDgzQvb7ejs3WCX+tl615ai
         QdvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:message-id
         :date:thread-index:thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=L8Af918tH9mW1jC9uoN5F+2XnUGKsXp033K0w0x+AV8=;
        b=cci97HM1I9WeQCjpNiZ1Le+mAkf2D+erjkTIcz8wI/ebyIq4HRmdOdBRffCa63Wxia
         +TOQ+xsQCj76gjck1IIh/jlP+VYfi+cnzzW0ed4v29NSUChqZN9BYIKl3/0c2yaJqpHo
         VP/tWbU7aeSroc1b4e/WTydDyHehL5pPDyyK00uSEA0J656H84VY+opwufH1DoItwqDM
         29G3UIfHUPeSOj40KKez9pFX3ouRQq7kXmwHEj5nuKXJz/m+7sYLLZe3MW62FK53Ngyi
         hnxRVMvl1+95igGLg3lT8xU8VXctwYit86Xu0axr/xEduMvA95mDJoDz+bydjXf8/+nC
         Q/Vw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@LenovoBeijing.onmicrosoft.com header.s=selector1-lenovo-com header.b=lePPFJHS;
       spf=pass (google.com: domain of yehs1@lenovo.com designates 216.82.243.198 as permitted sender) smtp.mailfrom=yehs1@lenovo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=lenovo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@LenovoBeijing.onmicrosoft.com header.s=selector1-lenovo-com header.b=lePPFJHS;
       spf=pass (google.com: domain of yehs1@lenovo.com designates 216.82.243.198 as permitted sender) smtp.mailfrom=yehs1@lenovo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=lenovo.com
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTfUxTVxjGe+63hLtcLjDeNWJmkwWpwiDL8CY
  km5vZcv/YEjOnyWAZtttd29kPdm8h3Uc2qtMgk48pgcGKVq1YGQ6oBclKdOlwGUqCMqboNhuo
  bgMdSjMHGQmut1fd9t/zvM/vvOc9J+cwOB+m9YzkcUuy02Q3UGmE9fcprOBsGl5e5JtfL/h6u
  inh8Gmr0Oodo4Wby62EsPNIDyUc//IsJvjPlAp7fTuQMB4P0sIPX/so4Vr3PVIYPHoaE2ING4
  TOu7dpYXegDxO+8DYgYWkxSSyE92PC+dpmckOm6A9ViZ8M/0GKJ4NGMdS1hxJDiX20+P3nS4R
  4pqObFvdPHkPit3cmCDFypYYS529cJcSe8I+EOOofpsWT5z8Q+/9+Rty1kL0po4y0Oc0uzzbS
  OrjjZ7LypzTPgctBvAb9ydShNIbnriPoG4iSmokiaGzxItUQXBCHxFcXaS1pwOCb7+KYZmIIb
  kwFk9gKhuLyYeTWJVwNsrhmBFd29lGqwblGGoZ2HaJVKpN7FQLjg6kVWdxrMBMZwjVdCJ2Jrl
  Sd4J6AxhP1KZ7lXoe5Wq2OuFxomY5hqsa5HOhoaSdVDRwHgaExXNPZMBNfTtaZJP8KzIXf0Mq
  rwRc5eh/JhfGDn6bOBlwTCW29FzHNDCC4eucYpVFG6B2pSzUCbjscH5U0pg7BZP2t+8wq6Kqf
  IrQghEPvYozQgpUwdupXWgumSYgf7Eh14jkznFiyafU4gguBJVK7Fj38MrEHNaG17f85nabXg
  T+SoDS9FjoP3cTbUzeTASNt1wk/IrrQGkWSqyW54KmSQrNss1jdDpPNXlBcJBQ6JEUxWSS7ya
  wUvulyhFDyBX+s06FBdLezPIoeYzBDNrv8LlbOP2J2vfWe1aRYK+Qqu6RE0UqGMQArrMDL+Qx
  Zskiet2325Dd4EAOTbshiS9SYVSpNDsVm0aJzqIDpDu/bi/OE0+WU9DnssyrEqZC1yvmwxYPP
  NI5y9Zks0ul0fHqlJDts7v/nsyiHQYZMdrPaJd3mdD/caTY5BJYcojZ6ryw5hNv0b6SvQYEj0
  Y/mXya8Yv+HngEeG+1Q1m8seXrL4oVY0daN0/zmdVOzTef+enSuDLltW5u2bfJl8Hn5v7UdeG
  7LYX2e8dT78nAxq6/2RmouV2dvHykllSfll975zO7p9xkfXzU51PzC6onRVqdiuZao5rPyay/
  tXrhdUfHiDFua5088X7TGZSAUq6nYiMuK6R/2jLC3RwQAAA==
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-16.tower-144.messagelabs.com!1526926021!25956812!1
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
	<linux-btrfs@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "zhongjiang@huawei.com" <zhongjiang@huawei.com>, "minchan@kernel.org"
	<minchan@kernel.org>, "dan.carpenter@oracle.com" <dan.carpenter@oracle.com>, "rientjes@google.com" <rientjes@google.com>
Subject: [RFC PATCH v2 09/12] mm/vmpressure: update usage of address zone
 modifiers
Thread-Topic: [RFC PATCH v2 09/12] mm/vmpressure: update usage of address zone
 modifiers
Thread-Index: AdPxLkxZEy+b+TRpTsGychxB72xX5g==
Date: Mon, 21 May 2018 18:06:48 +0000
Message-ID: <HK2PR03MB16849EA4D9CE5C230EB9966492950@HK2PR03MB1684.apcprd03.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [125.33.105.40]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB0690;7:806hGBRjtBnPewuPJ+dubLKgUvYMX8WCmfAHa1nFvJSkABhCq587oLfUIhtMN9DV/R0zsFC7rLjF2lIYhAMOn5YmT2uQluNjrf4TQSCcBk59mqatIXKjxDQEFLyANPURN0BhTLXbtXPuGTbKXwavBcuAEtV01m+06VEDuWssHPxgZcWl+Z6HRG0QYrAaEFq1qUFEG75YrDsASLI74Ewj0MVeypzu9R/nafU1JYGYENqFDZpVh1E82ApfQFk/TCFu;20:ME7wmJgfcsO/+qvAVKc++QHKIH0XX2nROGg7w80SlqWhjcDkkHO1yI9DcevnsUOR9T+saj4DzVlVjsvZlmrxAmTJMWMo7uxrAczdog0kQ8/0p+Ky19CkEl6fpkiTrikVrFxImdmbvZg191c7vcOrwRm27SWkw3zBiwLdSs8rRsEoL4GOpfeMczsvbREE6/ys4bXnwRNLDwYt7yBeyZuR664x0gUVSc2ErMVZCzOuzQRp4wGOKHIaHVJH3ve8dC5wcetVu1yyfQLdvpWBTrSN0CRecV897BBDbD+lPaDsCez5kuwounIg71LICFVkTBkzxcYd/bwpPELc8kSBR3dFbw==
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB0690;
x-ms-traffictypediagnostic: HK2PR03MB0690:
x-microsoft-antispam-prvs: <HK2PR03MB06906243E6D397FDD4744F4492950@HK2PR03MB0690.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(3940261145250)(50582790962513)(788757137089)(211936372134217)(153496737603132)(146099531331640);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HK2PR03MB0690;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB0690;
x-forefront-prvs: 06793E740F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(366004)(376002)(39850400004)(189003)(199004)(316002)(68736007)(4326008)(81156014)(110136005)(14066004)(7416002)(6116002)(3846002)(3280700002)(74316002)(2900100001)(5250100002)(7696005)(81166006)(86362001)(9686003)(8936002)(97736004)(14454004)(5660300001)(33656002)(486006)(53936002)(8676002)(2201001)(54906003)(476003)(55016002)(66066001)(105586002)(99286004)(15650500001)(25786009)(106356001)(59450400001)(7736002)(6506007)(305945005)(186003)(26005)(3660700001)(2906002)(2501003)(478600001)(6436002)(102836004)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB0690;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam-message-info: vF+4isIzNCqc+H98/q9u6q/mkgG+cN8xdeITGxJlXUzuSOXJo/cqNG8BLyxHBth/zK3wi9gKq3Zx7kPqUK6BqE5oXuLtpo9Q0M9dg3kwYLj+mXGPIs2iBWS7WJSoJ0C2O0fudur7kTcSb8+7sWJsLXZVgs7fLSpqBdkEaH2+pujHlj0Jjgcm3TWS7fbgDmRe
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 11cb9eb4-7dd4-4c9e-a6b9-08d5bf459f12
X-MS-Exchange-CrossTenant-Network-Message-Id: 11cb9eb4-7dd4-4c9e-a6b9-08d5bf459f12
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2018 18:06:48.2749
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB0690
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601097981260839782?=
X-GMAIL-MSGID: =?utf-8?q?1601097981260839782?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use __GFP_ZONE_MOVABLE to replace (__GFP_HIGHMEM | __GFP_MOVABLE).

___GFP_DMA, ___GFP_HIGHMEM and ___GFP_DMA32 have been deleted from GFP=20
bitmasks, the bottom three bits of GFP mask is reserved for storing
encoded zone number.

__GFP_ZONE_MOVABLE contains encoded ZONE_MOVABLE and __GFP_MOVABLE flag.

With GFP_ZONE_TABLE, __GFP_HIGHMEM ORing __GFP_MOVABLE means gfp_zone
should return ZONE_MOVABLE. In order to keep that compatible with
GFP_ZONE_TABLE, replace (__GFP_HIGHMEM | __GFP_MOVABLE) with
__GFP_ZONE_MOVABLE.

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: zhongjiang <zhongjiang@huawei.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Dan Carpenter <dan.carpenter@oracle.com>
Cc: David Rientjes <rientjes@google.com>
---
 mm/vmpressure.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmpressure.c b/mm/vmpressure.c
index 85350ce..30a40e2 100644
--- a/mm/vmpressure.c
+++ b/mm/vmpressure.c
@@ -256,7 +256,7 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bo=
ol tree,
         * Indirect reclaim (kswapd) sets sc->gfp_mask to GFP_KERNEL, so
         * we account it too.
         */
-       if (!(gfp & (__GFP_HIGHMEM | __GFP_MOVABLE | __GFP_IO | __GFP_FS)))
+       if (!(gfp & (__GFP_ZONE_MOVABLE | __GFP_IO | __GFP_FS)))
                return;
=20
        /*
--=20
1.8.3.1
