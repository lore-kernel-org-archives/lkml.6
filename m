Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932465AbeCOTGD (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 15:06:03 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51948 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751508AbeCOTGC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 15:06:02 -0400
Date: Thu, 15 Mar 2018 14:06:01 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 4/9] x86/dumpstack: Improve opcodes dumping in the Code:
 section
Message-ID: <20180315190601.iv5ptjqkxlolclmz@treble>
References: <20180315154448.16222-1-bp@alien8.de>
 <20180315154448.16222-5-bp@alien8.de>
 <20180315181054.3fuuetu6fxpzlpcn@treble>
 <20180315181612.GH27816@pd.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180315181612.GH27816@pd.tnic>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 07:16:13PM +0100, Borislav Petkov wrote:
> On Thu, Mar 15, 2018 at 01:10:54PM -0500, Josh Poimboeuf wrote:
> > I liked OPCODE_BUFSIZE where it was before :-)  Here it disrupts the
> > readability of the function a bit IMO.
> 
> My thinking is have it close by so that you don't have to go search for
> its definition.

But knowing the value of OPCODE_BUFSIZE isn't needed for understanding
the rest of the function, so it seems like clutter to me.  Besides,
that's what the vim cscope plugin is for :-)

But I also don't have a strong opinion.

-- 
Josh
