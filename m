Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753449AbeBLRdP (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Feb 2018 12:33:15 -0500
Received: from fllnx209.ext.ti.com ([198.47.19.16]:23021 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751200AbeBLRdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Feb 2018 12:33:12 -0500
Subject: Re: [PATCH 0/2] GPIO-OMAP: Adjustments for omap_gpio_probe()
To: SF Markus Elfring <elfring@users.sourceforge.net>,
        <linux-gpio@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Santosh Shilimkar <ssantosh@kernel.org>
CC: LKML <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>
References: <8ec31664-badc-5454-b759-ae9132833589@users.sourceforge.net>
From: Grygorii Strashko <grygorii.strashko@ti.com>
Message-ID: <f6e04efd-061e-a534-c821-ac717d90904b@ti.com>
Date: Mon, 12 Feb 2018 11:33:02 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <8ec31664-badc-5454-b759-ae9132833589@users.sourceforge.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.247.59.147]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/10/2018 03:05 PM, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 10 Feb 2018 21:56:54 +0100
> 
> Two update suggestions were taken into account
> from static source code analysis.
> 
> Markus Elfring (2):
>    Delete an error message for a failed memory allocation
>    Improve a size determination
> 
>   drivers/gpio/gpio-omap.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 

For series:
Acked-by: Grygorii Strashko <grygorii.strashko@ti.com>

-- 
regards,
-grygorii
