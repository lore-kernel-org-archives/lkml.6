Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751315AbeFCRMX (ORCPT <rfc822;w@1wt.eu>);
        Sun, 3 Jun 2018 13:12:23 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:42103 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751169AbeFCRMV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jun 2018 13:12:21 -0400
X-Google-Smtp-Source: ADUXVKI5wdoaHV6F9Bic7u9cGmzqh3ifRPg4kqxWO1V49OUDZH+yYFStDUuLwnjUFhRPj6V4QT6Lbg==
Date: Sun, 3 Jun 2018 19:12:16 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Clark Williams <williams@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Adrian Hunter <adrian.hunter@intel.com>, Borislav Petkov <bp@suse.de>,
        David Ahern <dsahern@gmail.com>, Jiri Olsa <jolsa@kernel.org>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, Wang Nan <wangnan0@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: Re: [GIT PULL 0/4] perf/urgent fixes
Message-ID: <20180603171216.GA17473@gmail.com>
References: <20180602145927.23307-1-acme@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180602145927.23307-1-acme@kernel.org>
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
> The following changes since commit 6497bbc35ac5efce3bccd31d3719bae020282da6:
> 
>   Merge tag 'perf-urgent-for-mingo-4.17-20180531' of git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux into perf/urgent (2018-05-31 12:37:07 +0200)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/acme/linux.git tags/perf-urgent-for-mingo-4.17-20180602
> 
> for you to fetch changes up to 0b3a18387f3e5cdcfaaf884860a4688280d09c9d:
> 
>   perf tools intel-pt-decoder: Update insn.h from the kernel sources (2018-06-01 16:13:18 -0300)
> 
> ----------------------------------------------------------------
> perf/urgent fixes:
> 
> - Update prctl and cpufeatures.h tools/ copies with the kernel sources
>   originals, which makes 'perf trace' know about the new prctl options
>   for speculation control and silences the build warnings (Arnaldo Carvalho de Melo)
> 
> - Update insn.h in Intel-PT instruction decoder with its original from from the
>   kernel sources, to silence build warnings, no effect on the actual tools this
>   time around (Arnaldo Carvalho de Melo)
> 
> Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
> 
> ----------------------------------------------------------------
> Arnaldo Carvalho de Melo (4):
>       perf trace beauty prctl: Default header_dir to cwd to work without parms
>       tools headers: Synchronize prctl.h ABI header
>       tools headers: Sync x86 cpufeatures.h with the kernel sources
>       perf tools intel-pt-decoder: Update insn.h from the kernel sources
> 
>  tools/arch/x86/include/asm/cpufeatures.h | 20 ++++++++++++++------
>  tools/include/uapi/linux/prctl.h         | 12 ++++++++++++
>  tools/perf/trace/beauty/prctl_option.sh  |  2 +-
>  tools/perf/util/intel-pt-decoder/insn.h  | 18 ++++++++++++++++++
>  4 files changed, 45 insertions(+), 7 deletions(-)

Pulled, thanks a lot Arnaldo!

	Ingo
