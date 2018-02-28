Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751827AbeB1BmQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 20:42:16 -0500
Received: from mail.kernel.org ([198.145.29.99]:49518 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751654AbeB1BmO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 20:42:14 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A8EF2168D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Wed, 28 Feb 2018 09:41:49 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Rui Miguel Silva <rui.silva@linaro.org>
Cc: horia.geanta@nxp.com, aymen.sghaier@nxp.com,
        Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ryan Harkin <ryan.harkin@linaro.org>,
        "Bryan O'Donoghue" <pure.logic@nexus-software.ie>,
        Sascha Hauer <kernel@pengutronix.de>, devicetree@vger.kernel.org,
        Fabio Estevam <fabio.estevam@nxp.com>, Peng Fan <peng.fan@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Lukas Auer <lukas.auer@aisec.fraunhofer.de>
Subject: Re: [PATCH v4 4/4] ARM: dts: imx7s: add CAAM device node
Message-ID: <20180228014148.GA3217@dragon>
References: <20180222142250.31348-1-rui.silva@linaro.org>
 <20180222142250.31348-5-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180222142250.31348-5-rui.silva@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 02:22:50PM +0000, Rui Miguel Silva wrote:
> Add CAAM device node to the i.MX7s device tree.
> 
> Cc: Shawn Guo <shawnguo@kernel.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>
> Cc: devicetree@vger.kernel.org
> Cc: "Horia Geantă" <horia.geanta@nxp.com>
> Cc: Aymen Sghaier <aymen.sghaier@nxp.com>
> Cc: Fabio Estevam <fabio.estevam@nxp.com>
> Cc: Peng Fan <peng.fan@nxp.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Lukas Auer <lukas.auer@aisec.fraunhofer.de>
> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>

Applied this one and "clk: imx7d: add CAAM clock", thanks.
