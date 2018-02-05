Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752183AbeBEH4w (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 02:56:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:41038 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750949AbeBEH4l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 02:56:41 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8840621795
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Mon, 5 Feb 2018 15:56:22 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Lothar =?iso-8859-1?Q?Wa=DFmann?= <LW@KARO-electronics.de>
Cc: Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 BUGFIX] ARM: dts: imx6ull: fix the imx6ull-14x14-evk
 configuration
Message-ID: <20180205075620.GO31354@dragon>
References: <1516955159-21626-1-git-send-email-LW@KARO-electronics.de>
 <1516956738-24673-1-git-send-email-LW@KARO-electronics.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1516956738-24673-1-git-send-email-LW@KARO-electronics.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 26, 2018 at 09:52:18AM +0100, Lothar Waﬂmann wrote:
> imx6ull-14x14-evk.dts currently includes the imx6ul.dtsi file for an
> i.MX6ULL SoC which is plain wrong.
> 
> Rename the current imx6ul-14x14-evk.dts to .dtsi and include it from
> imx6ul-14x14-evk.dts and imx6ull-14x14-evk.dts, so that both can
> include the appropriate SoC specific (imx6ul.dtsi/imx6ull.dtsi) file.
> 
> Signed-off-by: Lothar Waﬂmann <LW@KARO-electronics.de>

Which base is the patch generated against?  I cannot apply it to any
branch in my tree.

Shawn
