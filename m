Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752387AbeEOGV6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:21:58 -0400
Received: from mail-wr0-f194.google.com ([209.85.128.194]:34156 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752089AbeEOGVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:21:53 -0400
X-Google-Smtp-Source: AB8JxZp6ALzs0w5eEx71Oi3sEcSMAaXMRoK02Z0bpOxBzpoLMUp2axg5s1vm1lheQwRwZ0IvhgzItw==
Date: Tue, 15 May 2018 08:21:48 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, David Ahern <dsahern@gmail.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Hendrik Brueckner <brueckner@linux.vnet.ibm.com>,
        Jin Yao <yao.jin@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>, Leo Yan <leo.yan@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Richter <tmricht@linux.ibm.com>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 0/5] perf/urgent fixes
Message-ID: <20180515062148.GA7581@gmail.com>
References: <20180514122321.27304-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180514122321.27304-1-acme@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
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
> The following changes since commit 49cf4a4b3f5a8b02556dd4f45c5cee598d4fc799:
> 
>   Merge tag 'perf-urgent-for-mingo-4.17-20180507' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2018-05-10 20:09:00 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.17-20180514
> 
> for you to fetch changes up to c23080a6e4e853cff2834436e3cf33eae7723900:
> 
>   perf tools: Add missing newline when parsing empty BPF proggie (2018-05-11 12:10:02 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> - Fix segfault when processing unknown threads in cs-etm (Leo Yan)
> 
> - Fix "perf test inet_pton" on s390 failing due to missing inline (Thomas Richter)
> 
> - Display all available events on 'perf annotate --stdio' (Jin Yao)
> 
> - Add missing newline when parsing empty BPF proggie (Arnaldo Carvalho de Melo)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (1):
>       perf tools: Add missing newline when parsing empty BPF proggie
> 
> Jin Yao (1):
>       perf annotate: Display all available events on --stdio
> 
> Leo Yan (2):
>       perf cs-etm: Support unknown_thread in cs_etm_auxtrace
>       perf cs-etm: Remove redundant space
> 
> Thomas Richter (1):
>       perf test: "probe libc's inet_pton" fails on s390 due to missing inline
> 
>  .../tests/shell/record+probe_libc_inet_pton.sh     |  2 +-
>  tools/perf/util/annotate.c                         |  3 +++
>  tools/perf/util/cs-etm.c                           | 28 ++++++++++++++++++----
>  tools/perf/util/parse-events.c                     |  2 +-
>  4 files changed, 29 insertions(+), 6 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
