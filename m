Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964914AbeBUQUV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:20:21 -0500
Received: from mail-lf0-f68.google.com ([209.85.215.68]:43152 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753851AbeBUQUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:20:19 -0500
X-Google-Smtp-Source: AH8x227ySo8T2zdczvsZ9pyXWJPD3NYodf2W0lhEfy3y6ZR4CJhTFydeoqlYXzbu7R+iocmWyNEMSA==
Subject: Re: [PATCH] ARM: dtc: tegra: enable front panel leds in TrimSlice
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, robh+dt@kernel.org, mark.rutland@arm.com,
        linux@armlinux.org.uk, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20180219201623.6987-1-tmn505@gmail.com>
 <57945bd2-d8c2-f7bc-f01f-29d679762446@wwwdotorg.org>
From: Tomasz Maciej Nowak <tmn505@gmail.com>
Message-ID: <873b01dc-3ca5-3151-2654-a8272cb9dd88@gmail.com>
Date: Wed, 21 Feb 2018 17:20:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <57945bd2-d8c2-f7bc-f01f-29d679762446@wwwdotorg.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: pl-PL
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 20.02.2018 o 20:55, Stephen Warren pisze:
> On 02/19/2018 01:16 PM, Tomasz Maciej Nowak wrote:
>> Adds device nodes for two front panel LEDs.
> 
> Why do you need to change the pinmux settings? Configuring a pin as a 
> GPIO should override any pinmux special function selection and hence 
> make it irrelevant, so I don't think you should need to change the pinmux.

At first I did exactly that without changing the pinmux, but the LEDs 
didn't light up. After that I compared with CompuLab source tree [1]. 
The pinmux was specified as in my patch. With this change the LEDs are 
fully functional.

1. 
https://gitorious.org/trimslice-kernel/trimslice-kernel?p=trimslice-kernel:trimslice-kernel.git;a=blob;f=arch/arm/mach-tegra/board-trimslice-pinmux.c;h=cc6d5225d97eb9327c820bf1d5b2bc16ab8c6dda;hb=d25bf45d6314089489b30d218ed8a0d6d94417f9#l45

-- 
Tomek
