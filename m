Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933456AbeEWPWg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 11:22:36 -0400
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:57110 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933282AbeEWPWf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 11:22:35 -0400
Date: Wed, 23 May 2018 16:23:02 +0100
From: Will Deacon <will.deacon@arm.com>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Joel Fernandes <joel.opensrc@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Zankel <chris@zankel.net>, Paul Mackerras <paulus@samba.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Michael Ellerman <mpe@ellerman.id.au>, Rich Felker <dalias@libc.org>,
        Ingo Molnar <mingo@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: Re: [PATCH 06/12] arm64: Implement hw_breakpoint_arch_parse()
Message-ID: <20180523152302.GC2983@arm.com>
References: <1526697950-7091-1-git-send-email-frederic@kernel.org>
 <1526697950-7091-7-git-send-email-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1526697950-7091-7-git-send-email-frederic@kernel.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 19, 2018 at 04:45:43AM +0200, Frederic Weisbecker wrote:
> Migrate to the new API in order to remove arch_validate_hwbkpt_settings()
> that clumsily mixes up architecture validation and commit.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Andy Lutomirski <luto@kernel.org>
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: Ingo Molnar <mingo@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Max Filippov <jcmvbkbc@gmail.com>
> Cc: Chris Zankel <chris@zankel.net>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
> Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Cc: Jiri Olsa <jolsa@redhat.com>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Joel Fernandes <joel.opensrc@gmail.com>
> ---
>  arch/arm64/include/asm/hw_breakpoint.h |  6 ++-
>  arch/arm64/kernel/hw_breakpoint.c      | 79 +++++++++++++++++-----------------
>  2 files changed, 45 insertions(+), 40 deletions(-)

Looks fairly mechanical:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
