Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752262AbeDZADu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 20:03:50 -0400
Received: from mga02.intel.com ([134.134.136.20]:4548 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751212AbeDZADt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 20:03:49 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,328,1520924400";
   d="scan'208";a="46088748"
Date: Thu, 26 Apr 2018 08:08:48 +0800
From: Yu Chen <yu.c.chen@intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Len Brown <lenb@kernel.org>,
        Artem Bityutskiy <artem.bityutskiy@intel.com>,
        Doug Smythies <dsmythies@telus.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][v5] tools/power turbostat: if --iterations, print for
 specific count of iterations
Message-ID: <20180426000847.GA20079@sandybridge-desktop>
References: <20180414041055.10159-1-yu.c.chen@intel.com>
 <1840879.edVvmFFlsp@aspire.rjw.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1840879.edVvmFFlsp@aspire.rjw.lan>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 23, 2018 at 10:48:39AM +0200, Rafael J. Wysocki wrote:
> On Saturday, April 14, 2018 6:10:55 AM CEST Yu Chen wrote:
> > From: Chen Yu <yu.c.chen@intel.com>
> > 
> > There's a use case during test to only print specific round of iterations
> > if --iterations is specified, for example, with this patch applied:
> > 
> > turbostat -i 5 -r 4
> > will capture 4 samples with 5 seconds interval.
> > 
> > Cc: Len Brown <lenb@kernel.org>
> > Cc: Rafael J Wysocki <rjw@rjwysocki.net>
> > Cc: Artem Bityutskiy <artem.bityutskiy@intel.com>
> > Cc: Doug Smythies <dsmythies@telus.net>
> > Cc: linux-pm@vger.kernel.org
> > Cc: linux-kernel@vger.kernel.org
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
[cut]...
> > +		if (iterations && (++done_iters >= iterations))
> 
> The inner parens are not needed here (and similarly below).
> 
> If you fix this little one, please feel free to add
> 
> Reviewed-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> to the patch (FWIW). 
> 
OK, will do, thanks!
Yu
