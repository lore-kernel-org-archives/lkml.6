Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752815AbeDJMQh (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 08:16:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:30092 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752775AbeDJMQf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 08:16:35 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,431,1517904000";
   d="scan'208";a="49567773"
Date: Tue, 10 Apr 2018 20:19:49 +0800
From: Yu Chen <yu.c.chen@intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Artem Bityutskiy <artem.bityutskiy@intel.com>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] tools/power turbostat: if --max_loop, print for
 specific time of loops
Message-ID: <20180410121949.GA29464@yu-chen.sh.intel.com>
References: <20180410101831.28530-1-yu.c.chen@intel.com>
 <CAJZ5v0ic=bm76r=z+owZamVpb-fFxy3tqfeFvh_N2ROKpsYo=A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0ic=bm76r=z+owZamVpb-fFxy3tqfeFvh_N2ROKpsYo=A@mail.gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 12:22:16PM +0200, Rafael J. Wysocki wrote:
> On Tue, Apr 10, 2018 at 12:18 PM, Yu Chen <yu.c.chen@intel.com> wrote:
> > From: Chen Yu <yu.c.chen@intel.com>
> >
> > There's a use case during test to only print specific round of loops
> > if --interval is specified, for example, with this patch applied:
> >
> > turbostat -i 5 --max_loops 4
> > will capture 4 samples with 5 seconds interval.
> 
> Why --max_loops and not just --loops or --iterations?
>
I thought -l has been used already. OK, changed to --interation and
-t respectively.

Thanks!
