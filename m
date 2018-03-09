Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751451AbeCIX5R (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 18:57:17 -0500
Received: from mail-ot0-f194.google.com ([74.125.82.194]:39955 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751211AbeCIX5P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 18:57:15 -0500
X-Google-Smtp-Source: AG47ELs552oRptLq2IcZRBqqTVyRsz30DWX3mkpPoKIOwi3/8+kO3Nan9QkB8u3O/9S7bekF46dF/g==
Date: Fri, 9 Mar 2018 17:57:12 -0600
From: Rob Herring <robh@kernel.org>
To: gabriel.fernandez@st.com
Cc: sboyd@kernel.org, Mark Rutland <mark.rutland@arm.com>,
        Lee Jones <lee.jones@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, gabriel.fernandez.st@gmail.com,
        olivier.bideau@st.com, Loic PALLARDY <loic.pallardy@st.com>,
        benjamin GAIGNARD <benjamin.gaignard@st.com>
Subject: Re: [PATCH v2 02/12] clk: stm32mp1: Introduce STM32MP1 clock driver
Message-ID: <20180309235543.cjyywayv3m6fwtbc@rob-hp-laptop>
References: <1520528045-18330-1-git-send-email-gabriel.fernandez@st.com>
 <1520528045-18330-3-git-send-email-gabriel.fernandez@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520528045-18330-3-git-send-email-gabriel.fernandez@st.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 08, 2018 at 05:53:55PM +0100, gabriel.fernandez@st.com wrote:
> From: Gabriel Fernandez <gabriel.fernandez@st.com>
> 
> This patch introduces the mechanism to probe stm32mp1 driver.
> It also defines registers definition.
> This patch also introduces the generic mechanism to register
> a clock (a simple gate, divider and fixed factor).
> 
> All clocks will be defined in one table.
> 
> Signed-off-by: Gabriel Fernandez <gabriel.fernandez@st.com>
> ---
>  drivers/clk/Kconfig                       |   6 +
>  drivers/clk/Makefile                      |   1 +
>  drivers/clk/clk-stm32mp1.c                | 364 ++++++++++++++++++++++++++++++
>  include/dt-bindings/clock/stm32mp1-clks.h | 254 +++++++++++++++++++++

This should really be part of the binding patch.

>  4 files changed, 625 insertions(+)
>  create mode 100644 drivers/clk/clk-stm32mp1.c
>  create mode 100644 include/dt-bindings/clock/stm32mp1-clks.h
