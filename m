Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752274AbeESKpj (ORCPT <rfc822;w@1wt.eu>);
        Sat, 19 May 2018 06:45:39 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:55442 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752218AbeESKpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 May 2018 06:45:38 -0400
Date: Sat, 19 May 2018 12:45:33 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
cc: Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Subject: Re: [PATCH] irqchip: dw-apb-ictl: switch to SPDX license
 identifier
In-Reply-To: <20180516154022.074c5414@xhacker.debian>
Message-ID: <alpine.DEB.2.21.1805191243050.1599@nanos.tec.linutronix.de>
References: <20180516154022.074c5414@xhacker.debian>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 16 May 2018, Jisheng Zhang wrote:

> Use the appropriate SPDX license identifier and drop the previous
> license text.

CC+: Sebastian.

> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
> ---
>  drivers/irqchip/irq-dw-apb-ictl.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/drivers/irqchip/irq-dw-apb-ictl.c b/drivers/irqchip/irq-dw-apb-ictl.c
> index 0a19618ce2c8..fdc5c7d19651 100644
> --- a/drivers/irqchip/irq-dw-apb-ictl.c
> +++ b/drivers/irqchip/irq-dw-apb-ictl.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0
>  /*
>   * Synopsys DW APB ICTL irqchip driver.
>   *
> @@ -5,10 +6,6 @@
>   *
>   * based on GPL'ed 2.6 kernel sources
>   *  (c) Marvell International Ltd.
> - *
> - * This file is licensed under the terms of the GNU General Public
> - * License version 2.  This program is licensed "as is" without any
> - * warranty of any kind, whether express or implied.
>   */
>  
>  #include <linux/io.h>
> -- 
> 2.17.0
> 
> 
