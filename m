Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751805AbeBYN1K (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 08:27:10 -0500
Received: from mga02.intel.com ([134.134.136.20]:51771 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751699AbeBYN1I (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 08:27:08 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,393,1515484800";
   d="scan'208";a="30528290"
Message-ID: <1519565224.10722.148.camel@linux.intel.com>
Subject: Re: [PATCH v1 4/4] pci: Re-use new dmi_get_bios_year() helper
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-acpi@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Jean Delvare <jdelvare@suse.com>, linux-kernel@vger.kernel.org
Date: Sun, 25 Feb 2018 15:27:04 +0200
In-Reply-To: <20180223214051.GN14632@bhelgaas-glaptop.roam.corp.google.com>
References: <20180222125923.57385-1-andriy.shevchenko@linux.intel.com>
         <20180222125923.57385-4-andriy.shevchenko@linux.intel.com>
         <20180223214051.GN14632@bhelgaas-glaptop.roam.corp.google.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-23 at 15:40 -0600, Bjorn Helgaas wrote:
> Please use
> 
>   PCI: Re-use ...
> 
> to match the prevailing drivers/pci style.

Noted. (Same for x86/PCI part)

> On Thu, Feb 22, 2018 at 02:59:23PM +0200, Andy Shevchenko wrote:
> > ...instead of open coding its functionality.
> 
> Same comment about making the changelog complete, independent of the
> subject.

Any suggestion how it would look like? (Same question for previous
comment)

> > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> Acked-by: Bjorn Helgaas <bhelgaas@google.com>

Thanks!

> Let me know if you want me to take the series.  Otherwise I'll assume
> it
> goes elsewhere.

Ingo took them into x86/platform.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
