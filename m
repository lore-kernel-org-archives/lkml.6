Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbeERPlX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:41:23 -0400
Received: from mail.skyhub.de ([5.9.137.197]:38434 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750841AbeERPlU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:41:20 -0400
Date: Fri, 18 May 2018 17:40:44 +0200
From: Borislav Petkov <bp@alien8.de>
To: Nadav Amit <namit@vmware.com>
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Josh Poimboeuf <jpoimboe@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Denys Vlasenko <dvlasenk@redhat.com>
Subject: Re: [PATCH 2/6] x86: bug: prevent gcc distortions
Message-ID: <20180518154044.GE17285@pd.tnic>
References: <20180517161402.78089-1-namit@vmware.com>
 <20180517161402.78089-3-namit@vmware.com>
 <20180518075853.GD12217@hirez.programming.kicks-ass.net>
 <20180518081354.GA11379@gmail.com>
 <20180518101114.GB17285@pd.tnic>
 <A0A24A0C-7ED5-40DA-A017-7FE292F57939@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <A0A24A0C-7ED5-40DA-A017-7FE292F57939@vmware.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 02:36:21PM +0000, Nadav Amit wrote:
> I didn’t try too hard to find more affected (micro)benchmarks, but I am
> pretty sure there are:

So you being pretty sure there are, doesn't make me go, oh, ok, then,
this is an uglification we should try to live with. It is still ugly
with no proven benefit from it.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
