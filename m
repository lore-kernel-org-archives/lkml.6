Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751401AbeDYTKB (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 15:10:01 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:43028 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751165AbeDYTJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 15:09:57 -0400
Date: Wed, 25 Apr 2018 21:09:29 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Linus Torvalds <torvalds@linux-foundation.org>
cc: Mark Salyzyn <salyzyn@android.com>, Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        John Stultz <john.stultz@linaro.org>, Peter Anvin <hpa@zytor.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Prarit Bhargava <prarit@redhat.com>,
        Steven Rostedt <rostedt@goodmis.org>, Pavel Machek <pavel@ucw.cz>,
        Kevin Easton <kevin@guarana.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Petr Mladek <pmladek@suse.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        SergeySenozhatsky <sergey.senozhatsky@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:timers/urgent] Revert: Unify CLOCK_MONOTONIC and
 CLOCK_BOOTTIME
In-Reply-To: <CA+55aFypQ0aMSO7T0hxN2YCvckSLZh6BMTuz185TyJZ69jRUrg@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1804252108280.1589@nanos.tec.linutronix.de>
References: <tip-757d5a9b3052a4eebd029f207f1e1df59bef7b7d@git.kernel.org> <CA+55aFypQ0aMSO7T0hxN2YCvckSLZh6BMTuz185TyJZ69jRUrg@mail.gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 Apr 2018, Linus Torvalds wrote:
> On Wed, Apr 25, 2018 at 6:45 AM, tip-bot for Thomas Gleixner
> <tipbot@zytor.com> wrote:
> >
> > As stated in the pull request for the unification of CLOCK_MONOTONIC and
> > CLOCK_BOOTTIME, it was clear that we might have to revert the change.
> 
> I'm ok with the revert., but I do want the revert message to talk
> about *exactly* what broke.
> 
> I don't see the reported watchdog things, and I run systemd and I ran
> these patches.

With suspend/resume?

> So it's not just "systemd uses this for a watchdog". It must be
> something specific that made it trigger for some people and not
> others, and it's that specific thing that we should document so that
> we know why this simplification failed.

Fair enough. Do the reporters have more information or do I have to chase
it down myself?

Thanks,

	tglx
