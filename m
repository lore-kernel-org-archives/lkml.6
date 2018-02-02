Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751795AbeBBDp2 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 22:45:28 -0500
Received: from mail.kernel.org ([198.145.29.99]:37568 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751675AbeBBDpM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 22:45:12 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC60220852
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Fri, 2 Feb 2018 11:44:59 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Anson Huang <Anson.Huang@nxp.com>
Cc: horia.geanta@nxp.com, aymen.sghaier@nxp.com,
        herbert@gondor.apana.org.au, davem@davemloft.net, robh+dt@kernel.org,
        mark.rutland@arm.com, kernel@pengutronix.de, fabio.estevam@nxp.com,
        linux@armlinux.org.uk, mturquette@baylibre.com, sboyd@codeaurora.org,
        adriana.reus@nxp.com, stefan@agner.ch, dongas86@gmail.com,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 2/2] ARM: dts: imx7s: add snvs rtc clock
Message-ID: <20180202034457.GF20833@dragon>
References: <1515491526-14060-1-git-send-email-Anson.Huang@nxp.com>
 <1515491526-14060-2-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1515491526-14060-2-git-send-email-Anson.Huang@nxp.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 09, 2018 at 05:52:06PM +0800, Anson Huang wrote:
> Add i.MX7 SNVS RTC clock.
> 
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Looks fine to me.  Ping me when clk driver part lands mainline.

Shawn
