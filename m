Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754694AbeCVMbI (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 08:31:08 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:41511 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754659AbeCVMbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 08:31:04 -0400
X-Google-Smtp-Source: AIpwx49Hc4Ki7pJfu+dzxRTDClxMGJrQhcMYzckuEfRls00ADYlBW+BUp2XFWhjCoQ1BNtVJukIyWPHioXtqoy6XP7Y=
MIME-Version: 1.0
In-Reply-To: <1521712529-632-3-git-send-email-abel.vesa@nxp.com>
References: <1521712529-632-1-git-send-email-abel.vesa@nxp.com> <1521712529-632-3-git-send-email-abel.vesa@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 22 Mar 2018 09:31:03 -0300
Message-ID: <CAOMZO5BVxp7pq44pUp444CqsYcJ5QQFqrgdRyFbaxRi0_d0ssg@mail.gmail.com>
Subject: Re: [PATCH 2/4] arm: imx: Correct dram pll type
To: Abel Vesa <abel.vesa@nxp.com>
Cc: Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Yongcai Huang <anson.huang@nxp.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-clk <linux-clk@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Abel,

On Thu, Mar 22, 2018 at 6:55 AM, Abel Vesa <abel.vesa@nxp.com> wrote:
> From: Anson Huang <anson.huang@nxp.com>
>
> DRAM PLL is a audio/video type PLL, need to correct it to get correct ops of
> PLL.
>
> There is a test_div placed before DRAM PLL's gate, so add this test div clk.
>
> Signed-off-by: Anson Huang <anson.huang@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

This has already been applied in linux-next as commit:

commit b716aad97eb5 ("clk: imx: imx7d: correct video pll clock tree)

Nit: the prefix in the Subject lines of all these patches should not
be "arm:imx".

"clk: imx: imx7d" is better suited to reflect the subsystem that thes
patches touch.
