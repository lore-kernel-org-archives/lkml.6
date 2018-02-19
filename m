Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753055AbeBSPUQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 10:20:16 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58684 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752619AbeBSPUP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 10:20:15 -0500
Date: Mon, 19 Feb 2018 12:20:11 -0300
From: Arnaldo Carvalho de Melo <acme@redhat.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the tip tree
Message-ID: <20180219152011.GB2149@redhat.com>
References: <20180218192555.73537987@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180218192555.73537987@canb.auug.org.au>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.5.20 (2009-12-10)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Sun, Feb 18, 2018 at 07:25:55PM +1100, Stephen Rothwell escreveu:
> Hi all,
> 
> Commit
> 
>   f091f1d6a2b4 ("tools/headers: Synchronize kernel ABI headers, v4.16-rc1")
> 
> is missing a Signed-off-by from its committer.

Argh, my bad, and it already made its way into v4.16-rc2 :-\

- Arnaldo
