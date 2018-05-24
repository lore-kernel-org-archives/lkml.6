Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966074AbeEXJfW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 05:35:22 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:52647 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965921AbeEXJfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 05:35:19 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Doug Smythies <doug.smythies@gmail.com>
Cc: srinivas.pandruvada@linux.intel.com, dsmythies@telus.net,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] tools/power/x86/intel_pstate_tracer: Add optional setting of trace buffer memory allocation
Date: Thu, 24 May 2018 11:34:38 +0200
Message-ID: <9152600.1bIX9UMnel@aspire.rjw.lan>
In-Reply-To: <23851272.hyr4RImLsD@aspire.rjw.lan>
References: <1525441582-23855-1-git-send-email-dsmythies@telus.net> <23851272.hyr4RImLsD@aspire.rjw.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday, May 13, 2018 10:43:02 AM CEST Rafael J. Wysocki wrote:
> On Friday, May 4, 2018 3:46:22 PM CEST Doug Smythies wrote:
> > Allow the user to override the default trace buffer memory allocation
> > by adding a command line option to override the default.
> > 
> > The patch also:
> > 
> > Adds a SIGINT (i.e. CTRL C exit) handler,
> > so that things can be cleaned up before exit.
> > 
> > Moves the postion of some other cleanup from after to
> > before the potential "No valid data to plot" exit.
> > 
> > Replaces all quit() calls with sys.exit, because
> > quit() is not supposed to be used in scripts.
> > 
> > Signed-off-by: Doug Smythies <dsmythies@telus.net>
> 
> Srinivas, any comments here?

No concerns, so applied.  Thanks!
