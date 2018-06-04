Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751853AbeFDBdZ (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 21:33:25 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35805 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751796AbeFDBdX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 21:33:23 -0400
X-Google-Smtp-Source: ADUXVKJwEdztU9w0/iCYpSyCryt6nMgK0dZOGjqz22dLREpWxu8bYwxYIqGJpGJQVqX70tyRTcNnGsKNR9YuA3krmug=
MIME-Version: 1.0
In-Reply-To: <1528074406-11735-2-git-send-email-Anson.Huang@nxp.com>
References: <1528074406-11735-1-git-send-email-Anson.Huang@nxp.com> <1528074406-11735-2-git-send-email-Anson.Huang@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 3 Jun 2018 22:33:22 -0300
Message-ID: <CAOMZO5BU-4O0K0z-ZiL7N9bCceQVeytsGT=5RvD=jRWZ0QfWmA@mail.gmail.com>
Subject: Re: [PATCH V2 2/4] clk: imx6sl: remove clks_init_on array
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
>
> IPG clock has no clock gate and its parent AHB clock
> is busy divider type, so no need to add CLK_IS_CRITICAL
> flag for IPG clock.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
