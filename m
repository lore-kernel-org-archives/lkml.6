Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751654AbeBQVTz (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Feb 2018 16:19:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:55137 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751278AbeBQVTx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Feb 2018 16:19:53 -0500
Subject: Re: [PATCH 00/10] Add Actions Semi S900 pinctrl and gpio support
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        linus.walleij@linaro.org, robh+dt@kernel.org
Cc: liuwei@actions-semi.com, mp-cs@actions-semi.com,
        96boards@ucrobotics.com, devicetree@vger.kernel.org,
        daniel.thompson@linaro.org, amit.kucheria@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
From: =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>
Organization: SUSE Linux GmbH
Message-ID: <72e49775-3a3e-0b47-61e9-079d4be6c9d9@suse.de>
Date: Sat, 17 Feb 2018 22:19:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180217204433.3095-1-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 17.02.2018 um 21:44 schrieb Manivannan Sadhasivam:
> This patchset adds pinctrl and gpio support for Actions Semi S900 SoC.
> Pinctrl and gpio subsystems share the common set of register range but
> implemented as individual drivers for making it less complex.
> 
> Pinmux functions are only accessible for pin groups while pinconf
> parameters are available for both pin groups and individual pins.
> 
> gpio-line-names has been added for the Bubblegum-96 board matching the
> 96Boards CE specification v1.0.
> 
> Both pinctrl and gpio drivers are verified using the Bubblegum-96 board.
> 
> This patchset depends on the clock driver which is still under review:
> https://lkml.org/lkml/2018/2/9/831

What this forgets to point out is that I had authored pinctrl and gpio
drivers for S500, with preparations for S700 and S900, derived from my
to-be-submitted pinctrl/gpio drivers for RTD1295, while this one was
developed independently by Mani for S900. Our intention is to align them
as part of patch review and redo S500 on top of the result.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Jane Smithard, Graham Norton
HRB 21284 (AG Nürnberg)
