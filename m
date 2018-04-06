Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751772AbeDFSUf convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 14:20:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:40636 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751679AbeDFSUd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 14:20:33 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6744B217CE
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
In-Reply-To: <1522219599-10831-4-git-send-email-abel.vesa@nxp.com>
Cc: Abel Vesa <abelvesa@linux.com>, Abel Vesa <abel.vesa@nxp.com>,
        Anson Huang <anson.huang@nxp.com>, linux-kernel@vger.kernel.org,
        Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>, linux-imx@nxp.com,
        Anson Huang <b20788@freescale.com>,
        Daniel Baluta <daniel.baluta@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <1522219599-10831-1-git-send-email-abel.vesa@nxp.com>
 <1522219599-10831-4-git-send-email-abel.vesa@nxp.com>
Message-ID: <152303883286.143116.8912343462602782485@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RESEND 2/4] clk: imx7d: Correct dram pll type
Date: Fri, 06 Apr 2018 11:20:32 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2018-03-27 23:46:37)
> From: Anson Huang <b20788@freescale.com>
> 
> DRAM PLL is a audio/video type PLL, need to correct
> it to get correct ops of PLL.
> 
> There is a test_div placed before DRAM PLL's gate, so
> add this test div clk.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
> Signed-off-by: Irina Tirdea <irina.tirdea@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---

Applied to clk-next
