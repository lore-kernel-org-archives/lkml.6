Return-Path: <yehs1@lenovo.com>
X-Google-Smtp-Source: AB8JxZrbkTzYKJ8qGEPR+57Qn0Jvbh64tRU7/S+gCu8UhmSPRnxDd4mIHepT1pa4Nq5eMgM4T84R
ARC-Seal: i=1; a=rsa-sha256; t=1526925841; cv=none;
        d=google.com; s=arc-20160816;
        b=ViV+Tylapn+4kmMGbQwqyA/BVgHI8OVtS/InDkpM/mg18zOL/Z3NYManiccP78f8AH
         c6no+a5oKdTLomoCmd/3czaxv3nr6PAI9pu9Bdk3TvI0AfNXpVZeLueQi85aSwOAFj4f
         KRh4LsMhznx+XkYvUZx4FvIVop/v5F3ffKe07+dUXsCS13I8+0tdaLc+ySuI+zWh7b3S
         eSvHsxgLJr6Es64g6Wb50XUA2mLW4aHQksQxUzCC5O3nK6+0sZSL8BctI5YHeTMExt/5
         FZSzeAYc1sMT4fMSogh/K9Nsr9P13XwGMs2xDQ57MFjgKgeHwVTirRlwJzF/oMxK4stN
         61/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=mime-version:content-transfer-encoding:spamdiagnosticmetadata
         :spamdiagnosticoutput:content-language:accept-language:message-id
         :date:thread-index:thread-topic:subject:cc:to:from:dkim-signature
         :arc-authentication-results;
        bh=LYsm0fOS/RPRneqKNqitQCqUVv9EIGU5hSHPpq4T8rc=;
        b=F+xy4QdO74PzE6jvAPHNiRWSGXeFmSRS5ExJXGr0/+Jsr5aik8MBLFnidMg2/3aZ1X
         UR9rqUXxP//vW7FMZVCQ23pNagVaXoFUh3Yyuykwzp5OIuonfqQcLpC29CuiuvShgoKg
         MkttLxk+klI7d9yWLb2nLGlpc9c041Vk2WYk9EEGVOoIJw8UCDdY6Zo1y7Gx0nwbhZ6p
         GLOjV7B6wwsDGHvnqxGNYe545KNKKHl+nPRlePtfTeN8nvLDPxGBw/rlscdgX6HZk61c
         q5LmDNYTWOPmXpUGyBKo4B8J/Q/vMew1/ICHEns7/5zsURcIt+PqPlzS1prssB4zDfXX
         IeNA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@LenovoBeijing.onmicrosoft.com header.s=selector1-lenovo-com header.b=esyWO+Do;
       spf=pass (google.com: domain of yehs1@lenovo.com designates 216.82.251.4 as permitted sender) smtp.mailfrom=yehs1@lenovo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=lenovo.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@LenovoBeijing.onmicrosoft.com header.s=selector1-lenovo-com header.b=esyWO+Do;
       spf=pass (google.com: domain of yehs1@lenovo.com designates 216.82.251.4 as permitted sender) smtp.mailfrom=yehs1@lenovo.com;
       dmarc=pass (p=NONE sp=NONE dis=NONE) header.from=lenovo.com
