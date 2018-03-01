Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030988AbeCANqY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 08:46:24 -0500
Received: from mail.bootlin.com ([62.4.15.54]:45766 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1030762AbeCANqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 08:46:22 -0500
Date: Thu, 1 Mar 2018 14:46:20 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
To: Justin Chen <justin.chen@broadcom.com>
Cc: linux-rtc@vger.kernel.org, a.zummo@towertech.it,
        computersforpeace@gmail.com, gregory.0xf0@gmail.com,
        f.fainelli@gmail.com, linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org,
        Justin Chen <justinpopo6@gmail.com>
Subject: Re: [PATCH v2] rtc: brcmstb-waketimer: Set wktmr prescaler
Message-ID: <20180301134620.GX1479@piout.net>
References: <1519675798-26720-1-git-send-email-justin.chen@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1519675798-26720-1-git-send-email-justin.chen@broadcom.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/02/2018 at 12:09:58 -0800, Justin Chen wrote:
> The HW default is one tick per second, however instead of assuming this,
> lets make sure the waketimer is actually one tick per second before
> arming the alarm.
> 
> Reviewed-by: Florian Fainelli <f.fainelli@gmail.com>
> Signed-off-by: Justin Chen <justinpopo6@gmail.com>
> ---
>  drivers/rtc/rtc-brcmstb-waketimer.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
Applied, thanks.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
