Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752647AbeDXQvm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:51:42 -0400
Received: from mga01.intel.com ([192.55.52.88]:4943 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751339AbeDXQve (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:51:34 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,323,1520924400";
   d="scan'208";a="36673220"
Message-ID: <1524588689.21176.506.camel@linux.intel.com>
Subject: Re: [tip:x86/urgent] x86/io: Define readq()/writeq() to use 64-bit
 type
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Ingo Molnar <mingo@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>, sohil.mehta@intel.com,
        mitake@dcl.info.waseda.ac.jp, linux-tip-commits@vger.kernel.org
Date: Tue, 24 Apr 2018 19:51:29 +0300
In-Reply-To: <20180331184528.dwpmpkpjj6ocwqhp@gmail.com>
References: <20180119143322.16555-1-andriy.shevchenko@linux.intel.com>
         <tip-0fc8483b698620ea3d8cc6635b54eccc613c23a3@git.kernel.org>
         <1522163426.21176.24.camel@linux.intel.com>
         <20180331101914.ylrlgxhdohcosbnr@gmail.com>
         <20180331102220.kmtu62uktmfrfe4a@gmail.com>
         <CAHp75Vd6O-=2dtbQ6eH8ye7QpW9PNEyZRdVwAyCDkS4TQW5vPQ@mail.gmail.com>
         <CAHp75VdPEG0xFcNYZZCpx4SPX8+7FHFcAGuSVd0vX7TuknmKiQ@mail.gmail.com>
         <20180331184528.dwpmpkpjj6ocwqhp@gmail.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1+b1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2018-03-31 at 20:45 +0200, Ingo Molnar wrote:
> * Andy Shevchenko <andy.shevchenko@gmail.com> wrote:
> 
> > On Sat, Mar 31, 2018 at 3:06 PM, Andy Shevchenko
> > <andy.shevchenko@gmail.com> wrote:
> > > On Sat, Mar 31, 2018 at 1:22 PM, Ingo Molnar <mingo@kernel.org>
> > > wrote:
> > > > * Ingo Molnar <mingo@kernel.org> wrote:
> > > >   [tip:x86/urgent 14/14]
> > > > drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1690:22: sparse:
> > > > incorrect type in argument 1 (different base types)
> > > > 
> > > > Since you were on Cc: of that report I assumed you'd take care
> > > > of it.
> > > 
> > > Ah, yes. This one I fixed.
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit
> > /?h=for-next&id=71591d1280e5ef02c2af2ffb9801d0c842973be9
> 
> Yeah, so this fix in the RDMA tree needs to go upstream first, before
> we can apply 
> the changes to the interface. Could you resend at around v4.17-rc1 or
> so?

Btw, should I recend or you can still pick it up from linux-next or
mailing list?

I can resend tomorrow if needed.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
