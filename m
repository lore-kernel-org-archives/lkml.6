Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752359AbeDQH5z (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 03:57:55 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43094 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751248AbeDQH5y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 03:57:54 -0400
Date: Tue, 17 Apr 2018 09:57:50 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: mhiramat@kernel.org, acme@redhat.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, pombredanne@nexb.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        uneedsihyeon@gmail.com, kjlx@templeofstupid.com
Subject: Re: [PATCH v2 0/3] perf/buildid-cache: Add --list and --purge-all
 options
Message-ID: <20180417075750.GC2052@krava>
References: <20180417041346.5617-1-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180417041346.5617-1-ravi.bangoria@linux.vnet.ibm.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 17, 2018 at 09:43:43AM +0530, Ravi Bangoria wrote:
> First patch is a trivial error message fix. Second and third
> adds new options --list and --purge-all to 'buildid-cache'
> subcommand.
> 
> v2 changes:
>  - [PATCH v2 2/3] Display optput of 'perf buildid-cache -l' same as
>    'perf buildid-list'.
>  - [PATCH v2 2/3] Other minor changes as suggested by Jiri.

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka

> 
> v1 can be found at:
>   https://lkml.org/lkml/2018/4/9/295
> 
> Ravi Bangoria (3):
>   tools/parse-options: Add '\n' at the end of error messages
>   perf/buildid-cache: Support --list option
>   perf/buildid-cache: Support --purge-all option
> 
>  tools/lib/subcmd/parse-options.c                |  6 +-
>  tools/perf/Documentation/perf-buildid-cache.txt |  7 ++-
>  tools/perf/builtin-buildid-cache.c              | 77 ++++++++++++++++++++++++-
>  3 files changed, 83 insertions(+), 7 deletions(-)
> 
> -- 
> 2.14.3
> 
