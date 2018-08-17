Return-Path: <SRS0=dgVt=LA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C924C4321D
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:19:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C877020845
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Aug 2018 16:19:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C877020845
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727760AbeHQTXd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Aug 2018 15:23:33 -0400
Received: from mail.linuxfoundation.org ([140.211.169.12]:51320 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727398AbeHQTXd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Aug 2018 15:23:33 -0400
Received: from localhost (unknown [194.244.16.108])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 77A04AD8;
        Fri, 17 Aug 2018 16:19:34 +0000 (UTC)
Date:   Fri, 17 Aug 2018 18:19:31 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bhaskar Singh <bhaskar.kernel@gmail.com>
Cc:     mark.rutland@arm.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org
Subject: Re: [PATCH] kernel: Add spaces around '=' operator
Message-ID: <20180817161931.GC24945@kroah.com>
References: <20180817132348.GA5326@Gentoo-PC>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180817132348.GA5326@Gentoo-PC>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 17, 2018 at 06:53:48PM +0530, Bhaskar Singh wrote:
> This patch fixes the checkpatch.pl ERROR:
> 
> ERROR: spaces required around that '==' (ctx:VxV)
> 
> Signed-off-by: Bhaskar Singh <bhaskar.kernel@gmail.com>
> ---
>  kernel/acct.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/acct.c b/kernel/acct.c
> index addf7732fb56..6dc0a55b575c 100644
> --- a/kernel/acct.c
> +++ b/kernel/acct.c
> @@ -449,7 +449,7 @@ static void fill_ac(acct_t *ac)
>  #endif
>  	do_div(elapsed, AHZ);
>  	ac->ac_btime = get_seconds() - elapsed;
> -#if ACCT_VERSION==2
> +#if ACCT_VERSION == 2

checkpatch is a guide, not a fast rule, and might not matter here.

Please stick to checkpatch fixes in drivers/staging/ only, not any other
part of the kernel unless you know the maintainer accepts such patches.

thanks,

greg k-h
