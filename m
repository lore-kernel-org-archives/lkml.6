Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932370AbeCFDPI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 22:15:08 -0500
Received: from mail.windriver.com ([147.11.1.11]:38623 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752756AbeCFDPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 22:15:07 -0500
Subject: Re: [PATCH] tipc: bcast: use true and false for boolean values
To: "Gustavo A. R. Silva" <garsilva@embeddedor.com>,
        Jon Maloy <jon.maloy@ericsson.com>,
        "David S. Miller" <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <tipc-discussion@lists.sourceforge.net>,
        <linux-kernel@vger.kernel.org>
References: <20180305215614.GA15175@embeddedor.com>
From: Ying Xue <ying.xue@windriver.com>
Message-ID: <7dd608de-c048-306a-643c-8a98778eaef3@windriver.com>
Date: Tue, 6 Mar 2018 11:11:21 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180305215614.GA15175@embeddedor.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.224.155.98]
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/06/2018 05:56 AM, Gustavo A. R. Silva wrote:
> Assign true or false to boolean variables instead of an integer value.
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Acked-by: Ying Xue <ying.xue@windriver.com>

> ---
>  net/tipc/bcast.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/tipc/bcast.c b/net/tipc/bcast.c
> index 37892b3..f371117 100644
> --- a/net/tipc/bcast.c
> +++ b/net/tipc/bcast.c
> @@ -574,5 +574,5 @@ void tipc_nlist_purge(struct tipc_nlist *nl)
>  {
>  	tipc_dest_list_purge(&nl->list);
>  	nl->remote = 0;
> -	nl->local = 0;
> +	nl->local = false;
>  }
> 
