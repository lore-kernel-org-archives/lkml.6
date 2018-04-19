Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753178AbeDSDRh convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 23:17:37 -0400
Received: from mail.kernel.org ([198.145.29.99]:43954 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752241AbeDSDRg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 23:17:36 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D486A21726
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=sboyd@kernel.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
To: Anson Huang <Anson.Huang@nxp.com>, Shawn Guo <shawnguo@kernel.org>
From: Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180417142203.GM25429@dragon>
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
        mturquette@baylibre.com, linux-clk@vger.kernel.org,
        linux@armlinux.org.uk, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, Linux-imx@nxp.com, kernel@pengutronix.de,
        fabio.estevam@nxp.com, shengjiu.wang@nxp.com,
        linux-arm-kernel@lists.infradead.org
References: <1521426645-19246-1-git-send-email-Anson.Huang@nxp.com>
 <1521426645-19246-2-git-send-email-Anson.Huang@nxp.com>
 <20180417142203.GM25429@dragon>
Message-ID: <152410785516.46528.12432838242068784117@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH V2 2/2] ARM: dts: imx6sx-sabreauto: add external 24MHz clock
 source
Date: Wed, 18 Apr 2018 20:17:35 -0700
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Shawn Guo (2018-04-17 07:22:05)
> On Mon, Mar 19, 2018 at 10:30:45AM +0800, Anson Huang wrote:
> > On i.MX6SX SabreAuto board, there is external 24MHz clock
> > source for analog clock2, add this clock source to clock tree.
> > 
> > Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> > ---
> > changes since V1:
> >       remove unnecessary clocks container.
> 
> I understand this is suggested by Fabio, but I'm afraid that it's not
> going to work with imx_obtain_fixed_clock() call, which is coded to
> look for clocks under /clocks node.
> 

Should patch #1 be dropped from clk tree?
