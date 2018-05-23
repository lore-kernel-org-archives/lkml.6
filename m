Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754791AbeEWQaI (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 12:30:08 -0400
Received: from foss.arm.com ([217.140.101.70]:58116 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754771AbeEWQaB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 12:30:01 -0400
Subject: Re: [PATCH 0/3] irqchip: meson-gpio: add support for Meson-AXG SoCs
To: Yixun Lan <yixun.lan@amlogic.com>, Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kevin Hilman <khilman@baylibre.com>
Cc: Carlo Caione <carlo@caione.org>, Jerome Brunet <jbrunet@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, Rob Herring <robh@kernel.org>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20180408145700.23520-1-yixun.lan@amlogic.com>
 <0c97c61b-c05b-21cf-c880-80cff04ed6f2@amlogic.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <09d70e1f-abba-79d0-4dc3-7130fd0d07a8@arm.com>
Date: Wed, 23 May 2018 17:29:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <0c97c61b-c05b-21cf-c880-80cff04ed6f2@amlogic.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/05/18 03:50, Yixun Lan wrote:
> Hi Marc (or anyone else)
> 
> On 04/08/18 22:56, Yixun Lan wrote:
>>   This series try to add GPIO interrupt controller support for Meson-AXG SoCs.
>>   The first patch is a trivial typo fix, I can fold the first two patches
>> together if necessary.
>>
>> Yixun Lan (3):
>>   dt-bindings: interrupt-controller: fix the double quotes
>>   dt-bindings: interrupt-controller: New binding for Meson-AXG SoC
>>   irqchip/meson-gpio: add support for Meson-AXG SoCs
>>
>>  .../bindings/interrupt-controller/amlogic,meson-gpio-intc.txt | 11 ++++++-----
>>  drivers/irqchip/irq-meson-gpio.c                              |  5 +++++
>>  2 files changed, 11 insertions(+), 5 deletions(-)
>>
> 
> please consider this merely a ping..
> will you take this series, or is there anything holding this?

Sure, I'll queue that for 4.18.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
