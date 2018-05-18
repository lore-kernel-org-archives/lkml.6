Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752346AbeERRne (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 13:43:34 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:48036 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751768AbeERRna (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 13:43:30 -0400
Date: Fri, 18 May 2018 13:43:28 -0400 (EDT)
Message-Id: <20180518.134328.1416789269338865823.davem@davemloft.net>
To: colin.king@canonical.com
Cc: jcliburn@gmail.com, chris.snook@gmail.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/atheros: fix spelling mistake: "Ddescription" ->
 "Description"
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180518092206.21635-1-colin.king@canonical.com>
References: <20180518092206.21635-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Fri, 18 May 2018 10:22:06 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistakes in name field text
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/net/ethernet/atheros/atl1e/atl1e_param.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/atheros/atl1e/atl1e_param.c b/drivers/net/ethernet/atheros/atl1e/atl1e_param.c
> index fa314282c9ad..6a375f4bd054 100644
> --- a/drivers/net/ethernet/atheros/atl1e/atl1e_param.c
> +++ b/drivers/net/ethernet/atheros/atl1e/atl1e_param.c
> @@ -192,7 +192,7 @@ void atl1e_check_options(struct atl1e_adapter *adapter)
>  	{ 		/* Transmit Ring Size */
>  		struct atl1e_option opt = {
>  			.type = range_option,
> -			.name = "Transmit Ddescription Count",
> +			.name = "Transmit Description Count",

In this context, "Descriptor" would be the most appropriate word.

Thank you.
