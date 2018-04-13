Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753751AbeDMHAG (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 03:00:06 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:54232 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753693AbeDMHAD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 03:00:03 -0400
X-Google-Smtp-Source: AIpwx4/UUuDaMaCL6qLhFLuSiQkG74P4AkdPeOJy3s/R8BbZMyIvH2Xp42DAoj95JLM4xwf7EWtdHQ==
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Mime-Version: 1.0 (Mac OS X Mail 11.3 \(3445.6.18\))
Subject: Re: [PATCH] media: cx231xx: Add support for AverMedia DVD EZMaker 7
From: Kai Heng Feng <kai.heng.feng@canonical.com>
In-Reply-To: <20180326060616.5354-1-kai.heng.feng@canonical.com>
Date: Fri, 13 Apr 2018 14:59:56 +0800
Cc: linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <BC47F34C-7BF6-4A61-9EA0-BA8C24E71F6E@canonical.com>
References: <20180326060616.5354-1-kai.heng.feng@canonical.com>
To: mchehab@kernel.org
X-Mailer: Apple Mail (2.3445.6.18)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> On Mar 26, 2018, at 2:06 PM, Kai-Heng Feng <kai.heng.feng@canonical.com>  
> wrote:
>
> User reports AverMedia DVD EZMaker 7 can be driven by VIDEO_GRABBER.
> Add the device to the id_table to make it work.

*Gentle ping*
I am hoping this patch can get merged in v4.17.

Kai-Heng

>
> BugLink: https://bugs.launchpad.net/bugs/1620762
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
> ---
>  drivers/media/usb/cx231xx/cx231xx-cards.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/drivers/media/usb/cx231xx/cx231xx-cards.c  
> b/drivers/media/usb/cx231xx/cx231xx-cards.c
> index f9ec7fedcd5b..da01c5125acb 100644
> --- a/drivers/media/usb/cx231xx/cx231xx-cards.c
> +++ b/drivers/media/usb/cx231xx/cx231xx-cards.c
> @@ -945,6 +945,9 @@ struct usb_device_id cx231xx_id_table[] = {
>  	 .driver_info = CX231XX_BOARD_CNXT_RDE_250},
>  	{USB_DEVICE(0x0572, 0x58A0),
>  	 .driver_info = CX231XX_BOARD_CNXT_RDU_250},
> +	/* AverMedia DVD EZMaker 7 */
> +	{USB_DEVICE(0x07ca, 0xc039),
> +	 .driver_info = CX231XX_BOARD_CNXT_VIDEO_GRABBER},
>  	{USB_DEVICE(0x2040, 0xb110),
>  	 .driver_info = CX231XX_BOARD_HAUPPAUGE_USB2_FM_PAL},
>  	{USB_DEVICE(0x2040, 0xb111),
> -- 
> 2.15.1
