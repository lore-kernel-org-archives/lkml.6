Return-Path: <f.fainelli@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524264688; cv=none;
        d=google.com; s=arc-20160816;
        b=nFgvsvweoTc+34CKhzfI8CDrNLFFqAe3ajyMKijPlahSk1gNVxWozIVj5/Gk5GCrZd
         2BiOgWrmYytJzcYgcI2wUnSi1v3VytoLYAksNTzRVuNSuggY4UV4vjgLWUua9ZaV32/L
         F9BaUhq0/UmmfqM87OGZXTJmBlB6kNmilWaV08cu/m8uzkrRK1bAN61cDFqBVZc/pRF0
         MtHLMGnotdqx/Abxi2mDqdKaPr3jpgJB82eQv8VT6kXMQlSe+IKjMNOm1FWNS2Ll4gZw
         hMuFw1hYdv5os7lZtj1iSQEV43TDEn002c9dSo8ejHbukGykMZ63PaKOzp0y9l+C1gf3
         fAnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:autocrypt:openpgp:from:references:cc:to
         :subject:dkim-signature:arc-authentication-results;
        bh=35o9di8S5zWUmDY8dj/xDgMD1QcG3gkwuWeoTI80AqQ=;
        b=yI3XLQNnre5o3Vs+406ZN2tYMTIzljNq5dzD6hKUxgeO1ooVPV4CK2jf4f+ehOBoDu
         9ybXLqj2NVNNI44n6AdYvOd8wbtGuqSlbjqDoaKGcl2Pf7Z+vRf+7MSCdxxDD20CZwjN
         GMxeokKyCwHDqxD3QIoxYYWkERwrJ45tBJse0apWmIG2vEzs3atZkoJOyOXmqkIH9L1k
         rMblOhPJ9hQl8/FUyd5BGOaTZTuIcs5BbXr0YebIkt5ULZJWgg07Pq5iAOv5ImBlmmrG
         9GcUYQ5/d0F/2yEv+Q0uM27rXEUQIEsoD3uerDx5ojB1TK5Domu+8bwKCxZRgJcQu+lt
         Homw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=aSt4bL1T;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=aSt4bL1T;
       spf=pass (google.com: domain of f.fainelli@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=f.fainelli@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZor5D0iBIqI+8jBGCYU3kSL93bKb6Rk3LZ32nJsT/V5/9WohknmqlnIyUaknURUQJXNRYJhHQ==
Subject: Re: [PATCH v3 0/7] MIPS: perf: MT fixes and improvements
To: Matt Redfearn <matt.redfearn@mips.com>, James Hogan <jhogan@kernel.org>,
 Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org, Peter Zijlstra <peterz@infradead.org>,
 oprofile-list@lists.sf.net, Huacai Chen <chenhc@lemote.com>,
 linux-kernel@vger.kernel.org, Paul Burton <paul.burton@mips.com>,
 Robert Richter <rric@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
 Kate Stewart <kstewart@linuxfoundation.org>, Ingo Molnar <mingo@redhat.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Maciej W. Rozycki" <macro@mips.com>, Namhyung Kim <namhyung@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>
References: <1524219789-31241-1-git-send-email-matt.redfearn@mips.com>
From: Florian Fainelli <f.fainelli@gmail.com>
Openpgp: preference=signencrypt
Autocrypt: addr=f.fainelli@gmail.com; prefer-encrypt=mutual; keydata=
 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
 HGuUuzv+GKZ6nsysJw==
Message-ID: <c3ee1ba4-3458-33a7-4c1f-700936a57bfa@gmail.com>
Date: Fri, 20 Apr 2018 15:51:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <1524219789-31241-1-git-send-email-matt.redfearn@mips.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598260332468885189?=
X-GMAIL-MSGID: =?utf-8?q?1598307369744886147?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/20/2018 03:23 AM, Matt Redfearn wrote:
> This series addresses a few issues with how the MIPS performance
> counters code supports the hardware multithreading MT ASE.
> 
> Firstly, implementations of the MT ASE may implement performance
> counters
> per core or per thread(TC). MIPS Techologies implementations signal this
> via a bit in the implmentation specific CONFIG7 register. Since this
> register is implementation specific, checking it should be guarded by a
> PRID check. This also replaces a bit defined by a magic number.
> 
> Secondly, the code currently uses vpe_id(), defined as
> smp_processor_id(), divided by 2, to share core performance counters
> between VPEs. This relies on a couple of assumptions of the hardware
> implementation to function correctly (always 2 VPEs per core, and the
> hardware reading only the least significant bit).
> 
> Finally, the method of sharing core performance counters between VPEs is
> suboptimal since it does not allow one process running on a VPE to use
> all of the performance counters available to it, because the kernel will
> reserve half of the coutners for the other VPE even if it may never use
> them. This reservation at counter probe is replaced with an allocation
> on use strategy.
> 
> Tested on a MIPS Creator CI40 (2C2T MIPS InterAptiv with per-TC
> counters, though for the purposes of testing the per-TC availability was
> hardcoded to allow testing both paths).
> 
> Series applies to v4.16

Sorry it took so long to get that tested.

Sounds like you need to build test this on a BMIPS5000 configuration
(bmips_stb_defconfig should provide that):

In file included from ./arch/mips/include/asm/mach-generic/spaces.h:15:0,
                 from ./arch/mips/include/asm/mach-bmips/spaces.h:16,
                 from ./arch/mips/include/asm/addrspace.h:13,
                 from ./arch/mips/include/asm/barrier.h:11,
                 from ./include/linux/compiler.h:245,
                 from ./include/linux/kernel.h:10,
                 from ./include/linux/cpumask.h:10,
                 from arch/mips/kernel/perf_event_mipsxx.c:18:
arch/mips/kernel/perf_event_mipsxx.c: In function 'mipsxx_pmu_enable_event':
./arch/mips/include/asm/mipsregs.h:738:52: error: suggest parentheses
around '+' in operand of '&' [-Werror=parentheses]
 #define BRCM_PERFCTRL_VPEID(v) (_ULCAST_(1) << (12 + v))

arch/mips/kernel/perf_event_mipsxx.c:385:10: note: in expansion of macro
'BRCM_PERFCTRL_VPEID'
   ctrl = BRCM_PERFCTRL_VPEID(cpu & MIPS_CPUID_TO_COUNTER_MASK);
          ^~~~~~~~~~~~~~~~~~~
  CC      drivers/of/fdt_addres

after fixing that, I tried the following to see whether this would be a
good test case to exercise against:

perf record -a -C 0 taskset -c 1 /bin/true
perf record -a -C 1 taskset -c 0 /bin/true

and would not see anything related to /bin/true running in either case,
which seems like it does the right thing?

Tested-by: Florian Fainelli <f.fainelli@gmail.com>

BTW, for some reason not specifying -a -C <cpu> does lead to lockups,
consistently and for pretty much any perf command, this could be BMIPS
specific, did not get a chance to cross test on a different machine.

> 
> 
> Changes in v3:
> New patch to detect feature presence in cpu-probe.c
> Use flag in cpu_data set by cpu_probe.c to indicate feature presence.
> - rebase on new feature detection
> 
> Changes in v2:
> Fix mipsxx_pmu_enable_event for !#ifdef CONFIG_MIPS_MT_SMP
> - Fix !#ifdef CONFIG_MIPS_PERF_SHARED_TC_COUNTERS build
> - re-use cpuc variable in mipsxx_pmu_alloc_counter,
>   mipsxx_pmu_free_counter rather than having sibling_ version.
> Since BMIPS5000 does not implement per TC counters, we can remove the
> check on cpu_has_mipsmt_pertccounters.
> New patch to fix BMIPS5000 system mode perf.
> 
> Matt Redfearn (7):
>   MIPS: Probe for MIPS MT perf counters per TC
>   MIPS: perf: More robustly probe for the presence of per-tc counters
>   MIPS: perf: Use correct VPE ID when setting up VPE tracing
>   MIPS: perf: Fix perf with MT counting other threads
>   MIPS: perf: Allocate per-core counters on demand
>   MIPS: perf: Fold vpe_id() macro into it's one last usage
>   MIPS: perf: Fix BMIPS5000 system mode counting
> 
>  arch/mips/include/asm/cpu-features.h |   7 ++
>  arch/mips/include/asm/cpu.h          |   2 +
>  arch/mips/include/asm/mipsregs.h     |   6 +
>  arch/mips/kernel/cpu-probe.c         |  12 ++
>  arch/mips/kernel/perf_event_mipsxx.c | 232 +++++++++++++++++++----------------
>  arch/mips/oprofile/op_model_mipsxx.c |   2 -
>  6 files changed, 150 insertions(+), 111 deletions(-)
> 


-- 
Florian
