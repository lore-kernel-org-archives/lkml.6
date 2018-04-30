Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756194AbeD3T7h (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 15:59:37 -0400
Received: from emh01.mail.saunalahti.fi ([62.142.5.107]:57134 "EHLO
        emh01.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756061AbeD3T7f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 15:59:35 -0400
Date: Mon, 30 Apr 2018 22:59:31 +0300
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>
Subject: Re: [PATCH] video: fbdev: omap2: remove rfbi
Message-ID: <20180430195931.GC2456@t60.musicnaut.iki.fi>
References: <CGME20180427150914eucas1p14dd8df4a215014ddac990b0ccdb1805c@eucas1p1.samsung.com>
 <2238944.jilJcacc6d@amdc3058>
 <20180427174714.bdvvlljk3txwu2bo@darkstar.musicnaut.iki.fi>
 <2055912.iuafLNK0IC@amdc3058>
 <20180427181243.o7ro63l6z7yatey7@darkstar.musicnaut.iki.fi>
 <cd513378-7be2-a5eb-adc5-bf04c789f1d4@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cd513378-7be2-a5eb-adc5-bf04c789f1d4@ti.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Apr 30, 2018 at 10:06:11AM +0300, Tomi Valkeinen wrote:
> On 27/04/18 21:12, Aaro Koskinen wrote:
> >> You should be targeting omapdrm driver instead, fbdev subsystem is closed
> >> for the new hardware support.
> > 
> > AFAIK, based on N950 display support discussion, it's impossible to get
> > anything new into omapdrm for a long time. And based on Tomi's comments,
> > restoring RFBI support with omapfb should be a minor thing.
> 
> I was perhaps a bit vague, but I didn't say it should be a minor thing.
> I meant that there should be no architectural obstacles in omapfb, and I
> think all the generic plumbing to enable N800 display is there in omapfb.
> 
> That said, it still needs a real amount of work with the rfbi driver,
> the encoder driver and the panel driver on N800 (the encoder and the
> panel driver are not in mainline anymore).

Let's see first if I get anything working. After that we can evaluate
the impact properly once we see the actual patches needed.

A.
