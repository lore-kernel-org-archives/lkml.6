Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966864AbeEJSKQ (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 14:10:16 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45030 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S966722AbeEJSKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 14:10:14 -0400
X-Google-Smtp-Source: AB8JxZqkxAg2I9vn07X0qFyJeE+O4uvRqy4lhYiW9hqY3GZYMqGe8AtcR2lq/VH8jBEuCfCeDxAt7w==
Date: Thu, 10 May 2018 20:10:09 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        KarimAllah Ahmed <karahmed@amazon.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Wang Nan <wangnan0@huawei.com>, William Cohen <wcohen@redhat.com>,
        Yisheng Xie <xieyisheng1@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 0/6] perf/urgent fixes
Message-ID: <20180510181009.fayjnnt5swpb75ym@gmail.com>
References: <20180507201333.26990-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180507201333.26990-1-acme@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Arnaldo Carvalho de Melo <acme@kernel.org> wrote:

> Hi Ingo,
> 
> 	Please consider pulling,
> 
> - Arnaldo
> 
> Test results at the end of this message, as usual.
> 
> The following changes since commit 1504269814263c9676b4605a6a91e14dc6ceac21:
> 
>   Merge tag 'linux-kselftest-4.17-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/shuah/linux-kselftest (2018-05-03 19:26:51 -1000)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git perf-urgent-for-mingo-4.17-20180507
> 
> for you to fetch changes up to 4a35a9027f64d588d2fd9436dda4126e8d5647d7:
> 
>   Revert "perf pmu: Fix pmu events parsing rule" (2018-05-07 16:28:10 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> . Revert "perf pmu: Fix pmu events parsing rule", as it broke Intel PT
>   event description parsing (Arnaldo Carvalho de Melo)
> 
> . Sync x86's cpufeatures.h and kvm UAPI headers with the kernel sources,
>   suppressing the ABI drift warnings (Arnaldo Carvalho de Melo)
> 
> - Remove duplicated entry for westmereep-dp in Intel's mapfile.csv (William Cohen)
> 
> - Fix typo in 'perf bench numa' options description (Yisheng Xie)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (4):
>       tools headers: Sync x86 cpufeatures.h with the kernel sources
>       tools headers kvm: Sync uapi/linux/kvm.h with the kernel sources
>       tools headers kvm: Sync ARM UAPI headers with the kernel sources
>       Revert "perf pmu: Fix pmu events parsing rule"
> 
> William Cohen (1):
>       perf vendor events intel: Remove duplicated entry for westmereep-dp in mapfile.csv
> 
> Yisheng Xie (1):
>       perf bench numa: Fix typo in options
> 
>  tools/arch/arm/include/uapi/asm/kvm.h      | 6 ++++++
>  tools/arch/arm64/include/uapi/asm/kvm.h    | 6 ++++++
>  tools/arch/x86/include/asm/cpufeatures.h   | 1 +
>  tools/include/uapi/linux/kvm.h             | 7 +++++++
>  tools/perf/bench/numa.c                    | 2 +-
>  tools/perf/pmu-events/arch/x86/mapfile.csv | 1 -
>  tools/perf/util/parse-events.y             | 8 ++++----
>  7 files changed, 25 insertions(+), 6 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
