Return-Path: <linux-kernel-owner@vger.kernel.org>
Authentication-Results: smtp.codeaurora.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I4uZMEoA"
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 39C8B6070B
Authentication-Results: pdx-caf-mail.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: pdx-caf-mail.web.codeaurora.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752073AbeFFNO0 (ORCPT <rfc822;monsieuricon@codeaurora.org>
        + 25 others); Wed, 6 Jun 2018 09:14:26 -0400
Received: from merlin.infradead.org ([205.233.59.134]:59686 "EHLO
        merlin.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751864AbeFFNOZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jun 2018 09:14:25 -0400
Date: Wed, 6 Jun 2018 15:14:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Adrian Hunter <adrian.hunter@intel.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH V4 2/3] kallsyms, x86: Export addresses of PTI entry
 trampolines
Message-ID: <20180606131420.GC12180@hirez.programming.kicks-ass.net>
References: <1528289651-4113-1-git-send-email-adrian.hunter@intel.com>
 <1528289651-4113-3-git-send-email-adrian.hunter@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1528289651-4113-3-git-send-email-adrian.hunter@intel.com>
User-Agent: Mutt/1.9.5 (2018-04-13)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 06, 2018 at 03:54:10PM +0300, Adrian Hunter wrote:
> From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> 
> Currently, the addresses of PTI entry trampolines are not exported to user
> space. Kernel profiling tools need these addresses to identify the kernel
> code, so add a symbol and address for each CPU's PTI entry trampoline.
> 
> Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
> Acked-by: Andi Kleen <ak@linux.intel.com>

Thanks for the Changelog,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
