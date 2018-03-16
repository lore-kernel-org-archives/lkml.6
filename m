Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753458AbeCPNox (ORCPT <rfc822;w@1wt.eu>);
        Fri, 16 Mar 2018 09:44:53 -0400
Received: from mail.skyhub.de ([5.9.137.197]:49178 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753149AbeCPNou (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Mar 2018 09:44:50 -0400
Date: Fri, 16 Mar 2018 14:44:08 +0100
From: Borislav Petkov <bp@alien8.de>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: X86 ML <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 8/9] x86/dumpstack: Save first regs set for the executive
 summary
Message-ID: <20180316134408.GF5852@pd.tnic>
References: <20180315154448.16222-1-bp@alien8.de>
 <20180315154448.16222-9-bp@alien8.de>
 <20180315190132.2d653yu7ezf2zplh@treble>
 <20180316114849.GD5852@pd.tnic>
 <20180316120112.mqjvkdgl27scds6p@treble>
 <20180316121117.GE5852@pd.tnic>
 <20180316131606.l7tcqleeipx7vz6e@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180316131606.l7tcqleeipx7vz6e@treble>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 16, 2018 at 08:16:06AM -0500, Josh Poimboeuf wrote:
> Yeah, sounds good to me.  I think an earlier version of your patches
> already printed the user space opcodes anyway.

Right, which means it works already! :-P

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
