Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeEROd5 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 10:33:57 -0400
Received: from mail-yb0-f194.google.com ([209.85.213.194]:41695 "EHLO
        mail-yb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751581AbeEROdy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 10:33:54 -0400
X-Google-Smtp-Source: AB8JxZq2PfZLaWEmvUjdgfEjKLm1Cl3EeavAE1hrGSJlJWbw1RKY6gJDbHE0taBvpGtxjpC4jrnZGw==
From: Jes Sorensen <jes.sorensen@gmail.com>
X-Google-Original-From: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: Re: [PATCH] hippi: fix spelling mistake: "Framming" -> "Framing"
To: Colin King <colin.king@canonical.com>,
        "David S . Miller" <davem@davemloft.net>, netdev@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180518100922.28790-1-colin.king@canonical.com>
Message-ID: <bdb779e6-1705-3607-7ad8-3b57dfcba31a@gmail.com>
Date: Fri, 18 May 2018 10:33:50 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180518100922.28790-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/18/2018 06:09 AM, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in printk message text
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/hippi/rrunner.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/hippi/rrunner.c b/drivers/net/hippi/rrunner.c
> index 1ab97d99b9ba..f41116488079 100644
> --- a/drivers/net/hippi/rrunner.c
> +++ b/drivers/net/hippi/rrunner.c
> @@ -867,7 +867,7 @@ static u32 rr_handle_event(struct net_device *dev, u32 prodidx, u32 eidx)
>  			       dev->name);
>  			goto drop;
>  		case E_FRM_ERR:
> -			printk(KERN_WARNING "%s: Framming Error\n",
> +			printk(KERN_WARNING "%s: Framing Error\n",
>  			       dev->name);
>  			goto drop;
>  		case E_FLG_SYN_ERR:
> 

Fine with me! I do wonder if it's time to retire this driver and the
HIPPI code. I haven't had access to hardware for over a decade so I have
no idea if it even works anymore.

Jes
