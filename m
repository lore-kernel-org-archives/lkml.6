Return-Path: <SRS0=A5md=P6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F6DC282C3
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:23:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12B2621019
	for <linux-kernel@archiver.kernel.org>; Tue, 22 Jan 2019 10:23:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727902AbfAVKXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 22 Jan 2019 05:23:48 -0500
Received: from mail.kernel.org ([198.145.29.99]:59394 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727469AbfAVKXr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Jan 2019 05:23:47 -0500
Received: from localhost (5356596B.cm-6-7b.dynamic.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AB6CD2084A;
        Tue, 22 Jan 2019 10:23:46 +0000 (UTC)
Date:   Tue, 22 Jan 2019 11:23:44 +0100
From:   Greg KH <greg@kroah.com>
To:     Adam Borowski <kilobyte@angband.pl>
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] doc: process: GPL -> GPL-compatible
Message-ID: <20190122102344.GA31836@kroah.com>
References: <20190122093408.16756-1-kilobyte@angband.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190122093408.16756-1-kilobyte@angband.pl>
User-Agent: Mutt/1.11.2 (2019-01-07)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 22, 2019 at 10:34:08AM +0100, Adam Borowski wrote:
> Drivers under MIT, BSD-17-clause, or uncle-Bob's-newest-take-on-PD are
> all fine, not just GPL.
> 
> Signed-off-by: Adam Borowski <kilobyte@angband.pl>
> ---
> Not reformatting to fill lines, it'll semi-conflict with another patch
> that's been acked but not yet pushed.
> 
>  Documentation/process/stable-api-nonsense.rst | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/process/stable-api-nonsense.rst b/Documentation/process/stable-api-nonsense.rst
> index 24f5aeecee91..9b69fb08b65e 100644
> --- a/Documentation/process/stable-api-nonsense.rst
> +++ b/Documentation/process/stable-api-nonsense.rst
> @@ -170,7 +170,8 @@ nightmare, and trying to keep up with an ever changing kernel interface
>  is also a rough job.
>  
>  Simple, get your kernel driver into the main kernel tree (remember we
> -are talking about GPL released drivers here, if your code doesn't fall
> +are talking about drivers released under a GPL-compatible license here,
> +if your code doesn't fall
>  under this category, good luck, you are on your own here, you leech
>  <insert link to leech comment from Andrew and Linus here>.)  If your
>  driver is in the tree, and a kernel interface changes, it will be fixed

Nice fix:

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
