Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932427AbeCIRmj (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 12:42:39 -0500
Received: from merlin.infradead.org ([205.233.59.134]:47518 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932288AbeCIRme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 12:42:34 -0500
Date: Fri, 9 Mar 2018 18:42:18 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Vince Weaver <vincent.weaver@maine.edu>
Cc: kan.liang@linux.intel.com, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, torvalds@linux-foundation.org, eranian@google.com,
        acme@redhat.com, hpa@zytor.com, alexander.shishkin@linux.intel.com,
        mingo@kernel.org, jolsa@redhat.com, linux-tip-commits@vger.kernel.org
Subject: Re: [tip:perf/core] perf/x86/intel: Disable userspace RDPMC usage
 for large PEBS
Message-ID: <20180309174218.GB4064@hirez.programming.kicks-ass.net>
References: <1518474035-21006-6-git-send-email-kan.liang@linux.intel.com>
 <tip-1af22eba248efe2de25658041a80a3d40fb3e92e@git.kernel.org>
 <alpine.DEB.2.21.1803090929380.4834@macbook-air>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1803090929380.4834@macbook-air>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 09, 2018 at 09:31:11AM -0500, Vince Weaver wrote:
> On Fri, 9 Mar 2018, tip-bot for Kan Liang wrote:
> 
> > Commit-ID:  1af22eba248efe2de25658041a80a3d40fb3e92e
> > Gitweb:     https://git.kernel.org/tip/1af22eba248efe2de25658041a80a3d40fb3e92e
> > Author:     Kan Liang <kan.liang@linux.intel.com>
> > AuthorDate: Mon, 12 Feb 2018 14:20:35 -0800
> > Committer:  Ingo Molnar <mingo@kernel.org>
> > CommitDate: Fri, 9 Mar 2018 08:22:23 +0100
> > 
> > perf/x86/intel: Disable userspace RDPMC usage for large PEBS
> > 
> 
> 
> So this whole commit log is about disabling RDPMC usage for "large PEBS"
> but the actual change disables RDPMC if "PERF_X86_EVENT_FREERUNNING"
> 
> Either the commit log is really misleading, or else a poor name was chosen 
> for this feature.

Its the same thing, and yes that might want renaming I suppose.
