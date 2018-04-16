Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753664AbeDPJ7S (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:59:18 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:45550 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753270AbeDPJ7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:59:15 -0400
X-Google-Smtp-Source: AIpwx4/Jnl5cbRPDmhrXQ/XrjaKzqqg6zmdkNEOXdPuUqXPbI1fs/+sWEqG8ydeeH6x6JYZwQYyzqg==
Message-ID: <1523872752.2601.26.camel@baylibre.com>
Subject: Re: [PATCH v5 4/7] dt-bindings: clock: reset: Add AXG AO Clock and
 Reset Bindings
From: Jerome Brunet <jbrunet@baylibre.com>
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Yixun Lan <yixun.lan@amlogic.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>, Carlo Caione <carlo@caione.org>,
        Rob Herring <robh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Qiufang Dai <qiufang.dai@amlogic.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date: Mon, 16 Apr 2018 11:59:12 +0200
In-Reply-To: <20180409143749.71197-5-yixun.lan@amlogic.com>
References: <20180409143749.71197-1-yixun.lan@amlogic.com>
         <20180409143749.71197-5-yixun.lan@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-04-09 at 22:37 +0800, Yixun Lan wrote:
> Add dt-bindings headers for the Meson-AXG's AO clock and
> reset controller.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Yixun Lan <yixun.lan@amlogic.com>
> ---
>  include/dt-bindings/clock/axg-aoclkc.h | 26 ++++++++++++++++++++++++++
>  include/dt-bindings/reset/axg-aoclkc.h | 20 ++++++++++++++++++++
>  2 files changed, 46 insertions(+)
>  create mode 100644 include/dt-bindings/clock/axg-aoclkc.h
>  create mode 100644 include/dt-bindings/reset/axg-aoclkc.h

Hi Philipp,

Is OK if we take this through clock tree ?
The related reset controller is actually part of a clock controller driver.

Best Regards
Jerome

> 
> diff --git a/include/dt-bindings/clock/axg-aoclkc.h b/include/dt-bindings/clock/axg-aoclkc.h
> new file mode 100644
> index 000000000000..61955016a55b
> --- /dev/null
> +++ b/include/dt-bindings/clock/axg-aoclkc.h
> @@ -0,0 +1,26 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
> +/*
> + * Copyright (c) 2016 BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + *
> + * Copyright (c) 2018 Amlogic, inc.
> + * Author: Qiufang Dai <qiufang.dai@amlogic.com>
> + */
> +
> +#ifndef DT_BINDINGS_CLOCK_AMLOGIC_MESON_AXG_AOCLK
> +#define DT_BINDINGS_CLOCK_AMLOGIC_MESON_AXG_AOCLK
> +
> +#define CLKID_AO_REMOTE		0
> +#define CLKID_AO_I2C_MASTER	1
> +#define CLKID_AO_I2C_SLAVE	2
> +#define CLKID_AO_UART1		3
> +#define CLKID_AO_UART2		4
> +#define CLKID_AO_IR_BLASTER	5
> +#define CLKID_AO_SAR_ADC	6
> +#define CLKID_AO_CLK81		7
> +#define CLKID_AO_SAR_ADC_SEL	8
> +#define CLKID_AO_SAR_ADC_DIV	9
> +#define CLKID_AO_SAR_ADC_CLK	10
> +#define CLKID_AO_ALT_XTAL	11
> +
> +#endif
> diff --git a/include/dt-bindings/reset/axg-aoclkc.h b/include/dt-bindings/reset/axg-aoclkc.h
> new file mode 100644
> index 000000000000..d342c0b6b2a7
> --- /dev/null
> +++ b/include/dt-bindings/reset/axg-aoclkc.h
> @@ -0,0 +1,20 @@
> +/* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
> +/*
> + * Copyright (c) 2016 BayLibre, SAS
> + * Author: Neil Armstrong <narmstrong@baylibre.com>
> + *
> + * Copyright (c) 2018 Amlogic, inc.
> + * Author: Qiufang Dai <qiufang.dai@amlogic.com>
> + */
> +
> +#ifndef DT_BINDINGS_RESET_AMLOGIC_MESON_AXG_AOCLK
> +#define DT_BINDINGS_RESET_AMLOGIC_MESON_AXG_AOCLK
> +
> +#define RESET_AO_REMOTE		0
> +#define RESET_AO_I2C_MASTER	1
> +#define RESET_AO_I2C_SLAVE	2
> +#define RESET_AO_UART1		3
> +#define RESET_AO_UART2		4
> +#define RESET_AO_IR_BLASTER	5
> +
> +#endif
