Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752022AbeBDOOy (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 09:14:54 -0500
Received: from mga04.intel.com ([192.55.52.120]:50256 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750995AbeBDOOr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 09:14:47 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.46,458,1511856000";
   d="scan'208";a="24751755"
Message-ID: <1517753684.7000.1509.camel@linux.intel.com>
Subject: Re: [PATCH v1 1/3] ACPI / x86: boot: Not all platforms require
 acpi_reduced_hw_init()
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Sun, 04 Feb 2018 16:14:44 +0200
In-Reply-To: <3139601.BsU5hxGGNu@aspire.rjw.lan>
References: <20180117173409.88136-1-andriy.shevchenko@linux.intel.com>
         <3139601.BsU5hxGGNu@aspire.rjw.lan>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.3-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2018-02-04 at 09:54 +0100, Rafael J. Wysocki wrote:
> OTOH, I guess you'll go for the new init callbacks rather.

Yep, just ignore these two for now. I will remake it later.

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
