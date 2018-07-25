Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5AD2C6778F
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:33:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 885D820843
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 22:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="MROx9E7h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 885D820843
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731671AbeGYXqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 19:46:50 -0400
Received: from perceval.ideasonboard.com ([213.167.242.64]:38568 "EHLO
        perceval.ideasonboard.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729182AbeGYXqu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 19:46:50 -0400
Received: from avalon.localnet (dfj612ybrt5fhg77mgycy-3.rev.dnainternet.fi [IPv6:2001:14ba:21f5:5b00:2e86:4862:ef6a:2804])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5DA80B88;
        Thu, 26 Jul 2018 00:33:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1532557982;
        bh=c4KRsuNB7YXexT1pprt4fhYgtduGpL7xm1EPX9vpjCs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MROx9E7hXShfy/F+NhGsohcZU9ro8ZQjv1583M0dj7BqFOY717o9d40HpL/t//YLM
         jL2Z8WkKbiS+iZM/3VoTOAqV6EHcE8Q7XrmR/eeeylhH4M2q3HBXwlk+s9qmkFQpgx
         z9muIlUXJrdhfPylbL36nTHgFQ2j57q2xHc8kRlI=
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Sean Paul <seanpaul@chromium.org>,
        dri-devel@lists.freedesktop.org,
        Andrzej Hajda <a.hajda@samsung.com>,
        Archit Taneja <architt@codeaurora.org>,
        linux-kernel@vger.kernel.org,
        Russell King <rmk+kernel@armlinux.org.uk>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Hans Verkuil <hans.verkuil@cisco.com>,
        David Airlie <airlied@linux.ie>
Subject: Re: [RESEND PATCH] drm/bridge/synopsys: remove commented-out flag in Makefile
Date:   Thu, 26 Jul 2018 01:33:38 +0300
Message-ID: <3967540.Er9dya7yYh@avalon>
Organization: Ideas on Board Oy
In-Reply-To: <1532496348-11589-1-git-send-email-yamada.masahiro@socionext.com>
References: <1532496348-11589-1-git-send-email-yamada.masahiro@socionext.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Masahiro-san,

Thank you for the patch.

On Wednesday, 25 July 2018 08:25:48 EEST Masahiro Yamada wrote:
> Please do not comment out unneeded code.  Remove.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
> 
>  drivers/gpu/drm/bridge/synopsys/Makefile | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/bridge/synopsys/Makefile
> b/drivers/gpu/drm/bridge/synopsys/Makefile index 5dad97d..3e1b1e3 100644
> --- a/drivers/gpu/drm/bridge/synopsys/Makefile
> +++ b/drivers/gpu/drm/bridge/synopsys/Makefile
> @@ -1,5 +1,3 @@
> -#ccflags-y := -Iinclude/drm
> -
>  obj-$(CONFIG_DRM_DW_HDMI) += dw-hdmi.o
>  obj-$(CONFIG_DRM_DW_HDMI_AHB_AUDIO) += dw-hdmi-ahb-audio.o
>  obj-$(CONFIG_DRM_DW_HDMI_I2S_AUDIO) += dw-hdmi-i2s-audio.o

-- 
Regards,

Laurent Pinchart



