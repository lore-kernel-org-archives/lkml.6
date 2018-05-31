Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755023AbeEaMLF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 08:11:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:63675 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1754986AbeEaMK6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 08:10:58 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,463,1520924400";
   d="scan'208";a="228816294"
Subject: Re: [PATCH V3 00/17] perf tools and x86 PTI entry trampolines
To: Thomas Gleixner <tglx@linutronix.de>,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>, Jiri Olsa <jolsa@redhat.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
References: <1526986485-6562-1-git-send-email-adrian.hunter@intel.com>
From: Adrian Hunter <adrian.hunter@intel.com>
Organization: Intel Finland Oy, Registered Address: PL 281, 00181 Helsinki,
 Business Identity Code: 0357606 - 4, Domiciled in Helsinki
Message-ID: <4017be61-554f-f356-b68d-64981261f8dd@intel.com>
Date: Thu, 31 May 2018 15:09:38 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1526986485-6562-1-git-send-email-adrian.hunter@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/05/18 13:54, Adrian Hunter wrote:
> Hi
> 
> Here is V3 of patches to support x86 PTI entry trampolines in perf tools.
> 
> Patches also here:
> 	http://git.infradead.org/users/ahunter/linux-perf.git/shortlog/refs/heads/perf-tools-kpti-v3
> 	git://git.infradead.org/users/ahunter/linux-perf.git perf-tools-kpti-v3
> 

Arnaldo has queued the tools patches, but there are still 3 kernel patches:

	kallsyms: Simplify update_iter_mod()
	kallsyms, x86: Export addresses of syscall trampolines
	x86: Add entry trampolines to kcore

Are there any further comments on these?  Can they be applied?
