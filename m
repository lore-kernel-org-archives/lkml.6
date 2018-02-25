Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751794AbeBYNd6 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 08:33:58 -0500
Received: from mga17.intel.com ([192.55.52.151]:51971 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751692AbeBYNd4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 08:33:56 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,393,1515484800";
   d="scan'208";a="33991083"
Message-ID: <1519565632.10722.150.camel@linux.intel.com>
Subject: Re: [PATCHv2] PM / wakeirq: Add wakeup name to dedicated wake irqs
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tony Lindgren <tony@atomide.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Date: Sun, 25 Feb 2018 15:33:52 +0200
In-Reply-To: <20180223220612.35181-1-tony@atomide.com>
References: <20180223220612.35181-1-tony@atomide.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-02-23 at 14:06 -0800, Tony Lindgren wrote:
> This makes it easy to grep :wakeup /proc/interrupts.

> +	char *name;

Wouldn't be const?

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
