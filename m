Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754377AbeCGM4S (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 07:56:18 -0500
Received: from mga06.intel.com ([134.134.136.31]:16354 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754260AbeCGM4Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 07:56:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,435,1515484800";
   d="scan'208";a="23227797"
Message-ID: <1520427371.10722.453.camel@linux.intel.com>
Subject: Re: [PATCH v5 1/3] ACPI / x86: boot: Split out
 acpi_generic_reduce_hw_init() and export
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>,
        the arch/x86 maintainers <x86@kernel.org>,
        Eric Biederman <ebiederm@xmission.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Juergen Gross <jgross@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Wed, 07 Mar 2018 14:56:11 +0200
In-Reply-To: <1519383078.10722.107.camel@linux.intel.com>
References: <20180220180506.65523-1-andriy.shevchenko@linux.intel.com>
         <CAJZ5v0g7XO2N0vCi-A95MDjgJpTS0M=ZXrSGu2fqkwSHZ79GEg@mail.gmail.com>
         <1519383078.10722.107.camel@linux.intel.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-23 at 12:51 +0200, Andy Shevchenko wrote:
> On Tue, 2018-02-20 at 19:42 +0100, Rafael J. Wysocki wrote:
> > On Tue, Feb 20, 2018 at 7:05 PM, Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > > This is a preparation patch to allow override the hardware reduced
> > > initialization on ACPI enabled platforms.
> > > 
> > > No functional change intended.
> > > 
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > 
> > Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Thanks, Rafael!
> 
> Ingo, can it be applied?

Hmm... It seems Ingo is busy with something else.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
