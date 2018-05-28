Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753838AbeE1HUv (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 03:20:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:53700 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753638AbeE1HUp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 03:20:45 -0400
Date: Mon, 28 May 2018 15:20:35 +0800
From: Shawn Guo <shawnguo@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sascha Hauer <kernel@pengutronix.de>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        Will Deacon <will.deacon@arm.com>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Ian Ray <ian.ray@ge.com>,
        Nandor Han <nandor.han@ge.com>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv4 1/2] ARM: imx53: add secure-reg-access support for PMU
Message-ID: <20180528072034.GB3143@dragon>
References: <20180212123945.15732-1-sebastian.reichel@collabora.co.uk>
 <20180212123945.15732-2-sebastian.reichel@collabora.co.uk>
 <20180224074543.GF3217@dragon>
 <20180226134741.neqkpge33zo3pfzt@earth.universe>
 <20180227011033.GV3217@dragon>
 <20180227101712.3zwobvs4ox4jchcj@earth.universe>
 <20180528022652.GA3143@dragon>
 <20180528064131.y5burm5kakiazaq4@earth.universe>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180528064131.y5burm5kakiazaq4@earth.universe>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 28, 2018 at 08:41:31AM +0200, Sebastian Reichel wrote:
> > Are you saying this is a very specific setup required by i.MX53 only?
> 
> Yes, all other SoCs supported by Linux ARM PMU counters driver can
> just use the registers without having to enable platform specific
> bits first.
> 
> > In that case, I can live with it.
> 
> What about the DT node? I did not add it, since this is a i.MX53
> specific workaround anyways.

What you are adding here is secure-reg-access property, which has an
defined meaning in PMU binding doc.  I'm not really sure if it's
appropriate to use the property as a condition for DBGEN bit setup.
Or can we set up the bit regardless of the property?

Shawn
