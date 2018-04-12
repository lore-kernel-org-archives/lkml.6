Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751948AbeDLHcJ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 03:32:09 -0400
Received: from mga02.intel.com ([134.134.136.20]:50317 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750730AbeDLHcI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 03:32:08 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,440,1517904000";
   d="scan'208";a="216004550"
Date: Thu, 12 Apr 2018 15:35:20 +0800
From: Yu Chen <yu.c.chen@intel.com>
To: Doug Smythies <dsmythies@telus.net>
Cc: "'Len Brown'" <lenb@kernel.org>,
        "'Rafael J Wysocki'" <rjw@rjwysocki.net>,
        "'Artem Bityutskiy'" <artem.bityutskiy@intel.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][v3] tools/power turbostat: if --max_loop, print for
 specific time of loops
Message-ID: <20180412073520.GB24887@yu-chen.sh.intel.com>
References: <003e01d3d22e$7faa6b80$7eff4280$@net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <003e01d3d22e$7faa6b80$7eff4280$@net>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Doug,
On Thu, Apr 12, 2018 at 12:18:44AM -0700, Doug Smythies wrote:
> On 2018.04.11 03:31 Yu Chen wrote: 
> 
> > From: Chen Yu <yu.c.chen@intel.com>
> >
> > There's a use case during test to only print specific round of loops
> > if --iterations is specified, for example, with this patch applied:
> >
> > turbostat -i 5 -t 4
> > will capture 4 samples with 5 seconds interval.
> 
> Hi Yu,
> 
> This would be a very useful addition to turbostat.
> Please also update the man turbostat man page.
> 
> tools/power/x86/turbostat/turbostat.8
> 
OK, I will do this.
Thanks,
Yu
> ... Doug
> 
> 
