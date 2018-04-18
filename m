Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752719AbeDRFyg (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 01:54:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:50182 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750718AbeDRFyf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 01:54:35 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7734421727
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=mhiramat@kernel.org
Date: Wed, 18 Apr 2018 14:54:32 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: jolsa@redhat.com, acme@redhat.com, kstewart@linuxfoundation.org,
        tglx@linutronix.de, pombredanne@nexb.com, linux-kernel@vger.kernel.org,
        peterz@infradead.org, mingo@redhat.com,
        alexander.shishkin@linux.intel.com, namhyung@kernel.org,
        uneedsihyeon@gmail.com, kjlx@templeofstupid.com
Subject: Re: [PATCH v2 0/3] perf/buildid-cache: Add --list and --purge-all
 options
Message-Id: <20180418145432.c6b12acf050d9f2d8ff05dc6@kernel.org>
In-Reply-To: <20180417041346.5617-1-ravi.bangoria@linux.vnet.ibm.com>
References: <20180417041346.5617-1-ravi.bangoria@linux.vnet.ibm.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 17 Apr 2018 09:43:43 +0530
Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com> wrote:

> First patch is a trivial error message fix. Second and third
> adds new options --list and --purge-all to 'buildid-cache'
> subcommand.
> 
> v2 changes:
>  - [PATCH v2 2/3] Display optput of 'perf buildid-cache -l' same as
>    'perf buildid-list'.
>  - [PATCH v2 2/3] Other minor changes as suggested by Jiri.
> 
> v1 can be found at:
>   https://lkml.org/lkml/2018/4/9/295

All patches in this series looks good to me.

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>

Thanks,

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


-- 
Masami Hiramatsu <mhiramat@kernel.org>
