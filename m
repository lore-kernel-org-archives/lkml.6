Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754159AbeEaIg3 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 04:36:29 -0400
Received: from relay1.mentorg.com ([192.94.38.131]:52719 "EHLO
        relay1.mentorg.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754027AbeEaIg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 04:36:26 -0400
Subject: Re: [PATCH v4 4/5] clocksource: add driver for i.MX EPIT timer
To: =?UTF-8?B?Q2zDqW1lbnQgUMOpcm9u?= <peron.clem@gmail.com>,
        Colin Didier <colin.didier@devialet.com>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
References: <20180530120327.27681-1-peron.clem@gmail.com>
 <20180530120327.27681-5-peron.clem@gmail.com>
CC: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>, Rob Herring <robh@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        =?UTF-8?Q?Cl=c3=a9ment_Peron?= <clement.peron@devialet.com>
From: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
Message-ID: <677be207-67be-ccbc-8bb3-ab90bf9d05a7@mentor.com>
Date: Thu, 31 May 2018 11:36:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:45.0) Gecko/20100101
 Icedove/45.2.0
MIME-Version: 1.0
In-Reply-To: <20180530120327.27681-5-peron.clem@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [137.202.0.87]
X-ClientProxiedBy: svr-ies-mbx-02.mgc.mentorg.com (139.181.222.2) To
 SVR-IES-MBX-04.mgc.mentorg.com (139.181.222.4)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Clément,

On 05/30/2018 03:03 PM, Clément Péron wrote:
> From: Colin Didier <colin.didier@devialet.com>
> 
> Add driver for NXP's EPIT timer used in i.MX 6 family of SoC.
> 
> Signed-off-by: Colin Didier <colin.didier@devialet.com>
> Signed-off-by: Clément Peron <clement.peron@devialet.com>
> ---

[snip]

> +++ b/drivers/clocksource/timer-imx-epit.c
> @@ -0,0 +1,281 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * i.MX EPIT Timer
> + *
> + * Copyright (C) 2010 Sascha Hauer <s.hauer@pengutronix.de>
> + * Copyright (C) 2018 Colin Didier <colin.didier@devialet.com>
> + * Copyright (C) 2018 Clément Péron <clement.peron@devialet.com>
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/clockchips.h>
> +#include <linux/err.h>

The included header above still can be removed.

I have no more comments about the code, I will try to find time to
test the driver, but please don't take it as a promise.

--
With best wishes,
Vladimir
