Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752178AbeBHSPd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 13:15:33 -0500
Received: from mail-io0-f195.google.com ([209.85.223.195]:34585 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752028AbeBHSPc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 13:15:32 -0500
X-Google-Smtp-Source: AH8x227raClyZtUesDUftblvipXUpFleMnR5YBpphun1GR/eB30jhCHc+CBQcUwZ890Pw+rLl+/Cstfie4TqUPbOqeY=
MIME-Version: 1.0
In-Reply-To: <20180208180357.GC25181@hirez.programming.kicks-ass.net>
References: <5a7ae6af.WSMpvDEeUt6oucKB%fengguang.wu@intel.com>
 <CA+55aFxU7TArLUdcndeLnhfRKLO-Vu-1d0Q6VPb9NYt+-S-LNg@mail.gmail.com>
 <20180207183543.GA8897@pd.tnic> <20180207184933.GA25201@hirez.programming.kicks-ass.net>
 <CA+55aFzS7w2SgC1H0MKWecHyhnZPypqWNmwuWbf9X93SHareWg@mail.gmail.com>
 <20180207191451.GC25201@hirez.programming.kicks-ass.net> <20180207192816.GA19536@pd.tnic>
 <CA+55aFzSZzdVZXatze=xjGSwpOPO7kvbWnz7JiZ3sTx_2Pohjw@mail.gmail.com>
 <20180208091302.GD25201@hirez.programming.kicks-ass.net> <CA+55aFySLxYkUQyNf5YcEvitjm2O1whEp4-iKNASPaOpxG1j9w@mail.gmail.com>
 <20180208180357.GC25181@hirez.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 8 Feb 2018 10:15:30 -0800
X-Google-Sender-Auth: AxmS_C9efPAESFZrgUstUNwykKs
Message-ID: <CA+55aFx7=cw0myoidwzhEfKd_L2Q6u0=AdcH_ZBmXu2_nD=4Jw@mail.gmail.com>
Subject: Re: [linus:master] BUILD REGRESSION a2e5790d841658485d642196dbb0927303d6c22f
To: Peter Zijlstra <peterz@infradead.org>
Cc: Borislav Petkov <bp@alien8.de>,
        kbuild test robot <fengguang.wu@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 8, 2018 at 10:03 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>
> But yes, for our purposes UD2 is perfectly fine too, it will just mess
> up the people doing bringup and the like.

Oh, we'll inconvenience people inside Intel?

The same people who changed and screwed up the definition of UD0 just
a couple of months ago?

I'm *so* sorry for the inconvenience to those people /s.

F*ck them. They introduced the problem, they get to live with it.

                 Linus
