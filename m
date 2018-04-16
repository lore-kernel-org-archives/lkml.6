Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752654AbeDPHZC (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 03:25:02 -0400
Received: from mail.kernel.org ([198.145.29.99]:55608 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750707AbeDPHZB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 03:25:01 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 280C12177F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Mon, 16 Apr 2018 15:24:26 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Fabio maggi <fabio.mauri@bticino.it>, lamiaposta71@gmail.com,
        Andrea CORTESE <andrea.cortese@bticino.it>,
        "davide . bonfanti" <davide.bonfanti@bticino.it>,
        Shyam Saini <shyam.saini@amarulasolutions.com>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Simone CIANNI <simone.cianni@bticino.it>,
        Raffaele RECALCATI <raffaele.recalcati@bticino.it>
Subject: Re: [PATCH v2 2/2] ARM: dts: i.MX6: Add BTicino i.MX6DL Mamoj
 initial support
Message-ID: <20180416072425.GC25429@dragon>
References: <20180319194114.15349-1-jagan@amarulasolutions.com>
 <20180319194114.15349-2-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319194114.15349-2-jagan@amarulasolutions.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 20, 2018 at 01:11:14AM +0530, Jagan Teki wrote:
> +&i2c4 {
> +	clock-frequency = <100000>;
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pinctrl_i2c4>;
> +	status = "okay";
> +
> +	pmic: pfuze100@8 {

pfuze100: pmic@8

I fixed it up and applied both patches.

Shawn

> +		compatible = "fsl,pfuze100";
> +		reg = <0x08>;
