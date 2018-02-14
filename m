Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967665AbeBNMAs (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Feb 2018 07:00:48 -0500
Received: from mailout3.samsung.com ([203.254.224.33]:19507 "EHLO
        mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S967373AbeBNMAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Feb 2018 07:00:45 -0500
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20180214120043epoutp033e2851214a8ecd038a65f1f55b53b28a~TL2ynN0KM0214202142epoutp03L
X-AuditID: b6c32a48-9c5ff70000000ff0-fe-5a8424eabcd1
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        Jingoo Han <jingoohan1@gmail.com>
Subject: [PATCH] video: fbdev: s3c-fb: remove dead platform code for Exynos
 and S5PV210 platforms
Date: Wed, 14 Feb 2018 13:00:39 +0100
Message-id: <2621881.tniV7NOQqn@amdc3058>
User-Agent: KMail/4.13.3 (Linux/3.13.0-96-generic; KDE/4.13.3; x86_64; ; )
MIME-version: 1.0
Content-transfer-encoding: 7Bit
Content-type: text/plain; charset="us-ascii"
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrOIsWRmVeSWpSXmKPExsWy7bCmqe4rlZYog08n1S2ufH3PZrHiy0x2
        ixN9H1gtLu+aw2Yx4/w+JgdWj52z7rJ73O8+zuTxeZNcAHMUl01Kak5mWWqRvl0CV8amv4EF
        h/UrTm8sa2CcpNrFyMkhIWAi0f6tnbGLkYtDSGAHo8T1y5/ZQBJCAt8ZJd69T4crOr+fBaJo
        N6PEwu8ToIq+MkqsucsLYrMJWElMbF/FCGKLCDhITLkxgR3EZhbIkNg3+RMziC0skCxxsasV
        rIZFQFViwqffYDW8ApoSz6/cAYuLCnhJbNnXzgQRF5T4MfkeC8QceYl9+6eyQtg6EmePrWOE
        OK6DTeLH9RAI20Vi2ec9bBC2sMSr41vYIWxpiWerNoJ9KSGwilHi59W/UM5mRonP17+yQlRZ
        Sxw+fhFqA59Ex+G/QN0cQHFeiY42IYgSD4mDV/ZCLXaUODOpjxGkREggVuLe4qoJjDKzkJw9
        C8nZs5CcvYCReRWjWGpBcW56arFRgYlecWJucWleul5yfu4mRnB0a3nsYDxwzucQowAHoxIP
        74ZXTVFCrIllxZW5hxglOJiVRHiNzzdHCfGmJFZWpRblxxeV5qQWH2KU5mBREudtC3CJEhJI
        TyxJzU5NLUgtgskycXBKNTD2RyinWt7fOeXDx5t7849eepE6eZ8Fv+bTK/5G79zXT9J9frDx
        Nb/HsTlPdJiCut2avh3RWb6BO24Sc0jChZJpzaFbluvs2L0oaDmDWMyKu2YqqlFcjRUZSis3
        dKXXL1suJP/GvrCCi3fa7v+hJpODvp4RSv12IvuOaPDT8s/Tr5f2uzxw+fJUiaU4I9FQi7mo
        OBEAIEGtTuoCAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrGLMWRmVeSWpSXmKPExsVy+t9jAd2XKi1RBkdXqVlc+fqezWLFl5ns
        Fif6PrBaXN41h81ixvl9TA6sHjtn3WX3uN99nMnj8ya5AOYoLpuU1JzMstQifbsEroxNfwML
        DutXnN5Y1sA4SbWLkZNDQsBEov38fpYuRi4OIYGdjBInT91kg3C+MkrsXfSZCaSKTcBKYmL7
        KkYQW0TAQWLKjQnsIDazQIbExpfXmUFsYYFkidZpnWwgNouAqsSET7/BangFNCWeX7kD1isq
        4CWxZV87E0RcUOLH5HssEHPkJfbtn8oKYWtJrN95nGkCI+8sJGWzkJTNQlK2gJF5FaNkakFx
        bnpusVGBUV5quV5xYm5xaV66XnJ+7iZGYOhtO6zVv4Px8ZL4Q4wCHIxKPLwcb5uihFgTy4or
        cw8xSnAwK4nwGp9vjhLiTUmsrEotyo8vKs1JLT7EKM3BoiTOy59/LFJIID2xJDU7NbUgtQgm
        y8TBKdXAmCkgaqL5uYPzZ+I1ox0zu+oFc/1+uJu9/9W2PO/Nv8mdkn/e19QL37+94Pyc51t5
        su6tm5P36b7Qf/P0P/E5C67MtRR/WRW+VPU+B3dd1KyNf5qvq9gzd9yqWi2zvUlu2vODu4r+
        WHAUvT7+xq3y+5Joj198PcsmsPA8+Rgec7B/o+b5c0tdvymxFGckGmoxFxUnAgA97jQzOQIA
        AA==
X-CMS-MailID: 20180214120041epcas2p37afd51e693a9cad842e59128a77d45ac
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180214120041epcas2p37afd51e693a9cad842e59128a77d45ac
X-RootMTR: 20180214120041epcas2p37afd51e693a9cad842e59128a77d45ac
References: <CGME20180214120041epcas2p37afd51e693a9cad842e59128a77d45ac@epcas2p3.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Exynos5, Exynos4 and S5PV210 platforms have been converted to
use Device Tree and Exynos DRM driver long time ago.  Remove
dead platform code for these platforms and update Kconfig
s3c-fb entry accordingly.

Cc: Jingoo Han <jingoohan1@gmail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/Kconfig  |    3 
 drivers/video/fbdev/s3c-fb.c |  162 -------------------------------------------
 2 files changed, 1 insertion(+), 164 deletions(-)

Index: b/drivers/video/fbdev/Kconfig
===================================================================
--- a/drivers/video/fbdev/Kconfig	2018-02-12 14:28:32.392677896 +0100
+++ b/drivers/video/fbdev/Kconfig	2018-02-14 12:54:06.399057592 +0100
@@ -2020,8 +2020,7 @@ config FB_TMIO_ACCELL
 
 config FB_S3C
 	tristate "Samsung S3C framebuffer support"
-	depends on FB && (CPU_S3C2416 || ARCH_S3C64XX || \
-		ARCH_S5PV210 || ARCH_EXYNOS)
+	depends on FB && (CPU_S3C2416 || ARCH_S3C64XX)
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
Index: b/drivers/video/fbdev/s3c-fb.c
===================================================================
--- a/drivers/video/fbdev/s3c-fb.c	2017-10-18 14:35:22.063448310 +0200
+++ b/drivers/video/fbdev/s3c-fb.c	2018-02-14 12:04:00.719262463 +0100
@@ -1716,63 +1716,6 @@ static struct s3c_fb_win_variant s3c_fb_
 	},
 };
 
