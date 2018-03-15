Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752523AbeCOSMN (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 14:12:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:50436 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751864AbeCOSMM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 14:12:12 -0400
Date: Thu, 15 Mar 2018 13:12:11 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
To: Borislav Petkov <bp@alien8.de>
Cc: X86 ML <x86@kernel.org>, Andy Lutomirski <luto@amacapital.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/9] x86/dumstack: Remove code_bytes
Message-ID: <20180315181211.jptkboqhgyqup4db@treble>
References: <20180315154448.16222-1-bp@alien8.de>
 <20180315154448.16222-2-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180315154448.16222-2-bp@alien8.de>
User-Agent: Mutt/1.6.0.1 (2016-04-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 04:44:40PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> This was added by
> 
>   86c418374223 ("[PATCH] i386: add option to show more code in oops reports")
> 
> long time ago but experience shows that 64 instruction bytes are plenty
> when deciphering an oops. So get rid of it.
> 
> Removing it will simplify further enhancements to the opcodes dumping
> machinery coming in the following patches.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>

s/dumstack/dumpstack/ in the subject.

-- 
Josh
