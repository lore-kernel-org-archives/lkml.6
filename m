Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752361AbeBVFT4 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 00:19:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:35058 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750821AbeBVFTy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 00:19:54 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 551A921747
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Thu, 22 Feb 2018 13:19:41 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Anson Huang <Anson.Huang@nxp.com>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
        aymen.sghaier@nxp.com, herbert@gondor.apana.org.au,
        horia.geanta@nxp.com, linux-kernel@vger.kernel.org,
        mturquette@baylibre.com, sboyd@codeaurora.org, linux@armlinux.org.uk,
        stefan@agner.ch, linux-clk@vger.kernel.org, adriana.reus@nxp.com,
        robh+dt@kernel.org, linux-crypto@vger.kernel.org,
        kernel@pengutronix.de, fabio.estevam@nxp.com, davem@davemloft.net,
        linux-arm-kernel@lists.infradead.org, dongas86@gmail.com
Subject: Re: [PATCH V4 2/2] ARM: dts: imx7s: add snvs rtc clock
Message-ID: <20180222051939.GH3217@dragon>
References: <1515491526-14060-1-git-send-email-Anson.Huang@nxp.com>
 <1515491526-14060-2-git-send-email-Anson.Huang@nxp.com>
 <20180202034457.GF20833@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180202034457.GF20833@dragon>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 02, 2018 at 11:44:59AM +0800, Shawn Guo wrote:
> On Tue, Jan 09, 2018 at 05:52:06PM +0800, Anson Huang wrote:
> > Add i.MX7 SNVS RTC clock.
> > 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> 
> Looks fine to me.  Ping me when clk driver part lands mainline.

I'm collecting i.MX clock patches and later will send them to clk
maintainers in form of pull request.  So applied both.

Shawn
