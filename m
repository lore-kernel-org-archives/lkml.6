Return-Path: <SRS0=Q/hc=JL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB42EC43142
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:43:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 973A024054
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Jun 2018 13:43:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="SqkUo6TC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 973A024054
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934172AbeFYNni (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Jun 2018 09:43:38 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:46040 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933985AbeFYNng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jun 2018 09:43:36 -0400
Received: from avalon.localnet (p010035.dynamic.ppp.asahi-net.or.jp [221.113.10.35])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id E8E2C1ABB;
        Mon, 25 Jun 2018 15:43:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1529934214;
        bh=JC5rDIDU3jYI5BGI7o4vG3cbgr77Z+B/cEewApjdO/E=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SqkUo6TC5+g2Neu/ofnKk2kPJIXFsm4KtRJSz9piU0emTWI4RtvFRw7eZpSS+k8xw
         6HsV5e5sobi3s+pRIKwIAulJKky7Kq9gUY+hWTkx9lkKDZoWLz7jrS+lgp3KqZBMR0
         Ay2gC1svrT1N7jWuuIYQ9un/9T/FTiQRoISMPbo0=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Daniel Graefe <daniel.graefe@fau.de>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        devel@driverdev.osuosl.org, linux-kernel@i4.cs.fau.de,
        Roman Sommer <roman.sommer@fau.de>
Subject: Re: [PATCH] staging: media: omap4iss: Added SPDX license identifiers
Date:   Mon, 25 Jun 2018 16:43:52 +0300
Message-ID: <4457555.NGJh9sI2kl@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1529932892-9036-1-git-send-email-daniel.graefe@fau.de>
References: <1529932892-9036-1-git-send-email-daniel.graefe@fau.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

Thank you for the patch.

On Monday, 25 June 2018 16:21:32 EEST Daniel Graefe wrote:
> Added missing SPDX license identifiers to all files of the omap4iss
> driver.
> 
> Most files already have license texts which clearly state them to be
> licensed under GPL 2.0 or later. SPDX identifiers were added accordingly.
> 
> Some files do not have any license text. SPDX identifiers for GPL 2.0
> were added to them, in accordance with the default license of the
> kernel.
> 
> Signed-off-by: Daniel Graefe <daniel.graefe@fau.de>
> Signed-off-by: Roman Sommer <roman.sommer@fau.de>
> ---
>  drivers/staging/media/omap4iss/Kconfig       | 2 ++
>  drivers/staging/media/omap4iss/Makefile      | 3 +++
>  drivers/staging/media/omap4iss/iss.c         | 1 +
>  drivers/staging/media/omap4iss/iss.h         | 1 +
>  drivers/staging/media/omap4iss/iss_csi2.c    | 1 +
>  drivers/staging/media/omap4iss/iss_csi2.h    | 1 +
>  drivers/staging/media/omap4iss/iss_csiphy.c  | 1 +
>  drivers/staging/media/omap4iss/iss_csiphy.h  | 1 +
>  drivers/staging/media/omap4iss/iss_ipipe.c   | 1 +
>  drivers/staging/media/omap4iss/iss_ipipe.h   | 1 +
>  drivers/staging/media/omap4iss/iss_ipipeif.c | 1 +
>  drivers/staging/media/omap4iss/iss_ipipeif.h | 1 +
>  drivers/staging/media/omap4iss/iss_regs.h    | 1 +
>  drivers/staging/media/omap4iss/iss_resizer.c | 1 +
>  drivers/staging/media/omap4iss/iss_resizer.h | 1 +
>  drivers/staging/media/omap4iss/iss_video.c   | 1 +
>  drivers/staging/media/omap4iss/iss_video.h   | 1 +
>  17 files changed, 20 insertions(+)
> 
> diff --git a/drivers/staging/media/omap4iss/Kconfig
> b/drivers/staging/media/omap4iss/Kconfig index dddd273..841cc0b 100644
> --- a/drivers/staging/media/omap4iss/Kconfig
> +++ b/drivers/staging/media/omap4iss/Kconfig
> @@ -1,3 +1,5 @@
> +# SPDX-License-Identifier: GPL-2.0
> +
>  config VIDEO_OMAP4
>  	tristate "OMAP 4 Camera support"
>  	depends on VIDEO_V4L2 && VIDEO_V4L2_SUBDEV_API && I2C
> diff --git a/drivers/staging/media/omap4iss/Makefile
> b/drivers/staging/media/omap4iss/Makefile index a716ce9..e64d489 100644
> --- a/drivers/staging/media/omap4iss/Makefile
> +++ b/drivers/staging/media/omap4iss/Makefile
> @@ -1,4 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
>  # Makefile for OMAP4 ISS driver
> +#
> 
>  omap4-iss-objs += \
>  	iss.o iss_csi2.o iss_csiphy.o iss_ipipeif.o iss_ipipe.o iss_resizer.o
> iss_video.o diff --git a/drivers/staging/media/omap4iss/iss.c
> b/drivers/staging/media/omap4iss/iss.c index b1036ba..0c41939 100644
> --- a/drivers/staging/media/omap4iss/iss.c
> +++ b/drivers/staging/media/omap4iss/iss.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later

The SPDX identifier used for "GPL v2.0 or later" in the kernel is GPL-2.0+, as 
documented in Documentation/process/license-rules.rst. I'm aware that that 
identifier has been deprecated by the FSF in favour of the GPL-2.0-or-later 
identifier, but until Documentation/process/license-rules.rst gets updated, 
please use GPL-2.0+.

>  /*
>   * TI OMAP4 ISS V4L2 Driver
>   *

Could you please remove the boilerplate license text, as it's not needed 
anymore ?

Those two comments apply to all the other files.

[snip$

-- 
Regards,

Laurent Pinchart



