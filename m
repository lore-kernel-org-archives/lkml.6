Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751231AbeBIINI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Feb 2018 03:13:08 -0500
Received: from merlin.infradead.org ([205.233.59.134]:51414 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751144AbeBIINH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Feb 2018 03:13:07 -0500
Date: Fri, 9 Feb 2018 09:12:44 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Borislav Petkov <bp@alien8.de>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        kbuild test robot <fengguang.wu@intel.com>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [linus:master] BUILD REGRESSION
 a2e5790d841658485d642196dbb0927303d6c22f
Message-ID: <20180209081244.GI25201@hirez.programming.kicks-ass.net>
References: <CA+55aFzS7w2SgC1H0MKWecHyhnZPypqWNmwuWbf9X93SHareWg@mail.gmail.com>
 <20180207191451.GC25201@hirez.programming.kicks-ass.net>
 <20180207192816.GA19536@pd.tnic>
 <CA+55aFzSZzdVZXatze=xjGSwpOPO7kvbWnz7JiZ3sTx_2Pohjw@mail.gmail.com>
 <20180208091302.GD25201@hirez.programming.kicks-ass.net>
 <CA+55aFySLxYkUQyNf5YcEvitjm2O1whEp4-iKNASPaOpxG1j9w@mail.gmail.com>
 <20180208180357.GC25181@hirez.programming.kicks-ass.net>
 <CA+55aFx7=cw0myoidwzhEfKd_L2Q6u0=AdcH_ZBmXu2_nD=4Jw@mail.gmail.com>
 <20180208194406.GD25181@hirez.programming.kicks-ass.net>
 <20180208203146.GF577@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208203146.GF577@pd.tnic>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 09:31:46PM +0100, Borislav Petkov wrote:
> On Thu, Feb 08, 2018 at 08:44:06PM +0100, Peter Zijlstra wrote:

> > + * Since various instruction decoders/specs disagree on the encoding of
> > + * UD0/UD1,
> 	     ^
> 
> Does that comma mean the sentence continues somewhere?

No that's what doing patches while baking cup-cakes with my oldest
daughter gets me :-)
