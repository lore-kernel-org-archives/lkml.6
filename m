Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752458AbeDJKxm (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 06:53:42 -0400
Received: from mga05.intel.com ([192.55.52.43]:6491 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751851AbeDJKxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 06:53:39 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,431,1517904000";
   d="scan'208";a="215449327"
Message-ID: <1523357615.2753.188.camel@gmail.com>
Subject: Re: [PATCH][RFC] tools/power turbostat: if --max_loop, print for
 specific time of loops
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: "Rafael J. Wysocki" <rafael@kernel.org>, Yu Chen <yu.c.chen@intel.com>
Cc: Len Brown <lenb@kernel.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date: Tue, 10 Apr 2018 13:53:35 +0300
In-Reply-To: <CAJZ5v0ic=bm76r=z+owZamVpb-fFxy3tqfeFvh_N2ROKpsYo=A@mail.gmail.com>
References: <20180410101831.28530-1-yu.c.chen@intel.com>
         <CAJZ5v0ic=bm76r=z+owZamVpb-fFxy3tqfeFvh_N2ROKpsYo=A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2018-04-10 at 12:22 +0200, Rafael J. Wysocki wrote:
> On Tue, Apr 10, 2018 at 12:18 PM, Yu Chen <yu.c.chen@intel.com>
> wrote:
> > From: Chen Yu <yu.c.chen@intel.com>
> > 
> > There's a use case during test to only print specific round of
> > loops
> > if --interval is specified, for example, with this patch applied:
> > 
> > turbostat -i 5 --max_loops 4
> > will capture 4 samples with 5 seconds interval.
> 
> Why --max_loops and not just --loops or --iterations?

Or just --count.

Artem.
