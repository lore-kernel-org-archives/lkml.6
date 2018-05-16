Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752524AbeEPCu1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 22:50:27 -0400
Received: from mail-sh2.amlogic.com ([58.32.228.45]:8660 "EHLO
        mail-sh2.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbeEPCuZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 22:50:25 -0400
Subject: Re: [PATCH 0/3] irqchip: meson-gpio: add support for Meson-AXG SoCs
To: Marc Zyngier <marc.zyngier@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kevin Hilman <khilman@baylibre.com>
References: <20180408145700.23520-1-yixun.lan@amlogic.com>
CC: <yixun.lan@amlogic.com>, Carlo Caione <carlo@caione.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Heiner Kallweit <hkallweit1@gmail.com>, Rob Herring <robh@kernel.org>,
        Xingyu Chen <xingyu.chen@amlogic.com>,
        <linux-amlogic@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
From: Yixun Lan <yixun.lan@amlogic.com>
Message-ID: <0c97c61b-c05b-21cf-c880-80cff04ed6f2@amlogic.com>
Date: Wed, 16 May 2018 10:50:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20180408145700.23520-1-yixun.lan@amlogic.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.18.20.235]
X-ClientProxiedBy: mail-sh2.amlogic.com (10.18.11.6) To mail-sh2.amlogic.com
 (10.18.11.6)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc (or anyone else)

On 04/08/18 22:56, Yixun Lan wrote:
>   This series try to add GPIO interrupt controller support for Meson-AXG SoCs.
>   The first patch is a trivial typo fix, I can fold the first two patches
> together if necessary.
> 
> Yixun Lan (3):
>   dt-bindings: interrupt-controller: fix the double quotes
>   dt-bindings: interrupt-controller: New binding for Meson-AXG SoC
>   irqchip/meson-gpio: add support for Meson-AXG SoCs
> 
>  .../bindings/interrupt-controller/amlogic,meson-gpio-intc.txt | 11 ++++++-----
>  drivers/irqchip/irq-meson-gpio.c                              |  5 +++++
>  2 files changed, 11 insertions(+), 5 deletions(-)
> 

please consider this merely a ping..
will you take this series, or is there anything holding this?

thanks

Yixun
