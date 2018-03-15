Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752620AbeCOSSQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 14:18:16 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55800 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751864AbeCOSSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 14:18:15 -0400
Date: Thu, 15 Mar 2018 19:17:37 +0100
From: Borislav Petkov <bp@alien8.de>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: X86 ML <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 9/9] x86/dumpstack: Explain the reasoning for the
 prologue and buffer size
Message-ID: <20180315181737.GI27816@pd.tnic>
References: <20180315154448.16222-1-bp@alien8.de>
 <20180315154448.16222-10-bp@alien8.de>
 <20180315180731.mnbpqjte4wafnzd3@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180315180731.mnbpqjte4wafnzd3@treble>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 01:07:31PM -0500, Josh Poimboeuf wrote:
> > +/*
> > + * The are a couple of reasons for the 2/3rd prologue, courtesy of Linus:
> 
> s/The/There/

Fixed, thanks.

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
