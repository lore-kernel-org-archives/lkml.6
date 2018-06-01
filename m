Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753478AbeFATSE (ORCPT <rfc822;w@1wt.eu>);
        Fri, 1 Jun 2018 15:18:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:43070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751801AbeFATSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jun 2018 15:18:01 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Anson Huang <Anson.Huang@nxp.com>, adriana.reus@nxp.com,
        fabio.estevam@nxp.com, kernel@pengutronix.de, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org, rui.silva@linaro.org,
        shawnguo@kernel.org, stefan@agner.ch
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1526605266-18464-1-git-send-email-Anson.Huang@nxp.com>
Cc: Linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
References: <1526605266-18464-1-git-send-email-Anson.Huang@nxp.com>
Message-ID: <152788068032.225090.8543051846810232845@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V2 1/3] clk: imx7d: correct enet phy ref clock gates
Date: Fri, 01 Jun 2018 12:18:00 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w51JIu2p027150

Quoting Anson Huang (2018-05-17 18:01:04)
> IMX7D_ENET_PHY_REF_ROOT_DIV supplies clock for PHY directly,
> there is no clock gate after it, rename it to
> IMX7D_ENET_PHY_REF_ROOT_CLK to avoid device tree change.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---

Applied to clk-next
