Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeDFSUo convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 14:20:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751897AbeDFSUl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 14:20:41 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA92F21834
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Abel Vesa <abel.vesa@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>,
        Irina Tirdea <irina.tirdea@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter Chen <peter.chen@freescale.com>,
        Sascha Hauer <kernel@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1522219599-10831-6-git-send-email-abel.vesa@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Anson Huang <anson.huang@nxp.com>,
        Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>,
        Abel Vesa <abelvesa@linux.com>, Daniel Baluta <daniel.baluta@nxp.com>,
        Dong Aisheng <b29396@freescale.com>, Abel Vesa <abel.vesa@nxp.com>
References: <1522219599-10831-1-git-send-email-abel.vesa@nxp.com>
 <1522219599-10831-6-git-send-email-abel.vesa@nxp.com>
Message-ID: <152303884033.143116.14807011107162910724@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RESEND 4/4] clk: imx7d: Move clks_init_on before any clock operations
Date: Fri, 06 Apr 2018 11:20:40 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2018-03-27 23:46:39)
> From: Dong Aisheng <b29396@freescale.com>
> 
> For init on clocks we should move it at the first place in imx7d_clocks_init()
> before any clock operations, else the clock operation may fail in case the clock
> is still not on.
> 
> Acked-by: Ranjani Vaidyanathan <Ranjani.Vaidyanathan@freescale.com>
> Signed-off-by: Dong Aisheng <b29396@freescale.com>
> Signed-off-by: Irina Tirdea <irina.tirdea@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---

Applied to clk-next
