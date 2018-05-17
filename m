Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752171AbeEQKFi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 06:05:38 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51348 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751619AbeEQKFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 06:05:32 -0400
Date: Thu, 17 May 2018 07:05:16 -0300
From: Mauro Carvalho Chehab <mchehab+samsung@kernel.org>
To: Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jason Chen <jasonx.z.chen@intel.com>, Andy Yeh <andy.yeh@intel.com>,
        Alan Chiang <alanx.chiang@intel.com>, Tomasz Figa <tfiga@chromium.org>,
        Jacopo Mondi <jacopo@jmondi.org>, Rob Herring <robh@kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commits in the v4l-dvb
 tree
Message-ID: <20180517070516.5d5dd34e@vento.lan>
In-Reply-To: <20180517071720.rb6sdozr5bwy543e@paasikivi.fi.intel.com>
References: <20180517073702.5497e72e@canb.auug.org.au>
        <20180517071720.rb6sdozr5bwy543e@paasikivi.fi.intel.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, 17 May 2018 10:17:20 +0300
Sakari Ailus <sakari.ailus@linux.intel.com> escreveu:

> On Thu, May 17, 2018 at 07:37:02AM +1000, Stephen Rothwell wrote:
> > Hi Mauro,
> > 
> > Commit
> > 
> >   af76c93aa36d ("media: cadence: csi2rx: Fix csi2rx_start error handling")
> > 
> > is missing a Signed-off-by from its committer.  
> 
> Mauro's SoB line is indeed missing. I wonder what happened.
> 
> > 
> > Commits
> > 
> >   c578c7710712 ("media: imx258: Add imx258 camera sensor driver")
> >   3a8fdc1426c3 ("media: dw9807: Add dw9807 vcm driver")
> >   2f9c1c88369f ("media: dt-bindings: Add bindings for Dongwoon DW9807 voice coil")
> > 
> > are missing a Signed-off-by from their author.  
> 
> Thanks for pointing this out. We'll be more careful going forward.

In this specific case, we're adding two drivers without their
author's SOBs. I'll roll-back my tree to a sane state (and, while
there, add my SOB at the missing commit).

Sakari,

You'll need to resubmit those patches (and the dependent ones) once
you get the author's SOBs.

Thanks,
Mauro
