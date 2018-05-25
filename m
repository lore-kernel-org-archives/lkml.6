Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967614AbeEYSEs (ORCPT <rfc822;w@1wt.eu>);
        Fri, 25 May 2018 14:04:48 -0400
Received: from mga11.intel.com ([192.55.52.93]:31609 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967473AbeEYSEq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 May 2018 14:04:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,440,1520924400";
   d="scan'208";a="57626306"
Message-ID: <1527271485.14836.49.camel@linux.intel.com>
Subject: Re: [PATCH] tools/power/x86/intel_pstate_tracer: Add optional
 setting of trace buffer memory allocation
From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Doug Smythies <doug.smythies@gmail.com>
Cc: dsmythies@telus.net, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Date: Fri, 25 May 2018 11:04:45 -0700
In-Reply-To: <9152600.1bIX9UMnel@aspire.rjw.lan>
References: <1525441582-23855-1-git-send-email-dsmythies@telus.net>
         <23851272.hyr4RImLsD@aspire.rjw.lan> <9152600.1bIX9UMnel@aspire.rjw.lan>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.24.6 (3.24.6-1.fc26) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2018-05-24 at 11:34 +0200, Rafael J. Wysocki wrote:
> On Sunday, May 13, 2018 10:43:02 AM CEST Rafael J. Wysocki wrote:
> > On Friday, May 4, 2018 3:46:22 PM CEST Doug Smythies wrote:
> > > Allow the user to override the default trace buffer memory
> > > allocation
> > > by adding a command line option to override the default.
> > > 
> > > The patch also:
> > > 
> > > Adds a SIGINT (i.e. CTRL C exit) handler,
> > > so that things can be cleaned up before exit.
> > > 
> > > Moves the postion of some other cleanup from after to
> > > before the potential "No valid data to plot" exit.
> > > 
> > > Replaces all quit() calls with sys.exit, because
> > > quit() is not supposed to be used in scripts.
> > > 
> > > Signed-off-by: Doug Smythies <dsmythies@telus.net>
> > 
> > Srinivas, any comments here?
Somehow I missed this email. But looks fine.

> 
> No concerns, so applied.  Thanks!
> 
