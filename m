Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752861AbeA3F3t (ORCPT <rfc822;w@1wt.eu>);
        Tue, 30 Jan 2018 00:29:49 -0500
Received: from mail-pf0-f194.google.com ([209.85.192.194]:45321 "EHLO
        mail-pf0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752809AbeA3F3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jan 2018 00:29:47 -0500
X-Google-Smtp-Source: AH8x226FbquI9eHe45gjAyfNZtmbpVRSP9iLVCxfjoHbuXhiuDvDgJvUsAoH4tkoeQMIm1wPSaZfBw==
From: Daniel Axtens <dja@axtens.net>
To: Larry Finger <Larry.Finger@lwfinger.net>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] macintosh: Add module license to ans-lcd
In-Reply-To: <20180129193308.25373-1-Larry.Finger@lwfinger.net>
References: <20180129193308.25373-1-Larry.Finger@lwfinger.net>
Date: Tue, 30 Jan 2018 16:29:41 +1100
Message-ID: <878tcfsym2.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

That matches the SPDX identifier from the top of the file, so:

Reviewed-by: Daniel Axtens <dja@axtens.net>

Regards,
Daniel

Larry Finger <Larry.Finger@lwfinger.net> writes:

> In kernel 4.15, the modprobe step on my PowerBook G5 started complaining that
> there was no module license for ans-lcd.
>
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> ---
>  drivers/macintosh/ans-lcd.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/macintosh/ans-lcd.c b/drivers/macintosh/ans-lcd.c
> index 1de81d922d8a..c8e078b911c7 100644
> --- a/drivers/macintosh/ans-lcd.c
> +++ b/drivers/macintosh/ans-lcd.c
> @@ -201,3 +201,4 @@ anslcd_exit(void)
>  
>  module_init(anslcd_init);
>  module_exit(anslcd_exit);
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.16.1
