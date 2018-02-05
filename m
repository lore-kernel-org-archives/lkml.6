Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753190AbeBEPEN (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:04:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:52614 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753227AbeBEPDz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:03:55 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DD59217AB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=acme@kernel.org
Date: Mon, 5 Feb 2018 12:03:51 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Sangwon Hong <qpakzk@gmail.com>
Cc: linux-kernel@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Taeung Song <treeze.taeung@gmail.com>
Subject: Re: [PATCH] perf data: Document missing --force option
Message-ID: <20180205150351.GA25353@kernel.org>
References: <1517831653-32187-1-git-send-email-qpakzk@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1517831653-32187-1-git-send-email-qpakzk@gmail.com>
X-Url: http://acmel.wordpress.com
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Feb 05, 2018 at 08:54:13PM +0900, Sangwon Hong escreveu:
> Add --force option on the man page

Applied.

- Arnaldo
 
> Cc: Jiri Olsa <jolsa@kernel.org>
> Cc: Namhyung Kim <namhyung@kernel.org>
> Cc: Taeung Song <treeze.taeung@gmail.com>
> Signed-off-by: Sangwon Hong <qpakzk@gmail.com>
> ---
>  tools/perf/Documentation/perf-data.txt | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/tools/perf/Documentation/perf-data.txt b/tools/perf/Documentation/perf-data.txt
> index f0796a4..90bb4aa 100644
> --- a/tools/perf/Documentation/perf-data.txt
> +++ b/tools/perf/Documentation/perf-data.txt
> @@ -30,6 +30,10 @@ OPTIONS for 'convert'
>  -i::
>  	Specify input perf data file path.
>  
> +-f::
> +--force::
> +	Don't complain, do it.
> +
>  -v::
>  --verbose::
>          Be more verbose (show counter open errors, etc).
> -- 
> 2.7.4
