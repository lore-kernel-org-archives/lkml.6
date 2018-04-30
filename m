Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754526AbeD3OyM (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 10:54:12 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39702 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754185AbeD3OyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 10:54:09 -0400
Date: Mon, 30 Apr 2018 16:54:05 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Tomer Maimon <tmaimon77@gmail.com>
cc: Joel Stanley <joel@jms.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>
Subject: Re: [GIT PULL] clockevents for 4.17
In-Reply-To: <CAP6Zq1jdXj0f0WfWK-b1X0hW=LcyMhxcLchHDkfVk2Fhho_HVg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1804301652230.1781@nanos.tec.linutronix.de>
References: <b2886156-4d6e-4c0c-1047-a54da8049ef6@linaro.org> <CACPK8Xep6XJ_hKD0had9BJOspvaLKDAXMwdGtO9xmqgM5x02vw@mail.gmail.com> <CAP6Zq1jdXj0f0WfWK-b1X0hW=LcyMhxcLchHDkfVk2Fhho_HVg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2018, Tomer Maimon wrote:

> Hi Thomas and Daniel,
> 
> Do you have news about the question below (from Joel)?
> 
> We hoped that NPCM7xx clocksource driver will upstream at 4.17

> > On 3 April 2018 at 22:30, Daniel Lezcano <daniel.lezcano@linaro.org>
> > wrote:
> > > It contains the following changes for 4.17:
> > >
> > >  - Fix timer name and register flow for imx's timer tmp and handle
> > > different counter width (Anson Huang)
> > >
> > >  - Add the NPCM7xx timer support (Tomer Maimon)
> >
> > I can't see this tree in 4.17-rc1. Do you know what happened there?

I'm pretty sure that I handled this pull request at some point, but then I
have no clue either where it got lost.

Sorry. I'll look at it later today.

Thanks,

	tglx
