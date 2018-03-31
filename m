Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753302AbeCaKTU (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 06:19:20 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:40462 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752885AbeCaKTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 06:19:18 -0400
X-Google-Smtp-Source: AIpwx4+MxkHRLra6SsvTC96+fnON8kxTte/TNhXV+63Ek3+TSf1/p5uIZfytSfOVoCQgFUkl32fiyQ==
Date: Sat, 31 Mar 2018 12:19:14 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: hpa@zytor.com, peterz@infradead.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        lkp@intel.com, sohil.mehta@intel.com, mitake@dcl.info.waseda.ac.jp,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/urgent] x86/io: Define readq()/writeq() to use 64-bit
 type
Message-ID: <20180331101914.ylrlgxhdohcosbnr@gmail.com>
References: <20180119143322.16555-1-andriy.shevchenko@linux.intel.com>
 <tip-0fc8483b698620ea3d8cc6635b54eccc613c23a3@git.kernel.org>
 <1522163426.21176.24.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1522163426.21176.24.camel@linux.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Tue, 2018-02-13 at 08:58 -0800, tip-bot for Andy Shevchenko wrote:
> > Commit-ID:  0fc8483b698620ea3d8cc6635b54eccc613c23a3
> > Gitweb:     https://git.kernel.org/tip/0fc8483b698620ea3d8cc6635b54ecc
> > c613c23a3
> > Author:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > AuthorDate: Fri, 19 Jan 2018 16:33:22 +0200
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Tue, 13 Feb 2018 17:14:41 +0100
> 
> As of today I don't see this in linux-next
> 
> % git tag --contains 0fc8483b69862
> next-20180214
> next-20180215
> next-20180216
> 
> What happened to this change?

Hm, so it's a real mystery: I merged it, then removed it 1.5 days later without 
reporting anything. According to the Git log timestamp the removal happened late 
at night, so maybe it was a tired typo?

Anyway, it's a good thing you kept out an eye for this: I re-applied the patch for 
v4.17 and will let you know if there's any problem in testing.

Thanks,

	Ingo
