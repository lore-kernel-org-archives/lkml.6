Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeDFSWZ convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 14:22:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:40968 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751276AbeDFSWY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 14:22:24 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA9C620B80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Abel Vesa <abel.vesa@nxp.com>, Fabio Estevam <fabio.estevam@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Shawn Guo <shawnguo@kernel.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1521812006-6173-1-git-send-email-abel.vesa@nxp.com>
Cc: Abel Vesa <abel.vesa@nxp.com>, linux-kernel@vger.kernel.org,
        Abel Vesa <abelvesa@linux.com>, linux-imx@nxp.com,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <1521812006-6173-1-git-send-email-abel.vesa@nxp.com>
Message-ID: <152303894318.143116.719157250286888372@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: imx: Set CLK_SET_RATE_GATE for gate and divider clocks
Date: Fri, 06 Apr 2018 11:22:23 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2018-03-23 06:33:26)
> Add flag CLK_SET_RATE_GATE for i.MX gate and divider clocks on which the
> client drivers usually make clk_set_rate() call, so that the call will fail
> when clock is still on instead of standing the risk of running into glitch
> issue. Rate cannot be changed when the clock is enabled due to the glitchy
> multiplexers.
> 
> Signed-off-by: Shawn Guo <shawnguo@kernel.org>
> [initial patch from imx internal repo]
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> [carried over from 3.14 and also applied the flag to newer functions]

Is Shawn the author of this patch?
