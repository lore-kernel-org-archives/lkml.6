Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753244AbeDPSc1 convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 14:32:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:43110 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753168AbeDPScZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 14:32:25 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4554521776
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Anson Huang <Anson.Huang@nxp.com>, fabio.estevam@nxp.com,
        kernel@pengutronix.de, linux@armlinux.org.uk, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org, shawnguo@kernel.org,
        shengjiu.wang@nxp.com
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1521426645-19246-1-git-send-email-Anson.Huang@nxp.com>
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <1521426645-19246-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <152390354456.51482.5320966315016822540@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V2 1/2] clk: imx6sx: add missing lvds2 clock to the clock tree
Date: Mon, 16 Apr 2018 11:32:24 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Anson Huang (2018-03-18 19:30:44)
> i.MX6SX has lvds2 (analog clock2), an I/O clock like lvds1.
> And this lvds2, along with lvds1, can be used to provide
> external clock source to the internal pll, such as pll4_audio
> and pll5_video.
> 
> This patch mainly adds the lvds2 to the clock tree and fix its
> relationship with pll accordingly.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---

Applied to clk-next
