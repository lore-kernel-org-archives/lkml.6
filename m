Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753215AbeBEQSV (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 11:18:21 -0500
Received: from mga12.intel.com ([192.55.52.136]:45986 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752925AbeBEQSP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 11:18:15 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,465,1511856000";
   d="scan'208";a="28925566"
Message-ID: <1517847491.22495.36.camel@linux.intel.com>
Subject: Re: [RFC, PATCH v1] platform/x86: intel-vbtn: Convert to pure ACPI
 driver
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Darren Hart <dvhart@infradead.org>
Cc: platform-driver-x86@vger.kernel.org,
        AceLan Kao <acelan.kao@canonical.com>, linux-kernel@vger.kernel.org,
        pali.rohar@gmail.com, Mario Limonciello <mario.limonciello@dell.com>,
        Rafael Wysocki <rjw@rjwysocki.net>
Date: Mon, 05 Feb 2018 18:18:11 +0200
In-Reply-To: <20180131213726.GB21498@fury>
References: <20180131182614.19524-1-andriy.shevchenko@linux.intel.com>
         <20180131213726.GB21498@fury>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.3-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2018-01-31 at 13:37 -0800, Darren Hart wrote:
> On Wed, Jan 31, 2018 at 08:26:14PM +0200, Andy Shevchenko wrote:
> > Remove code duplication by converting driver to pure ACPI one.
> 

I have fixed couple issues, but...

> +Rafael
> 
> I don't see any reason *not* to do this, it seems the acpi driver
> model provides
> some of the boilerplate stuff we were doing manually before as a
> platform
> device. I'm scratching my head wondering why we did this as a
> platform-driver in
> the first place now...

...I still keep in my review queue in a hope that someone can actually
test this on real hardware.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
