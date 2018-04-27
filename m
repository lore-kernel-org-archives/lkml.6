Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757592AbeD0LWe (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 07:22:34 -0400
Received: from mailout2.samsung.com ([203.254.224.25]:56190 "EHLO
        mailout2.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752553AbeD0LWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 07:22:31 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20180427112229epoutp02b7b3e6aa78d4ec79567bef853d3954cb~pRx90rO8a2234222342epoutp02T
X-AuditID: b6c32a48-c49ff70000000fef-03-5ae307f459c3
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: Simon Horman <horms+renesas@verge.net.au>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH 1/3] video: fbdev: sh_mobile_lcdcfb: remove unused MERAM
 support
Date: Fri, 27 Apr 2018 13:21:43 +0200
Message-id: <1524828105-26585-2-git-send-email-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 1.9.1
In-reply-to: <1524828105-26585-1-git-send-email-b.zolnierkie@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrHIsWRmVeSWpSXmKPExsWy7bCmqe4X9sdRBrdfcFpsnLGe1eLK1/ds
        FnNnT2K0uPD2A5tF58Ql7BYn+j6wWlzeNYfNYuvLd0wOHB4Tz+p6zO6Yyepxv/s4k0ffllWM
        HnN+fmPx+LxJLoAtissmJTUnsyy1SN8ugSvjSOME9oKTphVdE44yNTDO0+li5OSQEDCRWPhm
        NmsXIxeHkMAORom+3zfYIZzvjBL3TvawwlTte/mGBSKxgVFi6scvzBDOL0aJHU8uMYNUsQlY
        SUxsX8UIYosIpEq07TwL1sEscJ5RYuPUHWCjhAWCJJq2NbOD2CwCqhLnF7eANfAKeEi8mTCf
        HWKdnMTJY5PB6jkFPCXu970E2yYhMINNovnvSyaIIheJOfOOsEHYwhKvjm+BapaWeLZqIyNE
        QzOjxLcde5ghEhMYJfasF4KwrSUOH78ItoFZgE+i4/BfoGYOoDivREebEITpIbGnLwWi2lHi
        wt8X0HCZwyixpnkl4wRGqQWMDKsYxVILinPTU4uNCkz0ihNzi0vz0vWS83M3MYJjVctjB+OB
        cz6HGAU4GJV4eBXePYwSYk0sK67MPcQowcGsJMK74zZQiDclsbIqtSg/vqg0J7X4EKM0B4uS
        OG+D75koIYH0xJLU7NTUgtQimCwTB6dUAyO/zH2DNWeSefR/xQcYHnXZU7GS4/bB6itmbh82
        7/GdnJIVnvTk6MHW/9Ms2Zd3aSnvdF/XvOCO64o9ajcurSuv3M99NUSW5Vv7iekrT6c8a2m0
        bTo/hXuXRM15ETGdxvn8C26Fz2+3yhX4dsXU0rKlyzDjE5um1/G//c6/IlfzqjxQyPs5i12J
        pTgj0VCLuag4EQDpkhD00QIAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprKLMWRmVeSWpSXmKPExsVy+t9jQd3P7I+jDBb36llsnLGe1eLK1/ds
        FnNnT2K0uPD2A5tF58Ql7BYn+j6wWlzeNYfNYuvLd0wOHB4Tz+p6zO6Yyepxv/s4k0ffllWM
        HnN+fmPx+LxJLoAtissmJTUnsyy1SN8ugSvjSOME9oKTphVdE44yNTDO0+li5OSQEDCR2Pfy
        DUsXIxeHkMA6Ronth3+zgiSEBH4xSsw7ywJiswlYSUxsX8UIYosIpErM2dPHDtLALHCWUeLm
        tQtgRcICARKNE94wgdgsAqoS5xe3gDXwCnhIvJkwnx1im5zEyWOTwRZwCnhK3O97yQyxzENi
        amcb0wRGngWMDKsYJVMLinPTc4uNCozyUsv1ihNzi0vz0vWS83M3MQIDa9thrf4djI+XxB9i
        FOBgVOLhVXj3MEqINbGsuDL3EKMEB7OSCO+O20Ah3pTEyqrUovz4otKc1OJDjNIcLErivPz5
        xyKFBNITS1KzU1MLUotgskwcnFINjCJsGkJ/3Bt1xHo/CAf/V7M4F5HF6HDq2LHPv1cw3GN/
        Ia145HzWWuNtuvfmTyiSuxvcksta5XzW+/6yCCvOTVd4Yr82Rmv6SO2SSyqLf2rA+zL0WEYA
        7+u4L7z3g2dUSPznORHimF51rXijs5LYbNcpDw6FxWtub1KdyrrhsZ2G8SO2SQsMlFiKMxIN
        tZiLihMBdRDmfSgCAAA=
X-CMS-MailID: 20180427112227epcas2p4ea3a93a5680d69a62f12cac627ebafbc
X-Msg-Generator: CA
CMS-TYPE: 102P
X-CMS-RootMailID: 20180427112227epcas2p4ea3a93a5680d69a62f12cac627ebafbc
X-RootMTR: 20180427112227epcas2p4ea3a93a5680d69a62f12cac627ebafbc
References: <1524828105-26585-1-git-send-email-b.zolnierkie@samsung.com>
        <CGME20180427112227epcas2p4ea3a93a5680d69a62f12cac627ebafbc@epcas2p4.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit a521422ea4ae  ("ARM: shmobile: mackerel: Remove Legacy C
board code") MERAM functionality is unused. Remove it.

Cc: Simon Horman <horms+renesas@verge.net.au>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/video/fbdev/Kconfig            |  1 -
 drivers/video/fbdev/sh_mobile_lcdcfb.c | 63 +---------------------------------
 drivers/video/fbdev/sh_mobile_lcdcfb.h |  1 -
 include/video/sh_mobile_lcdc.h         |  3 --
 4 files changed, 1 insertion(+), 67 deletions(-)

diff --git a/drivers/video/fbdev/Kconfig b/drivers/video/fbdev/Kconfig
index 434e95b..1e0b9515 100644
--- a/drivers/video/fbdev/Kconfig
+++ b/drivers/video/fbdev/Kconfig
@@ -1888,7 +1888,6 @@ config FB_W100
 config FB_SH_MOBILE_LCDC
 	tristate "SuperH Mobile LCDC framebuffer support"
 	depends on FB && (SUPERH || ARCH_RENESAS) && HAVE_CLK
-	depends on FB_SH_MOBILE_MERAM || !FB_SH_MOBILE_MERAM
 	select FB_SYS_FILLRECT
 	select FB_SYS_COPYAREA
 	select FB_SYS_IMAGEBLIT
diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index 929b1c5..dc46be3 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -29,7 +29,6 @@
 #include <linux/vmalloc.h>
 
 #include <video/sh_mobile_lcdc.h>
-#include <video/sh_mobile_meram.h>
 
 #include "sh_mobile_lcdcfb.h"
 
@@ -217,7 +216,6 @@ struct sh_mobile_lcdc_priv {
 	struct notifier_block notifier;
 	int started;
 	int forced_fourcc; /* 2 channel LCDC must share fourcc setting */
-	struct sh_mobile_meram_info *meram_dev;
 };
 
 /* -----------------------------------------------------------------------------
@@ -346,16 +344,12 @@ static void sh_mobile_lcdc_clk_on(struct sh_mobile_lcdc_priv *priv)
 		if (priv->dot_clk)
 			clk_prepare_enable(priv->dot_clk);
 		pm_runtime_get_sync(priv->dev);
-		if (priv->meram_dev && priv->meram_dev->pdev)
-			pm_runtime_get_sync(&priv->meram_dev->pdev->dev);
 	}
 }
 
 static void sh_mobile_lcdc_clk_off(struct sh_mobile_lcdc_priv *priv)
 {
 	if (atomic_sub_return(1, &priv->hw_usecnt) == -1) {
-		if (priv->meram_dev && priv->meram_dev->pdev)
-			pm_runtime_put_sync(&priv->meram_dev->pdev->dev);
 		pm_runtime_put(priv->dev);
 		if (priv->dot_clk)
 			clk_disable_unprepare(priv->dot_clk);
@@ -1073,7 +1067,6 @@ static void __sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 
 static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 {
-	struct sh_mobile_meram_info *mdev = priv->meram_dev;
 	struct sh_mobile_lcdc_chan *ch;
 	unsigned long tmp;
 	int ret;
@@ -1106,9 +1099,6 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 
 	/* Compute frame buffer base address and pitch for each channel. */
 	for (k = 0; k < ARRAY_SIZE(priv->ch); k++) {
-		int pixelformat;
-		void *cache;
-
 		ch = &priv->ch[k];
 		if (!ch->enabled)
 			continue;
@@ -1117,45 +1107,6 @@ static int sh_mobile_lcdc_start(struct sh_mobile_lcdc_priv *priv)
 		ch->base_addr_c = ch->dma_handle
 				+ ch->xres_virtual * ch->yres_virtual;
 		ch->line_size = ch->pitch;
-
-		/* Enable MERAM if possible. */
-		if (mdev == NULL || ch->cfg->meram_cfg == NULL)
-			continue;
-
-		/* Free the allocated MERAM cache. */
-		if (ch->cache) {
-			sh_mobile_meram_cache_free(mdev, ch->cache);
-			ch->cache = NULL;
-		}
-
-		switch (ch->format->fourcc) {
-		case V4L2_PIX_FMT_NV12:
-		case V4L2_PIX_FMT_NV21:
-		case V4L2_PIX_FMT_NV16:
-		case V4L2_PIX_FMT_NV61:
-			pixelformat = SH_MOBILE_MERAM_PF_NV;
-			break;
-		case V4L2_PIX_FMT_NV24:
-		case V4L2_PIX_FMT_NV42:
-			pixelformat = SH_MOBILE_MERAM_PF_NV24;
-			break;
-		case V4L2_PIX_FMT_RGB565:
-		case V4L2_PIX_FMT_BGR24:
-		case V4L2_PIX_FMT_BGR32:
-		default:
-			pixelformat = SH_MOBILE_MERAM_PF_RGB;
-			break;
-		}
-
-		cache = sh_mobile_meram_cache_alloc(mdev, ch->cfg->meram_cfg,
-					ch->pitch, ch->yres, pixelformat,
-					&ch->line_size);
-		if (!IS_ERR(cache)) {
-			sh_mobile_meram_cache_update(mdev, cache,
-					ch->base_addr_y, ch->base_addr_c,
-					&ch->base_addr_y, &ch->base_addr_c);
-			ch->cache = cache;
-		}
 	}
 
 	for (k = 0; k < ARRAY_SIZE(priv->overlays); ++k) {
@@ -1223,13 +1174,6 @@ static void sh_mobile_lcdc_stop(struct sh_mobile_lcdc_priv *priv)
 		}
 
 		sh_mobile_lcdc_display_off(ch);
-
-		/* Free the MERAM cache. */
-		if (ch->cache) {
-			sh_mobile_meram_cache_free(priv->meram_dev, ch->cache);
-			ch->cache = NULL;
-		}
-
 	}
 
 	/* stop the lcdc */
@@ -1851,11 +1795,6 @@ static int sh_mobile_lcdc_pan(struct fb_var_screeninfo *var,
 	base_addr_c = ch->dma_handle + ch->xres_virtual * ch->yres_virtual
 		    + c_offset;
 
-	if (ch->cache)
-		sh_mobile_meram_cache_update(priv->meram_dev, ch->cache,
-					     base_addr_y, base_addr_c,
-					     &base_addr_y, &base_addr_c);
-
 	ch->base_addr_y = base_addr_y;
 	ch->base_addr_c = base_addr_c;
 	ch->pan_y_offset = y_offset;
@@ -2718,7 +2657,7 @@ static int sh_mobile_lcdc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->dev = &pdev->dev;
-	priv->meram_dev = pdata->meram_dev;
+
 	for (i = 0; i < ARRAY_SIZE(priv->ch); i++)
 		mutex_init(&priv->ch[i].open_lock);
 	platform_set_drvdata(pdev, priv);
diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.h b/drivers/video/fbdev/sh_mobile_lcdcfb.h
index cc52c74..b8e47a8 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.h
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.h
@@ -61,7 +61,6 @@ struct sh_mobile_lcdc_chan {
 	unsigned long *reg_offs;
 	unsigned long ldmt1r_value;
 	unsigned long enabled; /* ME and SE in LDCNT2R */
-	void *cache;
 
 	struct mutex open_lock;		/* protects the use counter */
 	int use_count;
diff --git a/include/video/sh_mobile_lcdc.h b/include/video/sh_mobile_lcdc.h
index f706b0fe..84aa976 100644
--- a/include/video/sh_mobile_lcdc.h
+++ b/include/video/sh_mobile_lcdc.h
@@ -3,7 +3,6 @@
 #define __ASM_SH_MOBILE_LCDC_H__
 
 #include <linux/fb.h>
-#include <video/sh_mobile_meram.h>
 
 /* Register definitions */
 #define _LDDCKR			0x410
@@ -184,7 +183,6 @@ struct sh_mobile_lcdc_chan_cfg {
 	struct sh_mobile_lcdc_panel_cfg panel_cfg;
 	struct sh_mobile_lcdc_bl_info bl_info;
 	struct sh_mobile_lcdc_sys_bus_cfg sys_bus_cfg; /* only for SYSn I/F */
-	const struct sh_mobile_meram_cfg *meram_cfg;
 
 	struct platform_device *tx_dev;	/* HDMI/DSI transmitter device */
 };
@@ -193,7 +191,6 @@ struct sh_mobile_lcdc_info {
 	int clock_source;
 	struct sh_mobile_lcdc_chan_cfg ch[2];
 	struct sh_mobile_lcdc_overlay_cfg overlays[4];
-	struct sh_mobile_meram_info *meram_dev;
 };
 
 #endif /* __ASM_SH_MOBILE_LCDC_H__ */
-- 
1.9.1
