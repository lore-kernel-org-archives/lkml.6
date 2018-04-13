Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753118AbeDMGtB (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 02:49:01 -0400
Received: from mga04.intel.com ([192.55.52.120]:8093 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750761AbeDMGs7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 02:48:59 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,444,1517904000";
   d="scan'208";a="46588386"
Message-ID: <1523602136.2753.240.camel@gmail.com>
Subject: Re: [PATCH][v4] tools/power turbostat: if --iterations, print for
 specific time of iterations
From: Artem Bityutskiy <dedekind1@gmail.com>
Reply-To: dedekind1@gmail.com
To: Yu Chen <yu.c.chen@intel.com>, Len Brown <lenb@kernel.org>
Cc: Rafael J Wysocki <rjw@rjwysocki.net>,
        Doug Smythies <dsmythies@telus.net>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date: Fri, 13 Apr 2018 09:48:56 +0300
In-Reply-To: <20180413034047.1240-1-yu.c.chen@intel.com>
References: <20180413034047.1240-1-yu.c.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.26.6 (3.26.6-1.fc27) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2018-04-13 at 11:40 +0800, Yu Chen wrote:
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index bd9c6b31a504..a2fe96f038f0 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -48,6 +48,7 @@ char *proc_stat = "/proc/stat";
>  FILE *outf;
>  int *fd_percpu;
>  struct timespec interval_ts = {5, 0};
> +int iterations;
>  unsigned int debug;
>  unsigned int quiet;
>  unsigned int sums_need_wide_columns;
> @@ -470,6 +471,7 @@ void help(void)
>  	"		{core | package | j,k,l..m,n-p }\n"
>  	"--quiet	skip decoding system configuration header\n"
>  	"--interval sec	Override default 5-second measurement interval\n"
> +	"--iterations count	Number of measurement iterations(requires '--interval'\n"

Missing white-space and ")".

-- 
Best Regards,
Artem Bityutskiy
