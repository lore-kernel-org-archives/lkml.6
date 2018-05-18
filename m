Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeERKLw (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 06:11:52 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54460 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751560AbeERKLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 06:11:50 -0400
Date: Fri, 18 May 2018 12:11:14 +0200
From: Borislav Petkov <bp@alien8.de>
To: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Nadav Amit <namit@vmware.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org, nadav.amit@gmail.com,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Denys Vlasenko <dvlasenk@redhat.com>
Subject: Re: [PATCH 2/6] x86: bug: prevent gcc distortions
Message-ID: <20180518101114.GB17285@pd.tnic>
References: <20180517161402.78089-1-namit@vmware.com>
 <20180517161402.78089-3-namit@vmware.com>
 <20180518075853.GD12217@hirez.programming.kicks-ass.net>
 <20180518081354.GA11379@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180518081354.GA11379@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 10:13:54AM +0200, Ingo Molnar wrote:
> Yes, that's my main worry too about all these inlining changes:
> the very, very marked reduction in the readability of assembly code.

Same reaction here: the small improvements this brings is simply not
enough to sacrifice readability so much IMO.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
