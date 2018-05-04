Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751294AbeEDNqX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 09:46:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:34252 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751114AbeEDNqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 09:46:22 -0400
Date: Fri, 4 May 2018 10:45:34 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: William Cohen <wcohen@redhat.com>
Cc: peterz@infradead.org, mingo@redhat.com, linux-kernel@vger.kernel.org,
        alexander.shishkin@linux.intel.com, jolsa@redhat.com,
        namhyung@kernel.org
Subject: Re: [PATCH] Remove duplicated entry for westmereep-dp in mapfile.csv
Message-ID: <20180504134534.GA11458@kernel.org>
References: <20180503195032.28871-1-wcohen@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180503195032.28871-1-wcohen@redhat.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Thu, May 03, 2018 at 03:50:32PM -0400, William Cohen escreveu:
> Signed-off-by: William Cohen <wcohen@redhat.com>
> ---
>  tools/perf/pmu-events/arch/x86/mapfile.csv | 1 -
>  1 file changed, 1 deletion(-)

Thanks, applied.

- Arnaldo
 
> diff --git a/tools/perf/pmu-events/arch/x86/mapfile.csv b/tools/perf/pmu-events/arch/x86/mapfile.csv
> index 93656f2fd53a..7e3cce3bcf3b 100644
> --- a/tools/perf/pmu-events/arch/x86/mapfile.csv
> +++ b/tools/perf/pmu-events/arch/x86/mapfile.csv
> @@ -29,7 +29,6 @@ GenuineIntel-6-4D,v13,silvermont,core
>  GenuineIntel-6-4C,v13,silvermont,core
>  GenuineIntel-6-2A,v15,sandybridge,core
>  GenuineIntel-6-2C,v2,westmereep-dp,core
> -GenuineIntel-6-2C,v2,westmereep-dp,core
>  GenuineIntel-6-25,v2,westmereep-sp,core
>  GenuineIntel-6-2F,v2,westmereex,core
>  GenuineIntel-6-55,v1,skylakex,core
> -- 
> 2.14.3
