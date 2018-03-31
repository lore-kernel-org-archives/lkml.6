Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753198AbeCaKWZ (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 06:22:25 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:50544 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752885AbeCaKWY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 06:22:24 -0400
X-Google-Smtp-Source: AIpwx48jXGjO42t/o/7kc2RELdgv9JheXVDqe1Vh4vWUhxLxxy+pHSdreUDKGR244aBeokXfh4I+OA==
Date: Sat, 31 Mar 2018 12:22:20 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: hpa@zytor.com, peterz@infradead.org, tglx@linutronix.de,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        lkp@intel.com, sohil.mehta@intel.com, mitake@dcl.info.waseda.ac.jp,
        linux-tip-commits@vger.kernel.org
Subject: Re: [tip:x86/urgent] x86/io: Define readq()/writeq() to use 64-bit
 type
Message-ID: <20180331102220.kmtu62uktmfrfe4a@gmail.com>
References: <20180119143322.16555-1-andriy.shevchenko@linux.intel.com>
 <tip-0fc8483b698620ea3d8cc6635b54eccc613c23a3@git.kernel.org>
 <1522163426.21176.24.camel@linux.intel.com>
 <20180331101914.ylrlgxhdohcosbnr@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180331101914.ylrlgxhdohcosbnr@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Ingo Molnar <mingo@kernel.org> wrote:

> > As of today I don't see this in linux-next
> > 
> > % git tag --contains 0fc8483b69862
> > next-20180214
> > next-20180215
> > next-20180216
> > 
> > What happened to this change?
> 
> Hm, so it's a real mystery: I merged it, then removed it 1.5 days later without 
> reporting anything. According to the Git log timestamp the removal happened late 
> at night, so maybe it was a tired typo?

So just a few seconds after sending this I remembered why I zapped it: it was a 
Sparse failure reported by the kbuild-test robot.

Here's the report:

  [tip:x86/urgent 14/14] drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1690:22: sparse: incorrect type in argument 1 (different base types)

Since you were on Cc: of that report I assumed you'd take care of it.

Thanks,

	Ingo
