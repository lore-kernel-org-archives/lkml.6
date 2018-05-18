Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752611AbeERHwl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 03:52:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50340 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752080AbeERHwj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 03:52:39 -0400
Date: Fri, 18 May 2018 09:52:27 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Joe Perches <joe@perches.com>
Cc: "David S . Miller" <davem@davemloft.net>,
        Allan Nielsen <Allan.Nielsen@microsemi.com>, razvan.stefanescu@nxp.com,
        po.liu@nxp.com, Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next ] net: mscc: Add SPDX identifier
Message-ID: <20180518075227.GF6828@piout.net>
References: <20180517192305.17517-1-alexandre.belloni@bootlin.com>
 <53ccb8c58e4c3e224ba694c0628096d0c041ba1a.camel@perches.com>
 <20180517193900.GE6828@piout.net>
 <ba4f4d2279b5f71e698136272637b42eeca05c54.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ba4f4d2279b5f71e698136272637b42eeca05c54.camel@perches.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2018 18:13:25-0700, Joe Perches wrote:
> On Thu, 2018-05-17 at 21:39 +0200, Alexandre Belloni wrote:
> > On 17/05/2018 12:28:59-0700, Joe Perches wrote:
> > > On Thu, 2018-05-17 at 21:23 +0200, Alexandre Belloni wrote:
> > > > ocelot_qsys.h is missing the SPDX identfier, fix that.
> > > > 
> > > > Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
> > > 
> > > Only the copyright holders should ideally be modifying
> > > these and also removing other license content.
> > > 
> > > For instance, what's the real intent here?
> > > 
> > 
> > Well, if you have a look, I submitted that file this cycle and it is the
> > only one that doesn't have the proper SPDX identifier. This is a mistake
> > I'm fixing.
> 
> Just because you submitted it does not mean you
> are the copyright holder.
> 
> > > > diff --git a/drivers/net/ethernet/mscc/ocelot_qsys.h b/drivers/net/ethernet/mscc/ocelot_qsys.h
> > > 
> > > []
> > > > @@ -1,7 +1,7 @@
> > > > +/* SPDX-License-Identifier: (GPL-2.0 OR MIT) */
> > > 
> > > GPL 2.0+ or 2.0?
> > > 
> > 
> > 2.0
> 
> How do you know that?
> 

The fact is that it should have been submitted with the SPDX identifier
to be consistent with the rest of the driver. If you can't trust me on
that, then, you can't probably trust anyone submitting anything new
driver to the kernel.

I still don't understand why you are making an issue out of this.

Because my email address doesn't match the copyright holder's name
doesn't mean I'm not allowed to fix my own mistake.

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
