Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753027AbeBEPDb convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:03:31 -0500
Received: from smtprelay03.ispgateway.de ([80.67.31.30]:20163 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753168AbeBEPDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:03:23 -0500
Date: Mon, 5 Feb 2018 16:03:19 +0100
From: Lothar =?UTF-8?B?V2HDn21hbm4=?= <LW@KARO-electronics.de>
To: Shawn Guo <shawnguo@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        open list <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v2 BUGFIX] ARM: dts: imx6ull: fix the imx6ull-14x14-evk
 configuration
Message-ID: <20180205160319.297a74f8@karo-electronics.de>
In-Reply-To: <20180205103716.GY31354@dragon>
References: <1516955159-21626-1-git-send-email-LW@KARO-electronics.de>
        <1516956738-24673-1-git-send-email-LW@KARO-electronics.de>
        <20180205075620.GO31354@dragon>
        <20180205105543.1711274c@karo-electronics.de>
        <20180205103716.GY31354@dragon>
Organization: Ka-Ro electronics GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
X-Df-Sender: bHdAa2Fyby1lbGVjdHJvbmljcy5kZQ==
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 5 Feb 2018 18:37:20 +0800 Shawn Guo wrote:
> On Mon, Feb 05, 2018 at 10:55:43AM +0100, Lothar Waßmann wrote:
> > Hi,
> > 
> > On Mon, 5 Feb 2018 15:56:22 +0800 Shawn Guo wrote:
> > > On Fri, Jan 26, 2018 at 09:52:18AM +0100, Lothar Waßmann wrote:
> > > > imx6ull-14x14-evk.dts currently includes the imx6ul.dtsi file for an
> > > > i.MX6ULL SoC which is plain wrong.
> > > > 
> > > > Rename the current imx6ul-14x14-evk.dts to .dtsi and include it from
> > > > imx6ul-14x14-evk.dts and imx6ull-14x14-evk.dts, so that both can
> > > > include the appropriate SoC specific (imx6ul.dtsi/imx6ull.dtsi) file.
> > > > 
> > > > Signed-off-by: Lothar Waßmann <LW@KARO-electronics.de>
> > > 
> > > Which base is the patch generated against?  I cannot apply it to any
> > > branch in my tree.
> > >
> > The patch was generated against next-20180118 but also applies to
> > next-20180205.
> 
> It looks like you would really want this go into 4.16 as a fix?  In that
> case, I will need to wait for v4.16-rc1 to apply it.
> 
I don't care much when and how it will be applied.
I'm not using those files myself.


Lothar Waßmann
