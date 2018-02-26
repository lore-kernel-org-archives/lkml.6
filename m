Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751737AbeBZVzK (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:55:10 -0500
Received: from muru.com ([72.249.23.125]:58432 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751334AbeBZVzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:55:09 -0500
Date: Mon, 26 Feb 2018 13:55:07 -0800
From: Tony Lindgren <tony@atomide.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH v1] genirq: Add wakeup sysfs node to show IRQ wakeup state
Message-ID: <20180226215507.GH16043@atomide.com>
References: <20180226155043.67937-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226155043.67937-1-andriy.shevchenko@linux.intel.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andy Shevchenko <andriy.shevchenko@linux.intel.com> [180226 15:51]:
> Surprisingly there is no simple way to see if the IRQ line in question
> is wakeup source or not.
> 
> Note that wakeup might be an OOB (out-of-band) source like GPIO line
> which makes things slightly more complicated.
> 
> Add a sysfs node to cover this case.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Works for me:

Tested-by: Tony Lindgren <tony@atomide.com>
