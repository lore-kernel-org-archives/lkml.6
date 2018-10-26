Return-Path: <SRS0=FPao=NG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26F59C6786E
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:11:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED60C207DD
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Oct 2018 11:11:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ED60C207DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727596AbeJZTrz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 15:47:55 -0400
Received: from mail-ed1-f65.google.com ([209.85.208.65]:45801 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727224AbeJZTry (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 15:47:54 -0400
Received: by mail-ed1-f65.google.com with SMTP id t10-v6so913288eds.12
        for <linux-kernel@vger.kernel.org>; Fri, 26 Oct 2018 04:11:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Sk3aqzbcH+P51a7Z1ePWGGB2+48CcYPa0UIpdakUXBM=;
        b=S2/IVOZlnhOsT3AfHKZ7LIqwHZh1Vz6jiTz7fOUboCK4WtYjMxJFDrbERq94h5n7XI
         awNkDWDP98CK7gpJMw2azRWf53D5ewAi01JbGA//524sJ7OexgS6h3lvRGvZ5fagmyUn
         4Mlb18dOZtGf2MA9ATWCT86y6HtYad8DIK+mu2ABDA2KF1gkdmhbJfQY7U3F01nF6JNp
         zrXLGENVghq2aP/cmEHR9vRdRttb54cqlfoLdJ9E70jHryKe1eDiGt2ZgKRqnY+o7Wsg
         7wzAvz0ttD8ezzgSQfEfeCFHtagYGZBWDCzZaVOXyG7PJVSOy98rvLI2z+hpAH8HRNq1
         2rCw==
X-Gm-Message-State: AGRZ1gLsRjMhDFNw8gQxaTQXVUGE4cXOnenW6rsZQ88/z5MySIIStnwg
        c9A8BQ9R1Dst3vyIcv0ajcLw/A==
X-Google-Smtp-Source: AJdET5dxswmfz4zymbEazUViw0mQyN7Zt3E7klmbvxJ6hOzPIk9BoD3FcoimausL0519TBVgLLRg0w==
X-Received: by 2002:a17:906:1141:: with SMTP id i1-v6mr2119089eja.110.1540552273228;
        Fri, 26 Oct 2018 04:11:13 -0700 (PDT)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id g6-v6sm1356856edc.38.2018.10.26.04.11.12
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 26 Oct 2018 04:11:12 -0700 (PDT)
Subject: Re: [PATCH v2] staging: vboxvideo: Remove unnecessary parentheses
To:     Shayenne da Luz Moura <shayenneluzmoura@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Michael Thayer <michael.thayer@oracle.com>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        outreachy-kernel@googlegroups.com
References: <20181023174304.iq4ra7vafwujr3ex@smtp.gmail.com>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <70a66c27-eced-89ae-79fc-af3d0aa06311@redhat.com>
Date:   Fri, 26 Oct 2018 13:11:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
In-Reply-To: <20181023174304.iq4ra7vafwujr3ex@smtp.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23-10-18 19:43, Shayenne da Luz Moura wrote:
> Remove unneeded parentheses around the arguments of ||. This reduces
> clutter and code behave in the same way.
> Change suggested by checkpatch.pl.
> 
> vbox_main.c:119: CHECK: Unnecessary parentheses around 'rects[i].x2 <
> crtc->x'
> 
> Signed-off-by: Shayenne da Luz Moura <shayenneluzmoura@gmail.com>

Patch looks good to me:

Reviewed-by: Hans de Goede <hdegoede@redhat.com>

Regards,

Hans


> ---
> Changes in v2:
>    - Make the commit message more clearer.
>   
>   drivers/staging/vboxvideo/vbox_main.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/vboxvideo/vbox_main.c b/drivers/staging/vboxvideo/vbox_main.c
> index 429f6a453619..10a862674789 100644
> --- a/drivers/staging/vboxvideo/vbox_main.c
> +++ b/drivers/staging/vboxvideo/vbox_main.c
> @@ -116,10 +116,10 @@ void vbox_framebuffer_dirty_rectangles(struct drm_framebuffer *fb,
>   			struct vbva_cmd_hdr cmd_hdr;
>   			unsigned int crtc_id = to_vbox_crtc(crtc)->crtc_id;
>   
> -			if ((rects[i].x1 > crtc->x + crtc->hwmode.hdisplay) ||
> -			    (rects[i].y1 > crtc->y + crtc->hwmode.vdisplay) ||
> -			    (rects[i].x2 < crtc->x) ||
> -			    (rects[i].y2 < crtc->y))
> +			if (rects[i].x1 > crtc->x + crtc->hwmode.hdisplay ||
> +			    rects[i].y1 > crtc->y + crtc->hwmode.vdisplay ||
> +			    rects[i].x2 < crtc->x ||
> +			    rects[i].y2 < crtc->y)
>   				continue;
>   
>   			cmd_hdr.x = (s16)rects[i].x1;
> 
