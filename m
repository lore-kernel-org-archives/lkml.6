Return-Path: <SRS0=IMz2=NL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E1ADC0044C
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:32:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C5922084A
	for <linux-kernel@archiver.kernel.org>; Wed, 31 Oct 2018 15:32:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C5922084A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729526AbeKAAak (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 31 Oct 2018 20:30:40 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:43267 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728649AbeKAAak (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Oct 2018 20:30:40 -0400
Received: by mail-wr1-f68.google.com with SMTP id t10-v6so16959819wrn.10
        for <linux-kernel@vger.kernel.org>; Wed, 31 Oct 2018 08:32:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=dFuuzzVervNWZbqFaBXGxKSUYAoP4Ka5Yu9PHg0JzAo=;
        b=IRWKPjze8hvEs1qWiswNAKCnyd1dzzaoZTtxO/R/vZkzz1Shkc3ca/JedkuG6GkGLl
         GJhzSGBTkcoBS5HW3+PaJBsz57njCzxHb1Uez1hsjPRYScKcra7GUI8V7zyXZ+iZEsFP
         Eht2dEiyB42KiaWwGqGbLP/E0YHRUBncfWFAL6UjyBNQ5apvM+PKg0Q6OuvDHT5O0H2f
         XdELTtV5u+RYDrAXok4qru0sdQtF8Rqaki/vhG12GzncQgWTpnCmrPWKUwJ4VjRW73Uq
         AlPukaNV98o//LQjKHI22sQJMoOr2qSTDBag0dfvUo75ur9+G3aKMjPxu2y4YvhdTlGT
         9Brg==
X-Gm-Message-State: AGRZ1gJ6KQpw0Y4t1pnB9fBmyZyJx9bCiitObN2OYYa3lVwVqDrySIQi
        jFoHMifvGmGtYWEtMpDrUTo0Xg==
X-Google-Smtp-Source: AJdET5c5mFxXz5dz9L0pGn/sulA0mGKgg/+jJ71qu2a34x33wrOpmTNCwocMSjva0Xlp5np21WGcAA==
X-Received: by 2002:adf:c389:: with SMTP id p9-v6mr3397285wrf.68.1540999929555;
        Wed, 31 Oct 2018 08:32:09 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id y138-v6sm13535252wmd.2.2018.10.31.08.32.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 31 Oct 2018 08:32:08 -0700 (PDT)
Subject: Re: [PATCH v3] staging: vboxvideo: Remove unnecessary parentheses
To:     Shayenne da Luz Moura <shayenneluzmoura@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Thayer <michael.thayer@oracle.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
References: <20181031150326.yikoivqgwfurtrg4@smtp.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <989f41f2-8b65-421a-7af3-69c35e7d2594@redhat.com>
Date:   Wed, 31 Oct 2018 16:32:08 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181031150326.yikoivqgwfurtrg4@smtp.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 31-10-18 16:03, Shayenne da Luz Moura wrote:
> Remove unneeded parentheses around the arguments of ||. This reduces
> clutter and code behave in the same way.
> Change suggested by checkpatch.pl.
> 
> vbox_main.c:119: CHECK: Unnecessary parentheses around 'rects[i].x2 <
> crtc->x'
> 
> Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>

Thank you.

Still looks good to me:

Acked-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans



> ---
> Changes in v2:
>    - Make the commit message more clearer.
> 
> Changes in v3:
>    - Update to apply patch to the latest kernel tree
> 
>   drivers/staging/vboxvideo/vbox_main.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/vboxvideo/vbox_main.c b/drivers/staging/vboxvideo/vbox_main.c
> index 7466c1103ff6..ad0e0b62bd1e 100644
> --- a/drivers/staging/vboxvideo/vbox_main.c
> +++ b/drivers/staging/vboxvideo/vbox_main.c
> @@ -122,10 +122,10 @@ void vbox_framebuffer_dirty_rectangles(struct drm_framebuffer *fb,
>   			struct vbva_cmd_hdr cmd_hdr;
>   			unsigned int crtc_id = to_vbox_crtc(crtc)->crtc_id;
>   
> -			if ((rects[i].x1 > crtc_x + mode->hdisplay) ||
> -			    (rects[i].y1 > crtc_y + mode->vdisplay) ||
> -			    (rects[i].x2 < crtc_x) ||
> -			    (rects[i].y2 < crtc_y))
> +			if (rects[i].x1 > crtc_x + mode->hdisplay ||
> +			    rects[i].y1 > crtc_y + mode->vdisplay ||
> +			    rects[i].x2 < crtc_x ||
> +			    rects[i].y2 < crtc_y)
>   				continue;
>   
>   			cmd_hdr.x = (s16)rects[i].x1;
> 
