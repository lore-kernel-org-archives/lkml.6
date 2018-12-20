Return-Path: <SRS0=2vky=O5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48306C43387
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 033A321720
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Dec 2018 16:56:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=cumulusnetworks.com header.i=@cumulusnetworks.com header.b="UYTxpxuL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732689AbeLTQ4O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Dec 2018 11:56:14 -0500
Received: from mail-ed1-f41.google.com ([209.85.208.41]:45153 "EHLO
        mail-ed1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729722AbeLTQ4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Dec 2018 11:56:13 -0500
Received: by mail-ed1-f41.google.com with SMTP id d39so2305501edb.12
        for <linux-kernel@vger.kernel.org>; Thu, 20 Dec 2018 08:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cumulusnetworks.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DVr6MGctpu9yauzkVa8+kfqvb2kYqRr/TVyHWiOIj+E=;
        b=UYTxpxuLspR6tqYz0tQ2nKeNP5cDQq2Bks0wMh2Idv8K5Y/VwyudZStk98HqI9A81F
         OZ8ZKn6iXb8KAHf6O9+iH3WKAY+o1eOfVCUFbE8M5io0HYufLEGQIOgsZxERQaEY2RE2
         TDBN85H7DyEgVHdSteaCmgPX/eikUPLNYXR30=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DVr6MGctpu9yauzkVa8+kfqvb2kYqRr/TVyHWiOIj+E=;
        b=Mf/RtQNcDsB1lqagpP840yM8InDWbnYsXH993m7gdBzn01xM9/Or3e1TbedLbEtuIc
         AqhYZb7YH9+CLWuKUrpcLrcECv13ZqFEs0zjrBYHzqGWwbFg57NZEDx0mp+gjloPxHcy
         ikHWhS4WJKgOpiCYqaOVQyqTNLe2F2p/lKtjCe2KaA4qO9vGgHBE0gQMuToXUB2FXDIn
         GuBGz7oQKs5aFn77r6dhbZ8TOdPeZOBpwyJmHsdfBpMkneUi2dEP91y4ZJLIBqLc4u9i
         nbw9bOtRuwNMVGIWMApwCMqWLDLnfpXIPHjubg/FFxsVLiL5Zp6PtuyHC2hHei1W7/g9
         9R+A==
X-Gm-Message-State: AA+aEWa347V8+6S9uSJqaz7eJx4rpVq3zzLg/7W7nY3GtBaPy8dd7Afx
        gaCRHHZpcGVkAZoa7FgxTKGuwp/SSXOn4+P4mcRB0g==
X-Google-Smtp-Source: AFSGD/XPelwKlUZS2I/mDVujunF9iebbxxIcLMsLfayKCMq+i+SuOvJGggw1k+qvoesBDGaJbeFd8yrGLKB2JVeNl8o=
X-Received: by 2002:a17:906:6c14:: with SMTP id j20-v6mr20266936ejr.41.1545324971862;
 Thu, 20 Dec 2018 08:56:11 -0800 (PST)
MIME-Version: 1.0
References: <20181220165050.17429-1-colin.king@canonical.com>
In-Reply-To: <20181220165050.17429-1-colin.king@canonical.com>
From:   Roopa Prabhu <roopa@cumulusnetworks.com>
Date:   Thu, 20 Dec 2018 08:56:01 -0800
Message-ID: <CAJieiUj6mDAjEgmy5wLWFO0Fpi+NOMvw08sB4Tk0maMJjeU7FA@mail.gmail.com>
Subject: Re: [PATCH][next] neighbour: remove stray semicolon
To:     Colin King <colin.king@canonical.com>
Cc:     "David S . Miller" <davem@davemloft.net>,
        David Ahern <dsahern@gmail.com>,
        netdev <netdev@vger.kernel.org>, kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 20, 2018 at 8:50 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently the stray semicolon means that the final term in the addition
> is being missed.  Fix this by removing it. Cleans up clang warning:
>
> net/core/neighbour.c:2821:9: warning: expression result unused [-Wunused-value]
>
> Fixes: 82cbb5c631a0 ("neighbour: register rtnl doit handler")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Acked-By: Roopa Prabhu <roopa@cumulusnetworks.com>

Thanks!.


> ---
>  net/core/neighbour.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/core/neighbour.c b/net/core/neighbour.c
> index 43687c9abe1d..1c4b7814ac32 100644
> --- a/net/core/neighbour.c
> +++ b/net/core/neighbour.c
> @@ -2817,7 +2817,7 @@ static int neigh_get_reply(struct net *net, struct neighbour *neigh,
>  static inline size_t pneigh_nlmsg_size(void)
>  {
>         return NLMSG_ALIGN(sizeof(struct ndmsg))
> -              + nla_total_size(MAX_ADDR_LEN); /* NDA_DST */
> +              + nla_total_size(MAX_ADDR_LEN) /* NDA_DST */
>                + nla_total_size(1); /* NDA_PROTOCOL */
>  }
>
> --
> 2.19.1
>
