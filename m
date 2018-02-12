Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932377AbeBLBuY (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 20:50:24 -0500
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:36163 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753771AbeBLBuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 20:50:23 -0500
X-Original-SENDERIP: 156.147.1.151
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Mon, 12 Feb 2018 10:50:21 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Sangwon Hong <qpakzk@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Taeung Song <treeze.taeung@gmail.com>, kernel-team@lge.com
Subject: Re: [PATCH] perf kallsyms: Fix the usage on the man page
Message-ID: <20180212015021.GB31513@sejong>
References: <1518377864-20353-1-git-send-email-qpakzk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1518377864-20353-1-git-send-email-qpakzk@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 04:37:44AM +0900, Sangwon Hong wrote:
> First, all man pages highlight only perf and subcommands except perf
> kallsyms, which includes the full usage. Fix it for commands to monopolize
> underlines.
> 
> Second, options can skip when executing perf kallsyms, so add square
> brackets between <option>.
> 
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Taeung Song <treeze.taeung@gmail.com>
> Signed-off-by: Sangwon Hong <qpakzk@gmail.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/Documentation/perf-kallsyms.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/perf/Documentation/perf-kallsyms.txt b/tools/perf/Documentation/perf-kallsyms.txt
> index 954ea9e..cf9f404 100644
> --- a/tools/perf/Documentation/perf-kallsyms.txt
> +++ b/tools/perf/Documentation/perf-kallsyms.txt
> @@ -8,7 +8,7 @@ perf-kallsyms - Searches running kernel for symbols
>  SYNOPSIS
>  --------
>  [verse]
> -'perf kallsyms <options> symbol_name[,symbol_name...]'
> +'perf kallsyms' [<options>] symbol_name[,symbol_name...]
>  
>  DESCRIPTION
>  -----------
> -- 
> 2.7.4
> 
