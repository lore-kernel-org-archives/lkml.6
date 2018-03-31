Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753282AbeCaSpe (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 14:45:34 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:38541 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753045AbeCaSpd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 14:45:33 -0400
X-Google-Smtp-Source: AIpwx4/1v9hF+RKldbS6TFRtQZwE7Uk+pyGgrBVm+quYuwtED9yqOWgr8pwwHkGgoSr3o92YhaIQ2w==
Date: Sat, 31 Mar 2018 20:45:28 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>, sohil.mehta@intel.com,
        mitake@dcl.info.waseda.ac.jp, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/urgent] x86/io: Define readq()/writeq() to use 64-bit
 type
Message-ID: <20180331184528.dwpmpkpjj6ocwqhp@gmail.com>
References: <20180119143322.16555-1-andriy.shevchenko@linux.intel.com>
 <tip-0fc8483b698620ea3d8cc6635b54eccc613c23a3@git.kernel.org>
 <1522163426.21176.24.camel@linux.intel.com>
 <20180331101914.ylrlgxhdohcosbnr@gmail.com>
 <20180331102220.kmtu62uktmfrfe4a@gmail.com>
 <CAHp75Vd6O-=2dtbQ6eH8ye7QpW9PNEyZRdVwAyCDkS4TQW5vPQ@mail.gmail.com>
 <CAHp75VdPEG0xFcNYZZCpx4SPX8+7FHFcAGuSVd0vX7TuknmKiQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VdPEG0xFcNYZZCpx4SPX8+7FHFcAGuSVd0vX7TuknmKiQ@mail.gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Sat, Mar 31, 2018 at 3:06 PM, Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Sat, Mar 31, 2018 at 1:22 PM, Ingo Molnar <mingo@kernel.org> wrote:
> >> * Ingo Molnar <mingo@kernel.org> wrote:
> 
> >>   [tip:x86/urgent 14/14] drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1690:22: sparse: incorrect type in argument 1 (different base types)
> >>
> >> Since you were on Cc: of that report I assumed you'd take care of it.
> >
> > Ah, yes. This one I fixed.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=for-next&id=71591d1280e5ef02c2af2ffb9801d0c842973be9

Yeah, so this fix in the RDMA tree needs to go upstream first, before we can apply 
the changes to the interface. Could you resend at around v4.17-rc1 or so?

Thanks,

	Ingo
