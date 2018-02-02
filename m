Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751931AbeBBUOl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 15:14:41 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:41148 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751589AbeBBUOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 15:14:32 -0500
X-Google-Smtp-Source: AH8x225dpl0tDdcIp1SdbX3qZ8D8ft77kqW+yfKmpzJ4zVFyR9qLiUrDUsbZ4L75PnIlUeLc9sbCrOXolxSAK+D1d28=
MIME-Version: 1.0
In-Reply-To: <1517579017-19935-1-git-send-email-rajneesh.bhardwaj@intel.com>
References: <1517579017-19935-1-git-send-email-rajneesh.bhardwaj@intel.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 2 Feb 2018 22:14:31 +0200
Message-ID: <CAHp75Vdu1S9dLvfgUGQ+BMZ6rHfCNgPhSAqjqciqoA20nV0Nbw@mail.gmail.com>
Subject: Re: [Patch v2 0/5] platform/x86: intel_pmc_core: Add CFL/CNL Support
To: Rajneesh Bhardwaj <rajneesh.bhardwaj@intel.com>
Cc: Platform Driver <platform-driver-x86@vger.kernel.org>,
        Darren Hart <dvhart@infradead.org>,
        Andy Shevchenko <andy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Vishwanath Somayaji <vishwanath.somayaji@intel.com>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 2, 2018 at 3:43 PM, Rajneesh Bhardwaj
<rajneesh.bhardwaj@intel.com> wrote:
> This series contains the remaining (rebased) patches that were not applied
> to the pdx tree earlier. This also includes Acked-by / Reviewed-by tags from
> Rafael and Thomas.
>
> Rebased and tested on:
> http://git.infradead.org/linux-platform-drivers-x86.git/shortlog/refs/heads/review-andy
>

All 5 pushed to my review and testing queue.
Thanks!

> Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
> Cc: Len Brown <lenb@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
>
> Cc: linux-acpi@vger.kernel.org
> Cc: x86@kernel.org
>
> Rajneesh Bhardwaj (3):
>   x86/cpu: Add Cannonlake to Intel family
>   platform/x86: intel_pmc_core: Add CannonLake PCH support
>   platform/x86: intel_pmc_core: Special case for Coffeelake
>
> Srinivas Pandruvada (2):
>   ACPI / LPIT: Export lpit_read_residency_count_address()
>   platform/x86: intel_pmc_core: Read base address from LPIT
>
>  arch/x86/include/asm/intel-family.h   |   6 ++
>  drivers/acpi/acpi_lpit.c              |   1 +
>  drivers/platform/x86/intel_pmc_core.c | 108 +++++++++++++++++++++++++++++++++-
>  drivers/platform/x86/intel_pmc_core.h |  13 ++++
>  4 files changed, 127 insertions(+), 1 deletion(-)
>
> --
> 2.7.4
>



-- 
With Best Regards,
Andy Shevchenko
