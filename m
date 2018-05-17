Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752317AbeEQSIL (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 14:08:11 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35562 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752020AbeEQSIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 14:08:09 -0400
Date: Thu, 17 May 2018 20:07:59 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        linux-rpi-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Vince Weaver <vincent.weaver@maine.edu>, linux-kernel@vger.kernel.org,
        Eric Anholt <eric@anholt.net>, linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] arm: bcm2835: Add the PMU to the devicetree.
Message-ID: <20180517180758.GK12198@hirez.programming.kicks-ass.net>
References: <20180517131727.29263-1-eric@anholt.net>
 <1412187220.62585.1526572780332@email.1und1.de>
 <alpine.DEB.2.21.1805171233500.7984@macbook-air>
 <307323036.63872.1526576126537@email.1und1.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <307323036.63872.1526576126537@email.1und1.de>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 17, 2018 at 06:55:26PM +0200, Stefan Wahren wrote:
> > Vince Weaver <vincent.weaver@maine.edu> hat am 17. Mai 2018 um 18:34 geschrieben:
> > On Thu, 17 May 2018, Stefan Wahren wrote:
> > > > Eric Anholt <eric@anholt.net> hat am 17. Mai 2018 um 15:17 geschrieben:

> > > > The a53 and a7 counters seem to match up, so we advertise a7 so that
> > > > arm32 can probe.
> > 
> > so how closely did you look at the a53/a7 differences?  I see some major 
> > differences, especially with the CPU_CYCLES event (0xff vs 0x11).
> > 
> > The proper fix here might be to add a cortex-a53 PMU entry to the armv7 
> > code rather than trying to treat it as a cortex-a7.
> 
> we like to use the PMU of BCM2837 SoC (4x A53 cores) under arm32 and arm64.
> 
> What is the right way (tm) to the define the DT compatibles?
> Does the arm32 PMU driver need patching for proper A53 support?

I'm completely clueless on all of this; Mark might have ideas.
