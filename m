Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932458AbeCOSQy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 14:16:54 -0400
Received: from mail.skyhub.de ([5.9.137.197]:55732 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932391AbeCOSQx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 14:16:53 -0400
Date: Thu, 15 Mar 2018 19:16:13 +0100
From: Borislav Petkov <bp@alien8.de>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: X86 ML <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/9] x86/dumpstack: Improve opcodes dumping in the Code:
 section
Message-ID: <20180315181612.GH27816@pd.tnic>
References: <20180315154448.16222-1-bp@alien8.de>
 <20180315154448.16222-5-bp@alien8.de>
 <20180315181054.3fuuetu6fxpzlpcn@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180315181054.3fuuetu6fxpzlpcn@treble>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 01:10:54PM -0500, Josh Poimboeuf wrote:
> I liked OPCODE_BUFSIZE where it was before :-)  Here it disrupts the
> readability of the function a bit IMO.

My thinking is have it close by so that you don't have to go search for
its definition.

But I don't have a strong opinion on where it should be so...

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
