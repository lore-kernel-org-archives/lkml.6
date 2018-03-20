Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752655AbeCTKwL (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 06:52:11 -0400
Received: from cloudserver094114.home.pl ([79.96.170.134]:48095 "EHLO
        cloudserver094114.home.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751552AbeCTKwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 06:52:10 -0400
From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
To: Doug Smythies <dsmythies@telus.net>
Cc: "'Peter Zijlstra'" <peterz@infradead.org>,
        "'Frederic Weisbecker'" <fweisbec@gmail.com>,
        "'Thomas Gleixner'" <tglx@linutronix.de>,
        "'Paul McKenney'" <paulmck@linux.vnet.ibm.com>,
        "'Thomas Ilsche'" <thomas.ilsche@tu-dresden.de>,
        "'Rik van Riel'" <riel@surriel.com>,
        "'Aubrey Li'" <aubrey.li@linux.intel.com>,
        "'Mike Galbraith'" <mgalbraith@suse.de>,
        "'LKML'" <linux-kernel@vger.kernel.org>,
        "'Linux PM'" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3] cpuidle: poll_state: Add time limit to poll_idle()
Date: Tue, 20 Mar 2018 11:52:37 +0100
Message-ID: <1726729.vkejFNOM44@aspire.rjw.lan>
In-Reply-To: <000f01d3bba5$3cba5a00$b62f0e00$@net>
References: <000f01d3bba5$3cba5a00$b62f0e00$@net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday, March 14, 2018 4:00:44 PM CET Doug Smythies wrote:
> On 2018.03.14 07:09 Rafael J. Wysocki wrote:
> 
> ... [snip]...
> 
> > v2 -> v3: Use local_clock() for time measurements and drop the
> >          counter, since that should be lightweight enough (as
> >          suggested by Peter).
> 
> I have been testing the latest of everything for a couple of days
> now, and everything continues to be great.

Due to the lack of any further comments from anyone, I have queued up this
patch with a Tested-by from you.

Thanks!
