Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935584AbeE2QCq convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 12:02:46 -0400
Received: from mail.bootlin.com ([62.4.15.54]:39403 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934933AbeE2QCk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 12:02:40 -0400
Date: Tue, 29 May 2018 18:02:38 +0200
From: Maxime Ripard <maxime.ripard@bootlin.com>
To: Jagan Teki <jagan@amarulasolutions.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
        Michael Trimarchi <michael@amarulasolutions.com>,
        Icenowy Zheng <icenowy@aosc.io>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@googlegroups.com
Subject: Re: [PATCH v4] arm64: allwinner: a64: Add Amarula A64-Relic initial
 support
Message-ID: <20180529160238.cdyzgl3t6jzovn23@flea.home>
References: <20180524111631.11864-1-jagan@amarulasolutions.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20180524111631.11864-1-jagan@amarulasolutions.com>
User-Agent: NeoMutt/20180323
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 24, 2018 at 04:46:31PM +0530, Jagan Teki wrote:
> Amarula A64-Relic is Allwinner A64 based IoT device, which support
> - Allwinner A64 Cortex-A53
> - Mali-400MP2 GPU
> - AXP803 PMIC
> - 1GB DDR3 RAM
> - 8GB eMMC
> - AP6330 Wifi/BLE
> - MIPI-DSI
> - CSI: OV5640 sensor
> - USB OTG
> - 12V DC power supply
> 
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>

Applied, thanks

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
