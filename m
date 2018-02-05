Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752807AbeBEKDy convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 05:03:54 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.26]:25603 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752317AbeBEKDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 05:03:47 -0500
Date: Mon, 5 Feb 2018 10:55:43 +0100
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: Shawn Guo <shawnguo@kernel.org>
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
Message-ID: <20180205105543.1711274c@karo-electronics.de>
In-Reply-To: <20180205075620.GO31354@dragon>
References: <1516955159-21626-1-git-send-email-LW@KARO-electronics.de>
        <1516956738-24673-1-git-send-email-LW@KARO-electronics.de>
        <20180205075620.GO31354@dragon>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Df-Sender: bHdAa2Fyby1lbGVjdHJvbmljcy5kZQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 5 Feb 2018 15:56:22 +0800 Shawn Guo wrote:
> On Fri, Jan 26, 2018 at 09:52:18AM +0100, Lothar Waßmann wrote:
> > imx6ull-14x14-evk.dts currently includes the imx6ul.dtsi file for an
> > i.MX6ULL SoC which is plain wrong.
> > 
> > Rename the current imx6ul-14x14-evk.dts to .dtsi and include it from
> > imx6ul-14x14-evk.dts and imx6ull-14x14-evk.dts, so that both can
> > include the appropriate SoC specific (imx6ul.dtsi/imx6ull.dtsi) file.
> > 
> > Signed-off-by: Lothar Waßmann <LW@KARO-electronics.de>
> 
> Which base is the patch generated against?  I cannot apply it to any
> branch in my tree.
>
The patch was generated against next-20180118 but also applies to
next-20180205.


Lothar Waßmann
