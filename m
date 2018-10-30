Return-Path: <SRS0=BpFy=NK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 869BBC2BC61
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2F6F02075D
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Oct 2018 14:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQw9cKEa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F6F02075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727020AbeJ3Xic (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Oct 2018 19:38:32 -0400
Received: from mail.kernel.org ([198.145.29.99]:51390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726788AbeJ3Xic (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Oct 2018 19:38:32 -0400
Received: from jouet.infradead.org (unknown [190.15.121.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B6DF2075D;
        Tue, 30 Oct 2018 14:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1540910687;
        bh=lQ2WFlBUk8ToD4ocHvwD4QguLo5kbZqm20ikgYlKe6c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IQw9cKEaOO1mVmstpBLveqxFSJbNy03p1342hc38OawVJLPk2S/HmiuLXow6PTBTr
         HRJ1y1MgWL4PmxgtLI7gRUS3BVC1id/bneuYebx6TE5ZuL8RkBzD0PE+381wUAZbWU
         v/ANSKRf0Cdud7l6ZQ70enuIcgNmNrk6W+CEz2+w=
Received: by jouet.infradead.org (Postfix, from userid 1000)
        id 78C93142C5F; Tue, 30 Oct 2018 11:44:44 -0300 (-03)
Date:   Tue, 30 Oct 2018 11:44:44 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Colin King <colin.king@canonical.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf/core: clean up inconsisent indentation
Message-ID: <20181030144444.GB23310@kernel.org>
References: <20181029233211.21475-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181029233211.21475-1-colin.king@canonical.com>
X-Url:  http://acmel.wordpress.com
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Oct 29, 2018 at 11:32:11PM +0000, Colin King escreveu:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Replace a bunch of spaces with tab, cleans up indentation

I think we can live with the spaces as the 'git blame' information is
more valuable, i.e. who was that touched that line last?

Thanks,

- Arnaldo
 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  kernel/events/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/events/core.c b/kernel/events/core.c
> index 8c490130c4fb..84530ab358c3 100644
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -750,7 +750,7 @@ static inline void update_cgrp_time_from_event(struct perf_event *event)
>  	/*
>  	 * Do not update time when cgroup is not active
>  	 */
> -       if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup))
> +	if (cgroup_is_descendant(cgrp->css.cgroup, event->cgrp->css.cgroup))
>  		__update_cgrp_time(event->cgrp);
>  }
>  
> -- 
> 2.19.1
