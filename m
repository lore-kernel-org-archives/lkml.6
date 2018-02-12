Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932419AbeBLBwC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Feb 2018 20:52:02 -0500
Received: from LGEAMRELO13.lge.com ([156.147.23.53]:36405 "EHLO
        lgeamrelo13.lge.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932340AbeBLBwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Feb 2018 20:52:01 -0500
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: namhyung@kernel.org
X-Original-SENDERIP: 10.177.227.17
X-Original-MAILFROM: namhyung@kernel.org
Date: Mon, 12 Feb 2018 10:51:59 +0900
From: Namhyung Kim <namhyung@kernel.org>
To: Sangwon Hong <qpakzk@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Taeung Song <treeze.taeung@gmail.com>, kernel-team@lge.com
Subject: Re: [PATCH 2/2] perf mem: Document a missing option
Message-ID: <20180212015159.GD31513@sejong>
References: <1518381517-30766-1-git-send-email-qpakzk@gmail.com>
 <1518381517-30766-2-git-send-email-qpakzk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1518381517-30766-2-git-send-email-qpakzk@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 12, 2018 at 05:38:37AM +0900, Sangwon Hong wrote:
> Add the missing --force option on the man page.
> 
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Taeung Song <treeze.taeung@gmail.com>
> Signed-off-by: Sangwon Hong <qpakzk@gmail.com>

Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks,
Namhyung


> ---
>  tools/perf/Documentation/perf-mem.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-mem.txt b/tools/perf/Documentation/perf-mem.txt
> index 4be08a1..b021141 100644
> --- a/tools/perf/Documentation/perf-mem.txt
> +++ b/tools/perf/Documentation/perf-mem.txt
> @@ -28,6 +28,10 @@ OPTIONS
>  <command>...::
>  	Any command you can specify in a shell.
>  
> +-f::
> +--force::
> +	Don't do ownership validation
> +
>  -t::
>  --type=::
>  	Select the memory operation type: load or store (default: load,store)
> -- 
> 2.7.4
> 
