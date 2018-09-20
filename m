Return-Path: <SRS0=4ISz=MC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41DA8ECE566
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:02:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5AA121533
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Sep 2018 20:02:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=agner.ch header.i=@agner.ch header.b="a4pFS0BK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5AA121533
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=agner.ch
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388242AbeIUBrm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Sep 2018 21:47:42 -0400
Received: from mail.kmu-office.ch ([178.209.48.109]:41504 "EHLO
        mail.kmu-office.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731832AbeIUBrm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Sep 2018 21:47:42 -0400
Received: from webmail.kmu-office.ch (unknown [IPv6:2a02:418:6a02::a3])
        by mail.kmu-office.ch (Postfix) with ESMTPSA id 099FF5C08FA;
        Thu, 20 Sep 2018 22:02:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=agner.ch; s=dkim;
        t=1537473753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YCepKQLbNoPMlFTpdIbW9WUQioNcZevADyT1MpxiP4U=;
        b=a4pFS0BKzonH0DQxybNK7YxLRQYOHt/B1xoeEfwQCrSAyPCg0bpKNu1ExmMwJ8CLmdZYJn
        fC4kLBNeY+Q2S7KgybSnhRw4momMvt6VXWszY3fRQJ7NmKZXovi5AK/Qx6RgipVSE6vBYH
        +5ujf6X5b2JcQBAeD7VuiTcZsiAOTjU=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date:   Thu, 20 Sep 2018 13:02:32 -0700
From:   Stefan Agner <stefan@agner.ch>
To:     Sean Paul <sean@poorly.run>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Sean Paul <seanpaul@chromium.org>, Marek Vasut <marex@denx.de>,
        David Airlie <airlied@linux.ie>,
        Gustavo Padovan <gustavo@padovan.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
Subject: Re: [PATCH 2/2] MAINTAINERS: Move mxsfb drm driver to drm-misc tree
In-Reply-To: <20180919204026.3217-2-sean@poorly.run>
References: <20180919204026.3217-1-sean@poorly.run>
 <20180919204026.3217-2-sean@poorly.run>
Message-ID: <17901cc4b8b8e9b8d0c69fa9dea8111b@agner.ch>
X-Sender: stefan@agner.ch
User-Agent: Roundcube Webmail/1.3.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19.09.2018 13:39, Sean Paul wrote:
> From: Sean Paul <seanpaul@chromium.org>
> 
> Another "small driver" moving into drm-misc. Stefan has also offered to
> co-maintain it.
> 
> Cc: Marek Vasut <marex@denx.de>
> Cc: Stefan Agner <stefan@agner.ch>
> Cc: David Airlie <airlied@linux.ie>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
> Signed-off-by: Sean Paul <seanpaul@chromium.org>

Thanks Sean,

Acked-by: Stefan Agner <stefan@agner.ch>

--
Stefan

> ---
>  MAINTAINERS | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ba1dbb8735b8..7184d53dcbd8 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9891,9 +9891,12 @@ F:	drivers/media/tuners/mxl5007t.*
>  
>  MXSFB DRM DRIVER
>  M:	Marek Vasut <marex@denx.de>
> +M:	Stefan Agner <stefan@agner.ch>
> +L:	dri-devel@lists.freedesktop.org
>  S:	Supported
>  F:	drivers/gpu/drm/mxsfb/
>  F:	Documentation/devicetree/bindings/display/mxsfb.txt
> +T:	git git://anongit.freedesktop.org/drm/drm-misc
>  
>  MYRICOM MYRI-10G 10GbE DRIVER (MYRI10GE)
>  M:	Chris Lee <christopher.lee@cspi.com>
