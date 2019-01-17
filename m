Return-Path: <SRS0=R5eS=PZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C5D0C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:15:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0D663205C9
	for <linux-kernel@archiver.kernel.org>; Thu, 17 Jan 2019 14:15:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbfAQOPV convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 09:15:21 -0500
Received: from mout.gmx.net ([212.227.15.18]:56141 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbfAQOPU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 09:15:20 -0500
Received: from [91.14.66.187] ([91.14.66.187]) by web-mail.gmx.net
 (3c-app-gmx-bs28.server.lan [172.19.170.80]) (via HTTP); Thu, 17 Jan 2019
 15:14:12 +0100
MIME-Version: 1.0
Message-ID: <trinity-1adab8be-573a-4816-9e9f-feddf07bdcd3-1547734452313@3c-app-gmx-bs28>
From:   "Frank Wunderlich" <frank-w@public-files.de>
To:     "CK Hu" <ck.hu@mediatek.com>
Cc:     "Philipp Zabel" <p.zabel@pengutronix.de>,
        "David Airlie" <airlied@linux.ie>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        =?UTF-8?Q?=22Noralf_Tr=EF=BF=BDnnes=22?= <noralf@tronnes.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        srv_heupstream@mediatek.com, "CK Hu" <ck.hu@mediatek.com>
Subject: Aw: [PATCH 2/2] drm/mediatek: Add Mediatek framebuffer device
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 17 Jan 2019 15:14:12 +0100
Importance: normal
Sensitivity: Normal
In-Reply-To: <20190116013924.11345-2-ck.hu@mediatek.com>
References: <20190116013924.11345-1-ck.hu@mediatek.com>
 <20190116013924.11345-2-ck.hu@mediatek.com>
Content-Transfer-Encoding: 8BIT
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:ZCXujUahy4rjWoxPg/1yVwlO0qAajHDw4P89dYpDctPb15HiyLPXx2moE+1sexaDO5ywL
 VOJ4OKznWVdagZJJWCvIV3JtzRKkK73Mt0VNMnm6BQOrWJHnvOHdtJASD9zHYw8xPbWEwB/8bBko
 dIXHWzv0RQRVKTkfS/xiaOwgIUK2kNPtIVEAFnUJdp5Zpoelh9YteSYewQmSJH55rRl3KGn1FEMi
 Ss1APqWlLJvUt32lUSft+uMJSYJGgNfrINavRMnvAsHSqRxENtLelpry3np+yADRN7sNbMfKJ04r
 e0=
X-UI-Out-Filterresults: notjunk:1;V03:K0:GpvUPjUexyI=:tCCUqaY+pQHNs9CSsYO9fi
 Z7abOvN+j51mJptyhbB8/uwj1h8nnTUtPsvCPsxsDMJKOY0eww0q1iUkHlHeIUmBS/53VeUC3
 YOGpyBz28goZzYrKZdbOdEYPrn0wTGRMcEPOmKpJcCxrxOZibZO0rXuaHVsD/0pN8FFSsDCVB
 t808m5aGh784fRQNg7cO9XlPw9eMCLCsFWNPv1lYnnvWPk1g1MqlvWSwvi2CjS8XoU54oYcgk
 Rn+kPJKk9yIqIHEL3yvxY2AOepTlhWuAePDWpqIp1ajiISekIHAxTkTFvazaynkci+Gz8qRF8
 vls2pQORQ1i0AixoWinAC+7PsMPCsTVCv9097Us/oNVlX+d450+z1QFQRHxJgWHLr4JWo+mZn
 sU40dtSIKOS8i1NZB/bdFvi0g08Tq6wY0Z5dUWAkvvHbw5+iGRgCRvNBqYwSf9B5vcg/RZnlV
 1+2bP10ndvBRCBVw6GSmfrwf26u6MjPNirSlgvPkaJUmmh7fXewjpWCZ2BxBRCOZRHUOgZiAB
 6f3qc62oANP8oMR4FaYLwNqXa1B9qqlQbFFzTD+e9Rvi5WAMeHoZDQhieYaTaRQkKOUfAgBJC
 qnTp2JAUwn2E4=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this Patchset does not hang on Bananapi R2, but does not show anything on FB-Console...seems anything is missing

https://github.com/frank-w/BPI-R2-4.14/tree/4.20-fbdev

dmesg | grep 'fb\|framebuffer'
[    0.000000] Linux version 4.20.0-rc7-bpi-r2-fbdev (frank@frank-N56VZ) (gcc version 7.3.0 (Ubuntu/Linaro 7.3.0-27ubuntu1~18.04)) 9
[    0.000000] cma: Reserved 64 MiB at 0xfb800000
[    0.000000] Kernel command line: board=bpi-r2 console=earlyprintk console=tty1 fbcon=map:0 console=ttyS0,115200 root=/dev/mmcblk7
[    5.733185] [drm:drm_fb_helper_generic_probe] surface width(1280), height(1024) and bpp(32)
[    5.754452] [drm:drm_mode_addfb2] [FB:44]
[    5.792878] mediatek-drm 14000000.dispsys: fb0: DRM emulated frame buffer device
[    5.814067] [drm:drm_fb_helper_hotplug_event.part.11] 
[    6.203083] mediatek-drm 14000000.dispsys: [drm:drm_client_dev_hotplug] fbdev: ret=0
[   24.930347] mediatek-drm 14000000.dispsys: [drm:drm_client_dev_restore] fbdev: ret=0
[   25.196872] mediatek-drm 14000000.dispsys: [drm:drm_client_dev_restore] fbdev: ret=0
[   25.281184] [drm:drm_mode_addfb2] [FB:49]
[   27.947962] [drm:drm_mode_addfb2] [FB:49]

regards Frank


> Gesendet: Mittwoch, 16. Januar 2019 um 02:39 Uhr
> Von: "CK Hu" <ck.hu@mediatek.com>
> An: "Philipp Zabel" <p.zabel@pengutronix.de>, "David Airlie" <airlied@linux.ie>, "Daniel Vetter" <daniel@ffwll.ch>, "Matthias Brugger" <matthias.bgg@gmail.com>, "Noralf Tr�nnes" <noralf@tronnes.org>, "Frank Wunderlich" <frank-w@public-files.de>
> Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org, srv_heupstream@mediatek.com, "CK Hu" <ck.hu@mediatek.com>
> Betreff: [PATCH 2/2] drm/mediatek: Add Mediatek framebuffer device
>
> For Mediatek drm driver, use fbdev emulation to create a framebuffer
> device.
> 
> Signed-off-by: CK Hu <ck.hu@mediatek.com>
> ---
>  drivers/gpu/drm/mediatek/mtk_drm_drv.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> index 6ec4ca070382..5fcc0e294696 100644
> --- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> +++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
> @@ -16,6 +16,7 @@
>  #include <drm/drm_atomic.h>
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_crtc_helper.h>
> +#include <drm/drm_fb_helper.h>
>  #include <drm/drm_gem.h>
>  #include <drm/drm_gem_cma_helper.h>
>  #include <drm/drm_of.h>
> @@ -378,6 +379,10 @@ static int mtk_drm_bind(struct device *dev)
>  	if (ret < 0)
>  		goto err_deinit;
>  
> +	ret = drm_fbdev_generic_setup(drm, 32);
> +	if (ret)
> +		DRM_ERROR("Failed to initialize fbdev: %d\n", ret);
> +
>  	return 0;
>  
>  err_deinit:
> -- 
> 2.18.1
> 
>
