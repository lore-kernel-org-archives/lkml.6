Return-Path: <yehs1@lenovo.com>
X-Google-Smtp-Source: AB8JxZreEkSBCZFwpJzedbh7JcfADEjgMFfO/hyugwk5M7mgglp1Q0NgiB1ZWuq572khyNjY1oXf
ARC-Seal: i=1; a=rsa-sha256; t=1526925720; cv=none;
        d=google.com; s=arc-20160816;
        b=dRvLmht2ta/54tbTUbdM4vTPSli0UcncqSHH7m31gA1G7ydQHpsYqk6CUdVHrZGztH
         qpKknvmQW1AePUzBbzBYLsm4LDpRO4YAQWXaTzGqwzU92oIMbnkSGp9FkcG8qj2jOV6B
         LpFp4M68ECuokkrqZp8vLtlfZO7ZO4qsGVAUIfUbPJRHmJKpuAisv873b0Zy7Wgtm9nv
         LZh7inmCP7LpvyNVfWgz2qaVFe6eHfoK1MJPFFoDtNgxrYP2Wxtyr03vRqLCZNxyfgkf
         a2iQAddE18zOka+r8T7bGNRHkK3gHfF7H8IwAPC/r4Xcqt9WwlPZpFwbRiUIZcm9smGy
         4wQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:message-id
         :date:thread-index:thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=UysVfdiJRGUitKiLQRNtmQhpP0+xX7wrjwcpiQa3WrU=;
        b=z2rJrqctCfHvumTT+EPh43Pz7WitCpYpnVP38ACdEev23KFVe1gAu+cLWYwSVpRtDy
         BNFwecqAS/E7/tbMdX0cfqmYuJ3UvPEaBWFjct+cpFf0RkjFnESByLGS6sOZzl5xn7K/
         qtWmbiv1+aG/Kj93z7thaiTDxchA8JzPXOcCLOPLMwTx5SdnurvP2pQJy/hAY+zp1z8y
         oYsdyyGxMC8kcmckXSOfyMLpWiltjZ2EzHIFKmZSnx7U/JjtgoJCXQv3B3FDdel4e/ct
         ACc5aN2cJ+hiJJ5SmkGY+IBhcnpN/hlpBKiukmVF0RtVcNH4OxAnuPFPr/OcgjKZ350T
         0TbQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@LenovoBeijing.onmicrosoft.com header.s=selector1-lenovo-com header.b=IcM0+Zxj;
       spf=pass (google.com: domain of yehs1@lenovo.com designates 216.82.251.16 as permitted sender) smtp.mailfrom=yehs1@lenovo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=lenovo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@LenovoBeijing.onmicrosoft.com header.s=selector1-lenovo-com header.b=IcM0+Zxj;
       spf=pass (google.com: domain of yehs1@lenovo.com designates 216.82.251.16 as permitted sender) smtp.mailfrom=yehs1@lenovo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=lenovo.com
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTf2wTZRjH+95d727Qwu26ZY+VDWjUwLSL5Q8
  9xQB/mHgxMRETNHYKXOHcNfbH7BWcMcZ2E2PKNrBb9qMMaWW4H1S2dRvCSro4BZkYt2xIKJA2
  yIIyFyBDZTDG7PUG6n+f5/1+n+/7vG/el8bZCGWkxQqv6HEJDhO5iJB+v4yZG3Lw0qcT4eVcS
  1eU5L5MSFxwTxPFNfpHKG50xo9xVQe7SK7j8EmMCw+u5eaORwiuuqUScWNX2ilufKCF5FLReS
  137FAC49K1G7h9/lrEzc5k1m/31WEbWP7zqusU39tezMemgxR/ummW4Af3Rym+7nwb4r+7eZb
  g40kfyXf1/ULwP4W/z3jPfMj3313H77qdz9+KFb26xKq1u2zuiq1aafRULVEezamoTvQSPjRK
  BdAimmV+Q9B4L4WrxSkEF4OtKIByaIJpx6FuYK3CLFOLQcenmGpKI+iZihGKQDKrYXjqXLY7j
  6lHkKzqIZUCZ3pJSN27oVVcBuZN+DPSlI3NYzZD4lIow3SGS+BW23p1t8chFZ/PWvTMW7AnfZ
  hSGDGF0PBrGlMYZwpgf0MoGwkMA60nRnCV8+HalftaJRIxr8H1vs3q8kpoiR9asBTC2IHdSBk
  NmL1aOP/F3ws5FvihYxBXhQkt/Dyyj1CLowgu3GwjVVcxdA8HFjrehbPJbkrlNyASuoBULoLO
  mssLzTEcumfShCosg5FvrlLqRUoQCHZkT88yNvh61r4XmUP/OZzKT0E4Pk2q/CR8FfkDD2UvJ
  heGmyeIMCI60SpZ9OwUPWbLcyU2j71M8joFu8NssawpcYqyLJSJDsEml2xzO2Mo81w/1mjQMV
  Tvf3kIPUJjpnz9/fewUnaJzb39A0mQpS2eHQ5RHkLLaNoE+rdpvJTN9YhlYsU7dkfmzT+Qgda
  Z8vRViqyXywWnbC9TpR+RmY72BatxlnC5XaKxQG9VTIxikna4HkY8+DljqNBo0CONRsPqykWP
  0+79vz6JCmhkMugfU1J0dpf34U6TmSGwzBCfDc1bM0N4hX8low/V7B4MdMXf7/ff0dnvLt9Yt
  IlvTF4d/XbqaK6h2GA+siVd0Pu8G6uxmpsbtV5h/Znx6ZPDwcW+8YsvWodC49cMqU/+YluNL1
  TuWnFuwPvM8fqiZP/Wnc/qbshznm0TPdXCkY98p6VLE9Lc3OJHpcntlevuvMQ1r6FeX/XE0po
  DB1/pNBGyJFiKcY8s/ANnXOJMNAQAAA==
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-9.tower-143.messagelabs.com!1526925714!51253850!1
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
	<linux-btrfs@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "clm@fb.com"
	<clm@fb.com>, "jbacik@fb.com" <jbacik@fb.com>, "dsterba@suse.com"
	<dsterba@suse.com>
