Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752237AbeBHUCd (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 15:02:33 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:54518 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbeBHUCc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 15:02:32 -0500
X-Google-Smtp-Source: AH8x226z6DHFdQH+KVOwss+2VUfxgwbZ7nKRI+3+l2lAHLAG9XycOK63NaPW2vRKGQq1HYmCsHVX0ZNhE8Nkk/csLFM=
MIME-Version: 1.0
In-Reply-To: <20180208194406.GD25181@hirez.programming.kicks-ass.net>
References: <20180207183543.GA8897@pd.tnic> <20180207184933.GA25201@hirez.programming.kicks-ass.net>
 <CA+55aFzS7w2SgC1H0MKWecHyhnZPypqWNmwuWbf9X93SHareWg@mail.gmail.com>
 <20180207191451.GC25201@hirez.programming.kicks-ass.net> <20180207192816.GA19536@pd.tnic>
 <CA+55aFzSZzdVZXatze=xjGSwpOPO7kvbWnz7JiZ3sTx_2Pohjw@mail.gmail.com>
 <20180208091302.GD25201@hirez.programming.kicks-ass.net> <CA+55aFySLxYkUQyNf5YcEvitjm2O1whEp4-iKNASPaOpxG1j9w@mail.gmail.com>
 <20180208180357.GC25181@hirez.programming.kicks-ass.net> <CA+55aFx7=cw0myoidwzhEfKd_L2Q6u0=AdcH_ZBmXu2_nD=4Jw@mail.gmail.com>
 <20180208194406.GD25181@hirez.programming.kicks-ass.net>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 8 Feb 2018 12:02:31 -0800
X-Google-Sender-Auth: HI1xICCW-SquHd3T9Ugz_Wf3wRw
Message-ID: <CA+55aFy=dN4W=V=k6LMcpAs8wkKU96M3Sj0U1Z-Lo+SfPGd2Kg@mail.gmail.com>
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

On Thu, Feb 8, 2018 at 11:44 AM, Peter Zijlstra <peterz@infradead.org> wrote:
>
> OK, here's the patch.. It leaves the UD0 in traps.c such that people
> could recompile their kernel with a simple change.

Ack, that seems about the best we can do.

              Linus
