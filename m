Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753365AbeDVQS2 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 22 Apr 2018 12:18:28 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44128 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751283AbeDVQS1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Apr 2018 12:18:27 -0400
Date: Sun, 22 Apr 2018 18:18:24 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Sangwon Hong <qpakzk@gmail.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
        linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Taeung Song <treeze.taeung@gmail.com>
Subject: Re: [PATCH] perf mem: Document uncorrect and missing options
Message-ID: <20180422161824.GA2123@krava>
References: <1524382146-19609-1-git-send-email-qpakzk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524382146-19609-1-git-send-email-qpakzk@gmail.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 22, 2018 at 04:29:06PM +0900, Sangwon Hong wrote:

SNIP

>  -C::
> ---cpu-list::
> -	Restrict dump of raw samples to those provided via this option. Note that the same
> -	option can be passed in record mode. It will be interpreted the same way as perf
> -	record.
> +--cpu=<cpu>::
> +	Monitor only on the list of CPUs provided. Multiple CPUs can be provided as a
> +        comma-separated list with no space: 0,1. Ranges of CPUs are specified with -: 0-2. Default
> +        is to monitor all CPUS.
> +-U::
> +--hide-unresolved::
> +	Only display entries resolved to a symbol.
> +
> +-p::
> +--phys-data::
> +	Record/Report sample physical addresses
> +
> +RECORD OPTIONS
> +--------------
> +-e::
> +--event <event>::
> +	Event selector. Use 'perf mem record -e list' to list available events.		

extra white space at the end of above line.. 
other than that it looks ok, thanks for doing this

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
