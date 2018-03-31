Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752442AbeCaMPv (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 08:15:51 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:46684 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751432AbeCaMPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 08:15:50 -0400
X-Google-Smtp-Source: AIpwx48Oa9DuGqHZv6lhzZoPx5pY3TxpBF/1m+SP57dbaiHKZVt46vY01OWMB2AIJ8F1QI4imEc1+GD849F2nyisDHo=
MIME-Version: 1.0
In-Reply-To: <CAHp75Vd6O-=2dtbQ6eH8ye7QpW9PNEyZRdVwAyCDkS4TQW5vPQ@mail.gmail.com>
References: <20180119143322.16555-1-andriy.shevchenko@linux.intel.com>
 <tip-0fc8483b698620ea3d8cc6635b54eccc613c23a3@git.kernel.org>
 <1522163426.21176.24.camel@linux.intel.com> <20180331101914.ylrlgxhdohcosbnr@gmail.com>
 <20180331102220.kmtu62uktmfrfe4a@gmail.com> <CAHp75Vd6O-=2dtbQ6eH8ye7QpW9PNEyZRdVwAyCDkS4TQW5vPQ@mail.gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sat, 31 Mar 2018 15:15:49 +0300
Message-ID: <CAHp75VdPEG0xFcNYZZCpx4SPX8+7FHFcAGuSVd0vX7TuknmKiQ@mail.gmail.com>
Subject: Re: [tip:x86/urgent] x86/io: Define readq()/writeq() to use 64-bit type
To: Ingo Molnar <mingo@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>, sohil.mehta@intel.com,
        mitake@dcl.info.waseda.ac.jp, linux-tip-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 31, 2018 at 3:06 PM, Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
> On Sat, Mar 31, 2018 at 1:22 PM, Ingo Molnar <mingo@kernel.org> wrote:
>> * Ingo Molnar <mingo@kernel.org> wrote:

>>   [tip:x86/urgent 14/14] drivers/infiniband/hw/hns/hns_roce_hw_v1.c:1690:22: sparse: incorrect type in argument 1 (different base types)
>>
>> Since you were on Cc: of that report I assumed you'd take care of it.
>
> Ah, yes. This one I fixed.

https://git.kernel.org/pub/scm/linux/kernel/git/rdma/rdma.git/commit/?h=for-next&id=71591d1280e5ef02c2af2ffb9801d0c842973be9

-- 
With Best Regards,
Andy Shevchenko
