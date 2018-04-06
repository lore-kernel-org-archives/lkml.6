Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751874AbeDFSUk convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 14:20:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:40700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751704AbeDFSUi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 14:20:38 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BDA9217DF
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
In-Reply-To: <1522219599-10831-5-git-send-email-abel.vesa@nxp.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com,
        Anson Huang <anson.huang@nxp.com>,
        Ranjani Vaidyanathan <Ranjani.Vaidyanathan@nxp.com>,
        Abel Vesa <abelvesa@linux.com>, Daniel Baluta <daniel.baluta@nxp.com>,
        Anson Huang <b20788@freescale.com>, Abel Vesa <abel.vesa@nxp.com>
References: <1522219599-10831-1-git-send-email-abel.vesa@nxp.com>
 <1522219599-10831-5-git-send-email-abel.vesa@nxp.com>
Message-ID: <152303883696.143116.13663538916966228102@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [RESEND 3/4] clk: imx7d: Correct ahb clk parent select
Date: Fri, 06 Apr 2018 11:20:36 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Abel Vesa (2018-03-27 23:46:38)
> From: Anson Huang <b20788@freescale.com>
> 
> Design team change the ahb's clk parent options but
> did NOT update the DOC accordingly in time, so the
> AHB/IPG's clk rate in clk tree is incorrect, AHB is
> 67.5MHz and IPG is 33.75MHz, but using scope to
> monitor them, they are actually 135MHz and 67.5MHz,
> update the clk parent option to make clk tree info
> correct.
> 
> Signed-off-by: Anson Huang <b20788@freescale.com>
> Signed-off-by: Irina Tirdea <irina.tirdea@nxp.com>
> Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
> ---

Applied to clk-next
