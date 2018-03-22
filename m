Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755818AbeCVOPC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 10:15:02 -0400
Received: from mail-ot0-f173.google.com ([74.125.82.173]:33448 "EHLO
        mail-ot0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752199AbeCVOO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 10:14:58 -0400
X-Google-Smtp-Source: AG47ELudmGVl1sAjOPLzXdT/OgQ4xwpryNdqQFOasygrzBTPmGAuII5oBrFQdy35hmFDqCtqhh5pLbOIztmubNjPsoY=
MIME-Version: 1.0
In-Reply-To: <1521712529-632-2-git-send-email-abel.vesa@nxp.com>
References: <1521712529-632-1-git-send-email-abel.vesa@nxp.com> <1521712529-632-2-git-send-email-abel.vesa@nxp.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Thu, 22 Mar 2018 11:14:57 -0300
Message-ID: <CAOMZO5CkwK1yoJKEx4UOB1sp0y95SZrkRmyojXWxROLKJAdWow@mail.gmail.com>
Subject: Re: [PATCH 1/4] arm: imx: Update clk driver API
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

On Thu, Mar 22, 2018 at 6:55 AM, Abel Vesa <abel.vesa@nxp.com> wrote:
> This adds the following new wrappers:
>  - imx_clk_gate2_flag
>  - imx_clk_set_parent

Please explain the motivation for adding these two new functions in
the commit log.

>
> It also updates the flags for the old wrappers.
>
> Signed-off-by: Anson Huang <anson.huang@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>

Is this patch from you or from Anson?

If it is from Anson then his name should appear at the From: line.