X-Brightmail-Tracker: H4sIAAAAAAAAA1WTbVBUZRTHee47xOplATmhyLS9TJEQbE7zlDO
  K9aE7fWqcZmwkq7t2291hX2jv2uA0TRI2U4o7DBrYuhJYCiK0y4IvyCoN+AKrRa1p6lQr4Dgr
  BAKNQgLSvXvR6tv/PL//ec45z5yHI/UtbCYnlboll0O0GZgkyhIbIHIXJ5FF+dumsrHP38zg/
  acsuKasn8Xl3/gZfOjwGQLXda3CFb5PEY4MNbL44gkfg/9onqfx8QOnCBz1FOKDd26zOLDNy+
  LByioC7y3zIDwzrdim2ncRhXqhw/s7K7Q15gjBpi8YIThZxQq9e2YooWtfMyvsutKAhJ7xXyi
  h8+pWRvC3X6KEC3WnlYTzHwlH7q0WPptKFzom22jhr+Dy1/kNtNVhcpa+S1sOfzdNl/QuKh3t
  yNyKAknbURKn528gKDtbQ2lBD4K9/h3xgOIbSYjU9tIa8RAQCA0jLYgiuNM0q5BEjuGfgb4/L
  5MqSON3I7ha3sqoAcmPMvD9D52k6krlTXD0Siul6jTeDKE9XiWbU3Qe+G89rh5T/JNQHQ7F7T
  r+LTgy52NUjfgsqB6MEqom+QzYV+2NFwaeh29D/aSm0+HW0P34lYhfB2Ptb2vHj4Gv88CCJQs
  iX++IDwB8JQ2XYoOEBgrg3KEuUgMTNPzUNspowVEE18YbGM2VA4G+7QuVi6F6eAxpej3M+48t
  lFgOTTsHKC05SEJgOkppYBn0H7vJqu3plZdombFqniEEUZ+frEQrvP+ZTtMroK5zktH0s3Cwf
  oT0xl8mBfq+ukHVIaoJPS1Lrg8lV65xZZ7JZTVb3HbRasstKDDm2SVZFs2STTTJeZuc9iBSVv
  eThAR0HNXXvNaNHuUIQ7ru/gdEkX6RyfneFosoW95xbbZJcjdaxnEG0OFEskif4pLMUun7Vpu
  y/w8wcMmGNN0LKtbJJaJdtpo1FEa5XHN7VQWppxxOh5SZoTvPKSZeNVk2Ox5e8eAXRVBWZqoO
  JSQk6JNLJJfd6v4/H0YZHDKk6paopZKtDvfDSsNKE4TSxOfd8xuUJtziv0jZa2+4Ys2WaWfL2
  sjIzsUTa95YFxuP1W7K9tDdXxb31HtexOX5zl+vV7wa+1Gkw1kX7o5tzDY+5Sg6U7Xq48tztr
  Hf0p64nbN27tqJv4uh3/jI0p+HXrl+Mlw7cnd//kuzAw0rewvffP5iynMohTl3816o4exG+9I
  luxNPGlevZ1tPz3penjBQskUsyCFdsvgPPIz2DEAEAAA=
X-Env-Sender: yehs1@lenovo.com
X-Msg-Ref: server-11.tower-138.messagelabs.com!1526925835!30114264!1
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
	<linux-btrfs@vger.kernel.org>, "hch@lst.de" <hch@lst.de>, "minchan@kernel.org" <minchan@kernel.org>, "ngupta@vflare.org"
	<ngupta@vflare.org>, "sergey.senozhatsky.work@gmail.com"
	<sergey.senozhatsky.work@gmail.com>
Subject: [RFC PATCH v2 08/12] drivers/block/zram/zram_drv: update usage of
 address zone modifiers
Thread-Topic: [RFC PATCH v2 08/12] drivers/block/zram/zram_drv: update usage
 of address zone modifiers
