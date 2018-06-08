Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: from smtp.codeaurora.org
	by pdx-caf-mail.web.codeaurora.org (Dovecot) with LMTP id UDa+LN4mGlvHfQAAmS7hNA
	; Fri, 08 Jun 2018 06:49:02 +0000
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
	id A44EA607DC; Fri,  8 Jun 2018 06:49:02 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=BAYES_00,MAILING_LIST_MULTI
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by smtp.codeaurora.org (Postfix) with ESMTP id 2B659601C3;
	Fri,  8 Jun 2018 06:49:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2B659601C3
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeFHGtA (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Fri, 8 Jun 2018 02:49:00 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44064 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751286AbeFHGs6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jun 2018 02:48:58 -0400
Received: by mail-qt0-f196.google.com with SMTP id l33-v6so12452786qta.11
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jun 2018 23:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=42IkTqb1xCa508lPt4/VvDW7pBcs/zPuK/+3juX36sQ=;
        b=gO6EMpliVqkO8F7Pu5KVVr4mgkrIeYmwSGIsMDS6c3jCZ2rqb1mERlF81zSeFPF+wJ
         53XwPYg5MmQ/DZjhBNYFvNRPjFK6z1/W9eHVOvCGjGXffhoNnOPSZcCRsPbJku0aSmll
         PgW/zc+ri9y8fftcJk/0QyOH9oXhITcvis6tJTrDdGijOUI8YxWkhvlutPPIgc8v7BJ/
         LkK5cjlTVcXZ6ueytSTfMAZ+ZpeSrvfTLPVNvYcm/xBnJel45CmXFqUQxLE1XnyAA1gC
         TS+hPIqCv//tbQDR0wP7APeD4xMsF9Ac80gtBvIG+lBN1xmqohk+3DzhBMc9YjhrRfyL
         KNqg==
X-Gm-Message-State: APt69E1roiMcCcfbOHA3vkesS0Gyh3+cGdUUITFzG71OjyARqmwN5PLp
        O2EZRgZH+OTSM43p90QSR8JaAfv+D6WkmNecDwJZaA==
X-Google-Smtp-Source: ADUXVKJaRQhkKr3CAMxPj5jFq2bFOXxZ7TT+DMtiTw2sW+0bG6xvxQURWWhbWNHj3ncM9z3P2HHbIaUVvSGhsti62vI=
X-Received: by 2002:a0c:92a2:: with SMTP id b31-v6mr4482008qvb.185.1528440538041;
 Thu, 07 Jun 2018 23:48:58 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:aed:2bc7:0:0:0:0:0 with HTTP; Thu, 7 Jun 2018 23:48:57 -0700 (PDT)
In-Reply-To: <20180608001450.76836-1-drinkcat@chromium.org>
References: <20180608001450.76836-1-drinkcat@chromium.org>
From: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Date: Fri, 8 Jun 2018 08:48:57 +0200
Message-ID: <CAO-hwJ+-h8r2x4ZRRwSEh_=PDphBhJML7v3FXJfjPYD0V4CcSA@mail.gmail.com>
Subject: Re: [PATCH] HID: google: Add support for whiskers
To: Nicolas Boichat <drinkcat@chromium.org>
Cc: Jiri Kosina <jikos@kernel.org>,
        "open list:HID CORE LAYER" <linux-input@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 8, 2018 at 2:14 AM, Nicolas Boichat <drinkcat@chromium.org> wrote:
> Another device in the hammer class, with USB id 0x5030.
>
> Signed-off-by: Nicolas Boichat <drinkcat@chromium.org>
> ---

Acked-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>

Cheers,
Benjamin

>  drivers/hid/hid-google-hammer.c | 2 ++
>  drivers/hid/hid-ids.h           | 1 +
>  2 files changed, 3 insertions(+)
>
> diff --git a/drivers/hid/hid-google-hammer.c b/drivers/hid/hid-google-hammer.c
> index 7b8e17b03cb86..6bf4da7ad63a5 100644
> --- a/drivers/hid/hid-google-hammer.c
> +++ b/drivers/hid/hid-google-hammer.c
> @@ -124,6 +124,8 @@ static const struct hid_device_id hammer_devices[] = {
>                      USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_STAFF) },
>         { HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
>                      USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_WAND) },
> +       { HID_DEVICE(BUS_USB, HID_GROUP_GENERIC,
> +                    USB_VENDOR_ID_GOOGLE, USB_DEVICE_ID_GOOGLE_WHISKERS) },
>         { }
>  };
>  MODULE_DEVICE_TABLE(hid, hammer_devices);
> diff --git a/drivers/hid/hid-ids.h b/drivers/hid/hid-ids.h
> index a85634fe033f0..c7981ddd87763 100644
> --- a/drivers/hid/hid-ids.h
> +++ b/drivers/hid/hid-ids.h
> @@ -452,6 +452,7 @@
>  #define USB_DEVICE_ID_GOOGLE_TOUCH_ROSE        0x5028
>  #define USB_DEVICE_ID_GOOGLE_STAFF     0x502b
>  #define USB_DEVICE_ID_GOOGLE_WAND      0x502d
> +#define USB_DEVICE_ID_GOOGLE_WHISKERS  0x5030
>
>  #define USB_VENDOR_ID_GOTOP            0x08f2
>  #define USB_DEVICE_ID_SUPER_Q2         0x007f
> --
> 2.18.0.rc1.242.g61856ae69a-goog
>
