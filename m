Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeDQVHM (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 17:07:12 -0400
Received: from mail.skyhub.de ([5.9.137.197]:40086 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751878AbeDQVHL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 17:07:11 -0400
Date: Tue, 17 Apr 2018 23:06:50 +0200
From: Borislav Petkov <bp@alien8.de>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
        X86 ML <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/9] x86/dumpstack: Cleanups and user opcode bytes Code:
 section, v2
Message-ID: <20180417210650.GD3633@pd.tnic>
References: <20180315154448.16222-1-bp@alien8.de>
 <CA+55aFyvwdG49eCgX9Bs9UGEo4VWgS7dY6ZuEkBuugxTR58GnA@mail.gmail.com>
 <20180417144042.GB20840@pd.tnic>
 <20180417201655.szlq2oxur4mg24uh@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180417201655.szlq2oxur4mg24uh@treble>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 03:16:55PM -0500, Josh Poimboeuf wrote:
> I don't think the stack tracing code could do anything better here.  #3
> and #4 seem like an issue with the scheduler, it doesn't realize the
> rest of the CPUs have all been taken offline due to the panic().

So maybe teach the WARN code to check whether a panic() has happened?

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
