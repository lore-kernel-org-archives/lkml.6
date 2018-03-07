Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754153AbeCGN0f (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 08:26:35 -0500
Received: from mail.kernel.org ([198.145.29.99]:57150 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933402AbeCGN03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 08:26:29 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21DC92172D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Wed, 7 Mar 2018 10:26:24 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Takashi Iwai <tiwai@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf: doc: Correct title markers for asciidoctor
Message-ID: <20180307132624.GB3701@kernel.org>
References: <20180307105441.28512-1-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180307105441.28512-1-tiwai@suse.de>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Mar 07, 2018 at 11:54:41AM +0100, Takashi Iwai escreveu:
> I've tested to process the perf man pages with asciidoctor that is
> picker than asciidoc, and it revealed minor syntax errors in some
> documents.  Namely, the title markers aren't aligned with the previous
> line, hence asciidoctor didn't recognize as titles.
> 
> This patch corrects these markers to be processed properly.

Thanks, applying.

- Arnaldo
 
> Signed-off-by: Takashi Iwai <tiwai@suse.de>
> ---
>  tools/perf/Documentation/perf-data.txt        | 2 +-
>  tools/perf/Documentation/perf-ftrace.txt      | 2 +-
>  tools/perf/Documentation/perf-kallsyms.txt    | 2 +-
>  tools/perf/Documentation/perf-sched.txt       | 2 +-
>  tools/perf/Documentation/perf-script-perl.txt | 2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/tools/perf/Documentation/perf-data.txt b/tools/perf/Documentation/perf-data.txt
> index 90bb4aabe4f8..c87180764829 100644
> --- a/tools/perf/Documentation/perf-data.txt
> +++ b/tools/perf/Documentation/perf-data.txt
> @@ -1,5 +1,5 @@
>  perf-data(1)
> -==============
> +============
>  
>  NAME
>  ----
> diff --git a/tools/perf/Documentation/perf-ftrace.txt b/tools/perf/Documentation/perf-ftrace.txt
> index 721a447f046e..b80c84307dc9 100644
> --- a/tools/perf/Documentation/perf-ftrace.txt
> +++ b/tools/perf/Documentation/perf-ftrace.txt
> @@ -1,5 +1,5 @@
>  perf-ftrace(1)
> -=============
> +==============
>  
>  NAME
>  ----
> diff --git a/tools/perf/Documentation/perf-kallsyms.txt b/tools/perf/Documentation/perf-kallsyms.txt
> index 954ea9e21236..cdd421cd1c57 100644
> --- a/tools/perf/Documentation/perf-kallsyms.txt
> +++ b/tools/perf/Documentation/perf-kallsyms.txt
> @@ -1,5 +1,5 @@
>  perf-kallsyms(1)
> -==============
> +================
>  
>  NAME
>  ----
> diff --git a/tools/perf/Documentation/perf-sched.txt b/tools/perf/Documentation/perf-sched.txt
> index c7e50f263887..bb33601a823b 100644
> --- a/tools/perf/Documentation/perf-sched.txt
> +++ b/tools/perf/Documentation/perf-sched.txt
> @@ -1,5 +1,5 @@
>  perf-sched(1)
> -==============
> +=============
>  
>  NAME
>  ----
> diff --git a/tools/perf/Documentation/perf-script-perl.txt b/tools/perf/Documentation/perf-script-perl.txt
> index 142606c0ec9c..5a1f68122f50 100644
> --- a/tools/perf/Documentation/perf-script-perl.txt
> +++ b/tools/perf/Documentation/perf-script-perl.txt
> @@ -1,5 +1,5 @@
>  perf-script-perl(1)
> -==================
> +===================
>  
>  NAME
>  ----
> -- 
> 2.16.2
