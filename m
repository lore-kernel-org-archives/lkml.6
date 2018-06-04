Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751742AbeFDBdH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 21:33:07 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:41947 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751282AbeFDBdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 21:33:05 -0400
X-Google-Smtp-Source: ADUXVKKGS/7pde+OQdQJe/tgN1zA5bOtmZNO28HCOg3T79UNvTA5kAzTB9MvrWAQeyRkZuPzliMZjyWg3fEhhGZymnE=
MIME-Version: 1.0
In-Reply-To: <1528074406-11735-1-git-send-email-Anson.Huang@nxp.com>
References: <1528074406-11735-1-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 3 Jun 2018 22:33:04 -0300
Message-ID: <CAOMZO5B9fZVFmHSWPJLutQ=a71ehEUs=A3y9eeMoFzioeHGtxA@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] clk: imx6q: remove clks_init_on array
To: Anson Huang <Anson.Huang@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, NXP Linux Team <Linux-imx@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        linux-clk <linux-clk@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 3, 2018 at 10:06 PM, Anson Huang <Anson.Huang@nxp.com> wrote:
> Clock framework will enable those clocks registered
> with CLK_IS_CRITICAL flag, so no need to have
> clks_init_on array during clock initialization now.
>
> ARM clock is busy divider type which has the
> CLK_IS_CRITICAL flag set by default when registered.

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
