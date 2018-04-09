Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752100AbeDILiG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 9 Apr 2018 07:38:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:49864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752057AbeDILiE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Apr 2018 07:38:04 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75DC120779
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Mon, 9 Apr 2018 19:37:45 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>
Cc: Mark Brown <broonie@kernel.org>, kernel@pengutronix.de,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Leonard Crestez <leonard.crestez@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@codeaurora.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Russell King <linux@armlinux.org.uk>
Subject: Re: [PATCH RESEND v6 0/6] provide power off support for iMX6 with
 external PMIC
Message-ID: <20180409113744.GA14582@dragon>
References: <20180305102524.5905-1-o.rempel@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305102524.5905-1-o.rempel@pengutronix.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 11:25:17AM +0100, Oleksij Rempel wrote:
> This patch series is providing power off support for Freescale/NXP iMX6 based
> boards with external power management integrated circuit (PMIC).
> As a first step the PMIC is configured to turn off the system if the
> standby pin is asserted. On second step we assert the standby pin.
> For this reason we need to use pm_power_off_prepare.
> 
> Usage of stnadby pin for power off is described in official iMX6
> documentation.
> 
> 2018.03.05:
> As this patch set touches multiple subsystems I think it would make
> sense for Shawn Guo to take the all patch set.
> The only part which didn't receive an ACK is regulator stuff. So I would
> hope that Mark Brown can ACK it.

Besides regulator changes, I did not see an ACK on kernel/reboot.c
either.

Shawn