Thread-Index: AdPxLeLu/zuRysX7QReYPAFrovS/tA==
Date: Mon, 21 May 2018 18:03:38 +0000
Message-ID: <HK2PR03MB16847B9F373C3782466F724192950@HK2PR03MB1684.apcprd03.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [125.33.105.40]
x-ms-publictraffictype: Email
x-microsoft-exchange-diagnostics: 1;HK2PR03MB0690;7:yHDZvw9jsROC6XN7S4MkH3iOtw5DleRK/m0FT+RLdx6CcrBzQ4bnJkYPeqmdKZ5BYgzD1F+2Pt3rKJEBtHFAylNePf05q4dz2O6zSsb/vcGmM2jch9atEzyciNCb++vWWHmmBcqsFO/5Sce/PY/N/oD6eVVp9sj3DWFsEV0H5sJ11yGcyW9UdT710qXf83/eG6AkoSFh/M5qfY5EChcbGhx6QBD9oJwFIjkkgmQ2gYnKgI+T+EVSRb5LXyUkG7yc;20:QlcqrXxn7cKJrUUx+EKVPu9o2EBHyRHt0M+cIEJ6dFBzM/JVY3jkepu/5VCA5VSQzy9nE6ULKDPj/Wik6+p1gHMnMHHXJhG+aE9I3FFDLAp8EKBSIlZRZUUomYgZNGIKtHcIL24PJPVSvVjEQO4og3f2Qqe4jhwiQpWrBKSf3kZwbo92A1FSsJZwXUK1bQztHHdrMqNkqJTKDPc16TJrXA95ZnQhT+KFNrRrGFA4m+v2KQ5dHofRns5v3z2ElYKvikq0SxJjD566TC/Ue+3zWxvE97xQWJkiUUmKPi8gl0B2Z5t9pUCl2+giztjMEJ/llWXGt/6gDOd4EEgHn8QtRQ==
x-ms-exchange-antispam-srfa-diagnostics: SOS;SOR;
x-forefront-antispam-report: SFV:SKI;SCL:-1;SFV:NSPM;SFS:(10019020)(39380400002)(396003)(346002)(366004)(376002)(39850400004)(189003)(199004)(316002)(68736007)(4326008)(81156014)(110136005)(14066004)(7416002)(6116002)(3846002)(3280700002)(74316002)(2900100001)(5250100002)(7696005)(81166006)(86362001)(9686003)(8936002)(97736004)(14454004)(5660300001)(33656002)(486006)(53936002)(8676002)(2201001)(54906003)(476003)(39060400002)(55016002)(66066001)(105586002)(99286004)(25786009)(106356001)(59450400001)(7736002)(6506007)(305945005)(186003)(26005)(3660700001)(2906002)(2501003)(478600001)(6436002)(102836004)(217873001);DIR:OUT;SFP:1102;SCL:1;SRVR:HK2PR03MB0690;H:HK2PR03MB1684.apcprd03.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-microsoft-antispam: UriScan:;BCL:0;PCL:0;RULEID:(7020095)(4652020)(5600026)(4534165)(4627221)(201703031133081)(201702281549075)(2017052603328)(7153060)(7193020);SRVR:HK2PR03MB0690;
x-ms-traffictypediagnostic: HK2PR03MB0690:
x-microsoft-antispam-prvs: <HK2PR03MB069024692936D6B47A03340092950@HK2PR03MB0690.apcprd03.prod.outlook.com>
x-exchange-antispam-report-test: UriScan:(3940261145250)(85827821059158)(788757137089);
x-ms-exchange-senderadcheck: 1
x-exchange-antispam-report-cfa-test: BCL:0;PCL:0;RULEID:(6040522)(2401047)(8121501046)(5005006)(3002001)(3231254)(944501410)(52105095)(93006095)(93001095)(10201501046)(149027)(150027)(6041310)(20161123562045)(20161123560045)(201703131423095)(201702281528075)(20161123555045)(201703061421075)(201703061406153)(20161123558120)(20161123564045)(6072148)(201708071742011)(7699016);SRVR:HK2PR03MB0690;BCL:0;PCL:0;RULEID:;SRVR:HK2PR03MB0690;
x-forefront-prvs: 06793E740F
x-microsoft-antispam-message-info: 2zGTgD7FCBkqgRU1w3OeB0HxazVZ+iwgC803hWsko23uA7e5LlZ1hJKL9+Bf80EPe/I1QRwcZYpCpNG2gPF3YrvOo1Eag35zh9iy26pCI2iYY5ouw+tu++OfGEQUJ0VQw71wKIPSUif/C6dS3AGd+fgn+c5DmrGfmUiuGDmIIXzuLccZdKUCSpKMCXO4dQES
spamdiagnosticoutput: 1:99
spamdiagnosticmetadata: NSPM
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Office365-Filtering-Correlation-Id: 3f1bff46-d410-4173-3a80-08d5bf452e2c
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f1bff46-d410-4173-3a80-08d5bf452e2c
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 May 2018 18:03:38.9641
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 5c7d0b28-bdf8-410c-aa93-4df372b16203
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR03MB0690
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1601097790631564109?=
X-GMAIL-MSGID: =?utf-8?q?1601097790631564109?=
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
Cc: Minchan Kim <minchan@kernel.org>
Cc: Nitin Gupta <ngupta@vflare.org>
Cc: Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>
---
 drivers/block/zram/zram_drv.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 0afa6c8..39cb7d6 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -997,14 +997,12 @@ static int __zram_bvec_write(struct zram *zram, struc=
t bio_vec *bvec,
                handle =3D zs_malloc(zram->mem_pool, comp_len,
                                __GFP_KSWAPD_RECLAIM |=20
                                __GFP_NOWARN |
-                               __GFP_HIGHMEM |
-                               __GFP_MOVABLE);
+                               __GFP_ZONE_MOVABLE);
        if (!handle) {
                zcomp_stream_put(zram->comp);
                atomic64_inc(&zram->stats.writestall);
                handle =3D zs_malloc(zram->mem_pool, comp_len,
-                               GFP_NOIO | __GFP_HIGHMEM |
-                               __GFP_MOVABLE);
+                               GFP_NOIO | __GFP_ZONE_MOVABLE);
                if (handle)
                        goto compress_again;
                return -ENOMEM;
--=20
1.8.3.1
