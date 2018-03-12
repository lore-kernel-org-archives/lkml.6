Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751312AbeCLLBa (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 07:01:30 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:36402 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750752AbeCLLB2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 07:01:28 -0400
X-Google-Smtp-Source: AG47ELsM1cgLlOPIx/ei2HiaBcyucSW/acc0n0/dpbdaXhgLSCQikDRkEMrTpTr8AZGUSmzn2y8Jtw==
Date: Mon, 12 Mar 2018 12:01:22 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 1/3] ACPI / x86: boot: Split out
 acpi_generic_reduce_hw_init() and export
Message-ID: <20180312110122.x7srrgui6r4e7jxm@gmail.com>
References: <20180220180506.65523-1-andriy.shevchenko@linux.intel.com>
 <CAJZ5v0g7XO2N0vCi-A95MDjgJpTS0M=ZXrSGu2fqkwSHZ79GEg@mail.gmail.com>
 <1519383078.10722.107.camel@linux.intel.com>
 <1520427371.10722.453.camel@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520427371.10722.453.camel@linux.intel.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Fri, 2018-02-23 at 12:51 +0200, Andy Shevchenko wrote:
> > On Tue, 2018-02-20 at 19:42 +0100, Rafael J. Wysocki wrote:
> > > On Tue, Feb 20, 2018 at 7:05 PM, Andy Shevchenko
> > > <andriy.shevchenko@linux.intel.com> wrote:
> > > > This is a preparation patch to allow override the hardware reduced
> > > > initialization on ACPI enabled platforms.
> > > > 
> > > > No functional change intended.
> > > > 
> > > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > > 
> > > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> > 
> > Thanks, Rafael!
> > 
> > Ingo, can it be applied?
> 
> Hmm... It seems Ingo is busy with something else.

Sorry, it all looks good to me:

  Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
