Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426021AbeCBJxr (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 04:53:47 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:51365 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424670AbeCBJxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 04:53:38 -0500
Message-ID: <1519984410.16239.1.camel@pengutronix.de>
Subject: Re: [PATCH] reset: ti-rstctrl: use the reset-simple driver
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Tony Lindgren <tony@atomide.com>
Cc: Philipp Zabel <philipp.zabel@gmail.com>,
        Paul Parsons <lost.distance@yahoo.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-omap@vger.kernel.org,
        Dave Gerlach <d-gerlach@ti.com>, Mark Rutland <mark.rutland@arm.com>,
        Nishant Menon <nm@ti.com>, Rob Herring <robh+dt@kernel.org>,
        Suman Anna <s-anna@ti.com>, Tero Kristo <t-kristo@ti.com>
Date: Fri, 02 Mar 2018 10:53:30 +0100
In-Reply-To: <20180301181447.GG62820@atomide.com>
References: <20180116011159.1386-1-tony@atomide.com>
         <1516095054.9022.1.camel@pengutronix.de>
         <20180116150314.GC4042@atomide.com> <20180301181447.GG62820@atomide.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6-1+deb9u1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:100:3ad5:47ff:feaf:1a17
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On Thu, 2018-03-01 at 10:14 -0800, Tony Lindgren wrote:
> * Tony Lindgren <tony@atomide.com> [180116 07:03]:
> > * Philipp Zabel <p.zabel@pengutronix.de> [180116 09:52]:
> > > Looks good to me. Can I move the compatible property when applying?
> > 
> > Oops, here's a better version. I also left out the "prcm" part as
> > at some point that should have just ranges instead of both reg and
> > ranges that it currently has.
> 
> Philipp, do you need me to resend v2 of this patch against v4.16-rc?

Rebasing onto linux-next or
  git://git.pengutronix.de/pza/linux.git
reset/next
would help me, but is not required.

> The changes we discussed with Suman can then be done as
> separate patches as needed :)

The discussion just went a bit over my head. If you have reached an
agreement, could I get Suman's Acked-by for this patch?

regards
Philipp
