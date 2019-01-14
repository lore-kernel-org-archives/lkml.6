Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D1B9C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C527420645
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 18:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726824AbfANSpJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 13:45:09 -0500
Received: from proxima.lasnet.de ([78.47.171.185]:43482 "EHLO
        proxima.lasnet.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726741AbfANSpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 13:45:08 -0500
Received: from localhost.localdomain (p200300E9D70DB1A9F35C53A5883DC5AE.dip0.t-ipconnect.de [IPv6:2003:e9:d70d:b1a9:f35c:53a5:883d:c5ae])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: stefan@datenfreihafen.org)
        by proxima.lasnet.de (Postfix) with ESMTPSA id 4862FC8C28;
        Mon, 14 Jan 2019 19:45:05 +0100 (CET)
Subject: Re: [PATCH] ieee802154: mcr20a: fix indentation, remove tabs
To:     Colin King <colin.king@canonical.com>,
        Xue Liu <liuxuenetmail@gmail.com>,
        Alexander Aring <alex.aring@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-wpan@vger.kernel.org, netdev@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20190114154834.18693-1-colin.king@canonical.com>
From:   Stefan Schmidt <stefan@datenfreihafen.org>
Message-ID: <497c64f0-c242-8ef1-b57b-5d4c8f2557f8@datenfreihafen.org>
Date:   Mon, 14 Jan 2019 19:45:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20190114154834.18693-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On 14.01.19 16:48, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> The are a couple of statments that are one level too deep, fix this by
> removing tabs.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ieee802154/mcr20a.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/ieee802154/mcr20a.c b/drivers/net/ieee802154/mcr20a.c
> index 44de81e5f140..c589f5ae75bb 100644
> --- a/drivers/net/ieee802154/mcr20a.c
> +++ b/drivers/net/ieee802154/mcr20a.c
> @@ -905,9 +905,9 @@ mcr20a_irq_clean_complete(void *context)
>  		}
>  		break;
>  	case (DAR_IRQSTS1_RXIRQ | DAR_IRQSTS1_SEQIRQ):
> -			/* rx is starting */
> -			dev_dbg(printdev(lp), "RX is starting\n");
> -			mcr20a_handle_rx(lp);
> +		/* rx is starting */
> +		dev_dbg(printdev(lp), "RX is starting\n");
> +		mcr20a_handle_rx(lp);
>  		break;
>  	case (DAR_IRQSTS1_RXIRQ | DAR_IRQSTS1_TXIRQ | DAR_IRQSTS1_SEQIRQ):
>  		if (lp->is_tx) {
> 


This patch has been applied to the wpan tree and will be
part of the next pull request to net. Thanks!

regards
Stefan Schmidt
