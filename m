Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161209AbeCATKz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 14:10:55 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:52219 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161124AbeCATKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 14:10:52 -0500
Date: Thu, 1 Mar 2018 20:10:49 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        John Stultz <john.stultz@linaro.org>, Petr Mladek <pmladek@suse.com>,
        Mark Salyzyn <salyzyn@android.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Kevin Easton <kevin@guarana.org>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>
Subject: Re: [RFC/RFT patch 0/7] timekeeping: Unify clock MONOTONIC and clock
 BOOTTIME
In-Reply-To: <alpine.DEB.2.21.1803011936200.1391@nanos.tec.linutronix.de>
Message-ID: <alpine.DEB.2.21.1803012009550.1391@nanos.tec.linutronix.de>
References: <20180301163331.987775783@linutronix.de> <CA+55aFzV8Q20vL83xa+1UKzeQ0w-SAksCDxJD4szALRDCSUZ2w@mail.gmail.com> <alpine.DEB.2.21.1803011936200.1391@nanos.tec.linutronix.de>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Mar 2018, Thomas Gleixner wrote:
> On Thu, 1 Mar 2018, Linus Torvalds wrote:
> > On Thu, Mar 1, 2018 at 8:33 AM, Thomas Gleixner <tglx@linutronix.de> wrote:
> > >
> > > This really needs lot of testing, documentation updates and more input from
> > > userspace folks to make a final decision.
> > 
> > Honestly, I don't think we'd get the testing this kind of change needs
> > except by just trying it.
> > 
> > I'm willing to merge this in the 4.17 merge window, with the
> > understanding that if people end up reporting issues, we may just have
> > to revert it all, and chalk it up to a learning experience - and add
> > the appropriate commentary in the kernel code about exactly what it
> > was that depended on that MONO/BOOT difference.
> 
> Fair enough. So we maybe just merge the first two patches and merge the
> cleanups and consolidation patches when we feel good enough.
> 
> I surely can queue the whole lot in next, but from PTI the experience I
> know how good the test coverage is. 4.14.stable would be the ideal testing
> ground. /me runs fast and hides

That said, at least the people who are asking for that should provide
testing results _before_ this gets applied or merged upstream.

Thanks,

	tglx
