Return-Path: <SRS0=r0+/=Q4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25384C43381
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:40:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F01A92083B
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Feb 2019 16:40:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbfBUQkK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 Feb 2019 11:40:10 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:41487 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725831AbfBUQkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Feb 2019 11:40:08 -0500
Received: by mail-ed1-f65.google.com with SMTP id x7so23687667eds.8
        for <linux-kernel@vger.kernel.org>; Thu, 21 Feb 2019 08:40:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3pQY6z8l1l6LG2RHkNvh+4xqEBF5VXb30JKt1h7j9Jg=;
        b=TkkCnYP3kwwK2VaRcmxI68y9keDl2lFZZQ9pAwgrXsGzvCtW96QfKRHDmCyA4LZYyC
         La+YP55ysCivkbF+7r34XNmL3wWJYjKPl6r87Uo61Q4flV7TOl++kRK/rZudzxlhr2AB
         rrlZ6jo57RASL0rsKG7BCHG6j6rcF0cbuvpIh+wQZcejWlJLNgt2+lDAckAgID2+BvKG
         FkhgtDpECWWiwop7lwfG5wKpFF3KZtrfL5/VJYUEt1jPSafi1AnrCMgc1A0DljT7FIvh
         WxuX3tJQVI8selfBBf3ViLoZqZYBZ9W/VwZxe88tX1BLZhq1anaJZKloWSOSH9D4qzTt
         /xqg==
X-Gm-Message-State: AHQUAuZS8VEBvJKUbimvVfLOyrRzJhVDKgj7Pn0vkUQNe79m+feREIhY
        EXAW5TqSaZX+WcQwgLwVxUjaSE5Dj58=
X-Google-Smtp-Source: AHgI3IZuxeo/lgn9SiduTTc4ZE/tj6Y4ecXMth/vamMIkl4/AEXhiIMwjt9/IgIEJsvZoy/ssh3UrA==
X-Received: by 2002:a05:6402:120b:: with SMTP id c11mr14527422edw.119.1550767206845;
        Thu, 21 Feb 2019 08:40:06 -0800 (PST)
Received: from shalem.localdomain (546A5441.cm-12-3b.dynamic.ziggo.nl. [84.106.84.65])
        by smtp.gmail.com with ESMTPSA id j4sm6796824edh.69.2019.02.21.08.40.05
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 21 Feb 2019 08:40:06 -0800 (PST)
Subject: Re: [PATCH] staging/vboxvideo: Another FIXME item
To:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Liviu Dudau <liviu.dudau@arm.com>
References: <20190221155951.19855-1-daniel.vetter@ffwll.ch>
From:   Hans de Goede <hdegoede@redhat.com>
Message-ID: <33679003-ce23-2ba0-d8c2-fd8187ecea36@redhat.com>
Date:   Thu, 21 Feb 2019 17:40:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <20190221155951.19855-1-daniel.vetter@ffwll.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 21-02-19 16:59, Daniel Vetter wrote:
> Found while grepping around.
> 
> Signed-off-by: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Hans de Goede <hdegoede@redhat.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Sam Ravnborg <sam@ravnborg.org>
> Cc: Daniel Vetter <daniel.vetter@ffwll.ch>
> Cc: Liviu Dudau <liviu.dudau@arm.com>
> ---
>   drivers/staging/vboxvideo/vbox_irq.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/staging/vboxvideo/vbox_irq.c b/drivers/staging/vboxvideo/vbox_irq.c
> index 195484713365..89944134ea86 100644
> --- a/drivers/staging/vboxvideo/vbox_irq.c
> +++ b/drivers/staging/vboxvideo/vbox_irq.c
> @@ -123,6 +123,11 @@ static void vbox_update_mode_hints(struct vbox_private *vbox)
>   
>   	validate_or_set_position_hints(vbox);
>   	drm_modeset_lock_all(dev);
> +	/*
> +	 * FIXME: this needs to use drm_connector_list_iter and some real
> +	 * locking for the actual data it changes, not the deprecated
> +	 * drm_modeset_lock_all() shotgun approach.
> +	 */

Question, are the locking expectations from the drm's core pov (for modesetting-drivers)
*fully* (and clearly) documented somewhere?

Regards,

Hans




>   	list_for_each_entry(connector, &dev->mode_config.connector_list, head) {
>   		vbox_conn = to_vbox_connector(connector);
>   
> 
