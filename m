Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751791AbeFEP3t (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 11:29:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:39040 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751599AbeFEP3s (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 11:29:48 -0400
Date: Tue, 5 Jun 2018 12:29:43 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH V3 00/17] perf tools and x86 PTI entry trampolines
Message-ID: <20180605152943.GH4899@kernel.org>
References: <1526986485-6562-1-git-send-email-adrian.hunter@intel.com>
 <4017be61-554f-f356-b68d-64981261f8dd@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4017be61-554f-f356-b68d-64981261f8dd@intel.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 31, 2018 at 03:09:38PM +0300, Adrian Hunter escreveu:
> On 22/05/18 13:54, Adrian Hunter wrote:
> > Hi
> > 
> > Here is V3 of patches to support x86 PTI entry trampolines in perf tools.
> > 
> > Patches also here:
> > 	http://git.infradead.org/users/ahunter/linux-perf.git/shortlog/refs/heads/perf-tools-kpti-v3
> > 	git://git.infradead.org/users/ahunter/linux-perf.git perf-tools-kpti-v3
> > 
> 
> Arnaldo has queued the tools patches, but there are still 3 kernel patches:
> 
> 	kallsyms: Simplify update_iter_mod()
> 	kallsyms, x86: Export addresses of syscall trampolines
> 	x86: Add entry trampolines to kcore
> 
> Are there any further comments on these?  Can they be applied?

Would be interesting to have some acked-by from kernel folks :-\

- Arnaldo
