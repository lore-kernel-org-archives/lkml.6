Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754697AbeD3PAZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 11:00:25 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39725 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754155AbeD3PAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 11:00:24 -0400
Date: Mon, 30 Apr 2018 17:00:21 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Tomer Maimon <tmaimon77@gmail.com>
cc: Joel Stanley <joel@jms.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Anson Huang <anson.huang@nxp.com>
Subject: Re: [GIT PULL] clockevents for 4.17
In-Reply-To: <alpine.DEB.2.21.1804301652230.1781@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1804301657050.1781@nanos.tec.linutronix.de>
References: <b2886156-4d6e-4c0c-1047-a54da8049ef6@linaro.org> <CACPK8Xep6XJ_hKD0had9BJOspvaLKDAXMwdGtO9xmqgM5x02vw@mail.gmail.com> <CAP6Zq1jdXj0f0WfWK-b1X0hW=LcyMhxcLchHDkfVk2Fhho_HVg@mail.gmail.com>
 <alpine.DEB.2.21.1804301652230.1781@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Apr 2018, Thomas Gleixner wrote:
> On Mon, 30 Apr 2018, Tomer Maimon wrote:
> 
> > Hi Thomas and Daniel,
> > 
> > Do you have news about the question below (from Joel)?
> > 
> > We hoped that NPCM7xx clocksource driver will upstream at 4.17
> > >
> > > I can't see this tree in 4.17-rc1. Do you know what happened there?
> 
> I'm pretty sure that I handled this pull request at some point, but then I
> have no clue either where it got lost.

If you had checked Linus tree before asking that question then you would
have seen:

commit d95c8844399885cd511c6f6395621cc1a9fe2e68
Merge: e6d9bfdeb439 90c7c0c24e22
Author: Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon Apr 16 12:44:03 2018 -0700

    Merge branch 'timers-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip
    
    Pull missed timer updates from Thomas Gleixner:
     "This is a branch which got forgotten during the merge window, but it
      contains only fixes and hardware enablement. No fundamental changes.
    
       - Various fixes for the imx-tpm clocksource driver
    
       - A new timer driver for the NCPM7xx SoC family"
    
    * 'timers-core-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip:
      clocksource/drivers/imx-tpm: Add different counter width support
      clocksource/drivers/imx-tpm: Correct some registers operation flow
      clocksource/drivers/imx-tpm: Fix typo of clock name
      dt-bindings: timer: tpm: fix typo of clock name
      clocksource/drivers/npcm: Add NPCM7xx timer driver
      dt-binding: timer: document NPCM7xx timer DT bindings

or just checking for drivers/clocksource/timer-npcm7xx.c would have
answered your question as well.

Thanks for stealing my time

       tglx