-static struct s3c_fb_win_variant s3c_fb_data_s5p_wins[] = {
-	[0] = {
-		.has_osd_c	= 1,
-		.osd_size_off	= 0x8,
-		.palette_sz	= 256,
-		.valid_bpp	= (VALID_BPP1248 | VALID_BPP(13) |
-				   VALID_BPP(15) | VALID_BPP(16) |
-				   VALID_BPP(18) | VALID_BPP(19) |
-				   VALID_BPP(24) | VALID_BPP(25) |
-				   VALID_BPP(32)),
-	},
-	[1] = {
-		.has_osd_c	= 1,
-		.has_osd_d	= 1,
-		.osd_size_off	= 0xc,
-		.has_osd_alpha	= 1,
-		.palette_sz	= 256,
-		.valid_bpp	= (VALID_BPP1248 | VALID_BPP(13) |
-				   VALID_BPP(15) | VALID_BPP(16) |
-				   VALID_BPP(18) | VALID_BPP(19) |
-				   VALID_BPP(24) | VALID_BPP(25) |
-				   VALID_BPP(32)),
-	},
-	[2] = {
-		.has_osd_c	= 1,
-		.has_osd_d	= 1,
-		.osd_size_off	= 0xc,
-		.has_osd_alpha	= 1,
-		.palette_sz	= 256,
-		.valid_bpp	= (VALID_BPP1248 | VALID_BPP(13) |
-				   VALID_BPP(15) | VALID_BPP(16) |
-				   VALID_BPP(18) | VALID_BPP(19) |
-				   VALID_BPP(24) | VALID_BPP(25) |
-				   VALID_BPP(32)),
-	},
-	[3] = {
-		.has_osd_c	= 1,
-		.has_osd_alpha	= 1,
-		.palette_sz	= 256,
-		.valid_bpp	= (VALID_BPP1248 | VALID_BPP(13) |
-				   VALID_BPP(15) | VALID_BPP(16) |
-				   VALID_BPP(18) | VALID_BPP(19) |
-				   VALID_BPP(24) | VALID_BPP(25) |
-				   VALID_BPP(32)),
-	},
-	[4] = {
-		.has_osd_c	= 1,
-		.has_osd_alpha	= 1,
-		.palette_sz	= 256,
-		.valid_bpp	= (VALID_BPP1248 | VALID_BPP(13) |
-				   VALID_BPP(15) | VALID_BPP(16) |
-				   VALID_BPP(18) | VALID_BPP(19) |
-				   VALID_BPP(24) | VALID_BPP(25) |
-				   VALID_BPP(32)),
-	},
-};
-
 static struct s3c_fb_driverdata s3c_fb_data_64xx = {
 	.variant = {
 		.nr_windows	= 5,
@@ -1804,102 +1747,6 @@ static struct s3c_fb_driverdata s3c_fb_d
 	.win[4]	= &s3c_fb_data_64xx_wins[4],
 };
 
-static struct s3c_fb_driverdata s3c_fb_data_s5pv210 = {
-	.variant = {
-		.nr_windows	= 5,
-		.vidtcon	= VIDTCON0,
-		.wincon		= WINCON(0),
-		.winmap		= WINxMAP(0),
-		.keycon		= WKEYCON,
-		.osd		= VIDOSD_BASE,
-		.osd_stride	= 16,
-		.buf_start	= VIDW_BUF_START(0),
-		.buf_size	= VIDW_BUF_SIZE(0),
-		.buf_end	= VIDW_BUF_END(0),
-
-		.palette = {
-			[0] = 0x2400,
-			[1] = 0x2800,
-			[2] = 0x2c00,
-			[3] = 0x3000,
-			[4] = 0x3400,
-		},
-
-		.has_shadowcon	= 1,
-		.has_blendcon	= 1,
-		.has_clksel	= 1,
-		.has_fixvclk	= 1,
-	},
-	.win[0]	= &s3c_fb_data_s5p_wins[0],
-	.win[1]	= &s3c_fb_data_s5p_wins[1],
-	.win[2]	= &s3c_fb_data_s5p_wins[2],
-	.win[3]	= &s3c_fb_data_s5p_wins[3],
-	.win[4]	= &s3c_fb_data_s5p_wins[4],
-};
-
-static struct s3c_fb_driverdata s3c_fb_data_exynos4 = {
-	.variant = {
-		.nr_windows	= 5,
-		.vidtcon	= VIDTCON0,
-		.wincon		= WINCON(0),
-		.winmap		= WINxMAP(0),
-		.keycon		= WKEYCON,
-		.osd		= VIDOSD_BASE,
-		.osd_stride	= 16,
-		.buf_start	= VIDW_BUF_START(0),
-		.buf_size	= VIDW_BUF_SIZE(0),
-		.buf_end	= VIDW_BUF_END(0),
-
-		.palette = {
-			[0] = 0x2400,
-			[1] = 0x2800,
-			[2] = 0x2c00,
-			[3] = 0x3000,
-			[4] = 0x3400,
-		},
-
-		.has_shadowcon	= 1,
-		.has_blendcon	= 1,
-		.has_fixvclk	= 1,
-	},
-	.win[0]	= &s3c_fb_data_s5p_wins[0],
-	.win[1]	= &s3c_fb_data_s5p_wins[1],
-	.win[2]	= &s3c_fb_data_s5p_wins[2],
-	.win[3]	= &s3c_fb_data_s5p_wins[3],
-	.win[4]	= &s3c_fb_data_s5p_wins[4],
-};
-
-static struct s3c_fb_driverdata s3c_fb_data_exynos5 = {
-	.variant = {
-		.nr_windows	= 5,
-		.vidtcon	= FIMD_V8_VIDTCON0,
-		.wincon		= WINCON(0),
-		.winmap		= WINxMAP(0),
-		.keycon		= WKEYCON,
-		.osd		= VIDOSD_BASE,
-		.osd_stride	= 16,
-		.buf_start	= VIDW_BUF_START(0),
-		.buf_size	= VIDW_BUF_SIZE(0),
-		.buf_end	= VIDW_BUF_END(0),
-
-		.palette = {
-			[0] = 0x2400,
-			[1] = 0x2800,
-			[2] = 0x2c00,
-			[3] = 0x3000,
-			[4] = 0x3400,
-		},
-		.has_shadowcon	= 1,
-		.has_blendcon	= 1,
-		.has_fixvclk	= 1,
-	},
-	.win[0]	= &s3c_fb_data_s5p_wins[0],
-	.win[1]	= &s3c_fb_data_s5p_wins[1],
-	.win[2]	= &s3c_fb_data_s5p_wins[2],
-	.win[3]	= &s3c_fb_data_s5p_wins[3],
-	.win[4]	= &s3c_fb_data_s5p_wins[4],
-};
-
 /* S3C2443/S3C2416 style hardware */
 static struct s3c_fb_driverdata s3c_fb_data_s3c2443 = {
 	.variant = {
@@ -1942,15 +1789,6 @@ static const struct platform_device_id s
 		.name		= "s3c-fb",
 		.driver_data	= (unsigned long)&s3c_fb_data_64xx,
 	}, {
-		.name		= "s5pv210-fb",
-		.driver_data	= (unsigned long)&s3c_fb_data_s5pv210,
-	}, {
-		.name		= "exynos4-fb",
-		.driver_data	= (unsigned long)&s3c_fb_data_exynos4,
-	}, {
-		.name		= "exynos5-fb",
-		.driver_data	= (unsigned long)&s3c_fb_data_exynos5,
-	}, {
 		.name		= "s3c2443-fb",
 		.driver_data	= (unsigned long)&s3c_fb_data_s3c2443,
 	},
