Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752008AbeBZVzW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 16:55:22 -0500
Received: from mga06.intel.com ([134.134.136.31]:46123 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751823AbeBZVzU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 16:55:20 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,398,1515484800";
   d="scan'208";a="20977690"
Message-ID: <1519682116.10722.206.camel@linux.intel.com>
Subject: Re: [PATCHv2] PM / wakeirq: Add wakeup name to dedicated wake irqs
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To: Tony Lindgren <tony@atomide.com>
Cc: "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Alan Stern <stern@rowland.harvard.edu>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Brian Norris <briannorris@chromium.org>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Date: Mon, 26 Feb 2018 23:55:16 +0200
In-Reply-To: <20180226215102.GG16043@atomide.com>
References: <20180223220612.35181-1-tony@atomide.com>
         <1519565632.10722.150.camel@linux.intel.com>
         <20180226215102.GG16043@atomide.com>
Organization: Intel Finland Oy
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.5-1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2018-02-26 at 13:51 -0800, Tony Lindgren wrote:
> * Andy Shevchenko <andriy.shevchenko@linux.intel.com> [180225 13:37]:
> > On Fri, 2018-02-23 at 14:06 -0800, Tony Lindgren wrote:
> > > 


> +	wirq->name = kasprintf(GFP_KERNEL, "%s:wakeup",
> +			       dev_name(dev));

Can it make one line?

In any case,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Intel Finland Oy
