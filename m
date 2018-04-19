Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752935AbeDSODX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 19 Apr 2018 10:03:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:42768 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752085AbeDSODU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Apr 2018 10:03:20 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D6692170D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=shawnguo@kernel.org
Date: Thu, 19 Apr 2018 22:02:37 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Anson Huang <Anson.Huang@nxp.com>, mark.rutland@arm.com,
        devicetree@vger.kernel.org, mturquette@baylibre.com,
        linux-clk@vger.kernel.org, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org, Linux-imx@nxp.com,
        kernel@pengutronix.de, fabio.estevam@nxp.com, shengjiu.wang@nxp.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 2/2] ARM: dts: imx6sx-sabreauto: add external 24MHz
 clock source
Message-ID: <20180419140236.GU25429@dragon>
References: <1521426645-19246-1-git-send-email-Anson.Huang@nxp.com>
 <1521426645-19246-2-git-send-email-Anson.Huang@nxp.com>
 <20180417142203.GM25429@dragon>
 <152410785516.46528.12432838242068784117@swboyd.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <152410785516.46528.12432838242068784117@swboyd.mtv.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 08:17:35PM -0700, Stephen Boyd wrote:
> Quoting Shawn Guo (2018-04-17 07:22:05)
> > On Mon, Mar 19, 2018 at 10:30:45AM +0800, Anson Huang wrote:
> > > On i.MX6SX SabreAuto board, there is external 24MHz clock
> > > source for analog clock2, add this clock source to clock tree.
> > > 
> > > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > > ---
> > > changes since V1:
> > >       remove unnecessary clocks container.
> > 
> > I understand this is suggested by Fabio, but I'm afraid that it's not
> > going to work with imx_obtain_fixed_clock() call, which is coded to
> > look for clocks under /clocks node.
> > 
> 
> Should patch #1 be dropped from clk tree?

No.  Patch #1 is good.

Shawn
