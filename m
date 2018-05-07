Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752230AbeEGKqX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 06:46:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7658 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751378AbeEGKqW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 06:46:22 -0400
Subject: Re: [PATCH] perf bench numa: Fixes typo in options
To: <acme@kernel.org>, Arnaldo Carvalho de Melo <acme@redhat.com>
References: <1524644707-11030-1-git-send-email-xieyisheng1@huawei.com>
CC: <jolsa@redhat.com>, <mingo@redhat.com>, <peterz@infradead.org>,
        <linux-kernel@vger.kernel.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <d333c15b-e0cd-4d6e-cbf5-17bbdfc55ccd@huawei.com>
Date: Mon, 7 May 2018 18:45:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <1524644707-11030-1-git-send-email-xieyisheng1@huawei.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaldo,

Just in case that you may miss this minor fix.

Thanks
Yisheng

On 2018/4/25 16:25, Yisheng Xie wrote:
> 'R' means access the data via reads instead of writes, fix this typo.
> 
> Signed-off-by: Yisheng Xie <xieyisheng1@huawei.com>
> ---
>  tools/perf/bench/numa.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/bench/numa.c b/tools/perf/bench/numa.c
> index 944070e..63eb4908 100644
> --- a/tools/perf/bench/numa.c
> +++ b/tools/perf/bench/numa.c
> @@ -175,7 +175,7 @@ struct global_info {
>  	OPT_UINTEGER('s', "nr_secs"	, &p0.nr_secs,		"max number of seconds to run (default: 5 secs)"),
>  	OPT_UINTEGER('u', "usleep"	, &p0.sleep_usecs,	"usecs to sleep per loop iteration"),
>  
> -	OPT_BOOLEAN('R', "data_reads"	, &p0.data_reads,	"access the data via writes (can be mixed with -W)"),
> +	OPT_BOOLEAN('R', "data_reads"	, &p0.data_reads,	"access the data via reads (can be mixed with -W)"),
>  	OPT_BOOLEAN('W', "data_writes"	, &p0.data_writes,	"access the data via writes (can be mixed with -R)"),
>  	OPT_BOOLEAN('B', "data_backwards", &p0.data_backwards,	"access the data backwards as well"),
>  	OPT_BOOLEAN('Z', "data_zero_memset", &p0.data_zero_memset,"access the data via glibc bzero only"),
> 
