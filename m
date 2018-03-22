Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754624AbeCVPfl (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 11:35:41 -0400
Received: from foss.arm.com ([217.140.101.70]:39264 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753438AbeCVPfi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 11:35:38 -0400
Subject: Re: [PATCH v3 2/2] irqchip: Add a driver for the Microsemi Ocelot
 controller
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Jason Cooper <jason@lakedaemon.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        linux-kernel@vger.kernel.org
References: <20180322151524.13902-1-alexandre.belloni@bootlin.com>
 <20180322151524.13902-2-alexandre.belloni@bootlin.com>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <e7492bde-4a5f-8ae3-a5f3-5fc1168e2d87@arm.com>
Date: Thu, 22 Mar 2018 15:35:35 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180322151524.13902-2-alexandre.belloni@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/03/18 15:15, Alexandre Belloni wrote:
> The Microsemi Ocelot SoC has a pretty simple IRQ controller in its ICPU
> block. Add a driver for it.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> ---
> Changes in v3:
>  - moved parent irq parsing to the top of init
>  - reworked error path
> 
> 
>  drivers/irqchip/Kconfig           |   5 ++
>  drivers/irqchip/Makefile          |   1 +
>  drivers/irqchip/irq-mscc-ocelot.c | 118 ++++++++++++++++++++++++++++++++++++++
>  3 files changed, 124 insertions(+)
>  create mode 100644 drivers/irqchip/irq-mscc-ocelot.c
Queued both patches for 4.17. Thanks for the quick turnaround.

	M.
-- 
Jazz is not dead. It just smells funny...
