Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751902AbeFEQBF (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 12:01:05 -0400
Received: from merlin.infradead.org ([205.233.59.134]:40638 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751853AbeFEQBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 12:01:04 -0400
Date: Tue, 5 Jun 2018 18:00:46 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH V3 00/17] perf tools and x86 PTI entry trampolines
Message-ID: <20180605160046.GZ12180@hirez.programming.kicks-ass.net>
References: <1526986485-6562-1-git-send-email-adrian.hunter@intel.com>
 <4017be61-554f-f356-b68d-64981261f8dd@intel.com>
 <20180605152943.GH4899@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180605152943.GH4899@kernel.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 12:29:43PM -0300, Arnaldo Carvalho de Melo wrote:
> > Arnaldo has queued the tools patches, but there are still 3 kernel patches:
> > 
> > 	kallsyms: Simplify update_iter_mod()
> > 	kallsyms, x86: Export addresses of syscall trampolines

That one needs a changelog.

> > 	x86: Add entry trampolines to kcore
> > 
> > Are there any further comments on these?  Can they be applied?
> 
> Would be interesting to have some acked-by from kernel folks :-\

Other than that, they look good I tihnk. The updatE_iter_mod thing took
me a few tries, so maybe something can be done to the changelog there
too, maybe explicitly mention the rule for the *mod_end things.