Subject: [RFC PATCH v2 07/12] fs/btrfs/extent_io: update usage of address zone
 modifiers
Thread-Topic: [RFC PATCH v2 07/12] fs/btrfs/extent_io: update usage of address
 zone modifiers
Thread-Index: AdPxLZ0tZyq8hSXbTQ2OLuxzW6DjlA==
Date: Mon, 21 May 2018 18:01:36 +0000
Message-ID: <HK2PR03MB16848D9371E00E9029FCC94092950@HK2PR03MB1684.apcprd03.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [125.33.105.40]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB0690;7:0yPazzbmqukhorFYs4ZEm4tmm8Igtji5FDYQeEJqTPktfAXKZoVLfgLhPk+ykjXX0JP7yfVNDenuely29Ab3ppiWphj8u8fvWDAjNM4685bpBTqcQJFNo/uNffYph4gzQ2rfpLLCQtELcrLkFYMO8tbwBIvbIp+DCdXSTw8t4WAo2rH5AViKF5XOb5A1Xna1jL6m51hyJdIsVNVrZZN8B2c8bHyCt7Vlp1u2RIRDqgT/g/ea5gO49T1QMjOPyryu;20:CI3dh/Rgiagb945EgASzJWbsgYfisswntslBJzhiFOAYcCb9ZUNAa0mR3sw0EWd685Lcq0WFh/T4v6g51x98bqurKMe6RK6oZljryluTwJz0QqsPgZnvBfsZBm5j2MzuzARy/eh41Zzc7Yz1eGTGltkbb96iDuTQumTNzYVAeH+Ap6cpKIMgZPqeWQJgOXE5IWwg9ny2f1n03n1bQwxUUJE0JzIUSsx+TvADXbbltkieC3nAGRiIvLH69QqauRl7nXuaADCLqDcOUq4RFHQ4MH1aWua+YcFMlWGtASWSwilGaUYk7H2m9i3mRaHD2SDM+ZnD0fc0cHS2MwrJsaKaKQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(366004)(376002)(39850400004)(189003)(199004)(316002)(68736007)(4326008)(81156014)(110136005)(14066004)(7416002)(6116002)(3846002)(3280700002)(74316002)(2900100001)(5250100002)(7696005)(81166006)(86362001)(9686003)(8936002)(97736004)(14454004)(5660300001)(33656002)(486006)(53936002)(8676002)(2201001)(54906003)(476003)(55016002)(66066001)(105586002)(99286004)(25786009)(106356001)(59450400001)(7736002)(6506007)(305945005)(186003)(26005)(3660700001)(2906002)(2501003)(478600001)(6436002)(102836004)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB0690;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB0690;
x-ms-traffictypediagnostic: HK2PR03MB0690:
x-microsoft-antispam-prvs: <HK2PR03MB06901562102134C7D302EB8192950@HK2PR03MB0690.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(3940261145250)(788757137089)(67672495146484);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HK2PR03MB0690;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB0690;
x-forefront-prvs: 06793E740F
x-microsoft-antispam-message-info: 6EaltNCUnKNPLbKgkEXPKvT8O2lr33+NOQF2aiEwpuu1Jxqh7wp5fikwilVOlIXmQtWfBn8OLOFC0jMkdmlmIA2GiCk6TAqbOg59uOpWGm0nkwoip6kE91jWjH/YP9VThJlmTS9INp4a/LbFPjxDYxpi82oFoeGBh87kfRkSx9ErifTuG5yNuosZNKN/w/I7
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 5bde993c-4e28-45ec-6bc6-08d5bf44e55f
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bde993c-4e28-45ec-6bc6-08d5bf44e55f
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2018 18:01:36.8049
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB0690
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601097664587359386?=
X-GMAIL-MSGID: =?utf-8?q?1601097664587359386?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Use __GFP_ZONE_MASK to replace (__GFP_DMA32 | __GFP_HIGHMEM).

In function alloc_extent_state, it is obvious that __GFP_DMA is not=20
the expecting zone type.

___GFP_DMA, ___GFP_HIGHMEM and ___GFP_DMA32 have been deleted from GFP=20
bitmasks, the bottom three bits of GFP mask is reserved for storing
encoded zone number.
__GFP_DMA, __GFP_HIGHMEM and __GFP_DMA32 should not be operated with
each others by OR.=20

Signed-off-by: Huaisheng Ye <yehs1@lenovo.com>
Cc: Chris Mason <clm@fb.com>
Cc: Josef Bacik <jbacik@fb.com>
Cc: David Sterba <dsterba@suse.com>
---
 fs/btrfs/extent_io.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index dfeb74a..6653e9a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -220,7 +220,7 @@ static struct extent_state *alloc_extent_state(gfp_t ma=
sk)
         * The given mask might be not appropriate for the slab allocator,
         * drop the unsupported bits
         */
-       mask &=3D ~(__GFP_DMA32|__GFP_HIGHMEM);
+       mask &=3D ~__GFP_ZONE_MASK;
        state =3D kmem_cache_alloc(extent_state_cache, mask);
        if (!state)
                return state;
--=20
1.8.3.1
