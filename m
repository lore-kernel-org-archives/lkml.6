Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934185AbeEILQ4 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 07:16:56 -0400
Received: from charlotte.tuxdriver.com ([70.61.120.58]:47857 "EHLO
        smtp.tuxdriver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933832AbeEILQy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 07:16:54 -0400
Date: Wed, 9 May 2018 07:16:02 -0400
From: Neil Horman <nhorman@tuxdriver.com>
To: Colin King <colin.king@canonical.com>
Cc: Vlad Yasevich <vyasevich@gmail.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        "David S . Miller" <davem@davemloft.net>, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sctp: fix spelling mistake: "max_retans" -> "max_retrans"
Message-ID: <20180509111602.GA29443@hmswarspite.think-freely.org>
References: <20180508222428.24874-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180508222428.24874-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-Spam-Score: -2.9 (--)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 08, 2018 at 11:24:28PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in error string
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  net/sctp/sm_make_chunk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/sctp/sm_make_chunk.c b/net/sctp/sm_make_chunk.c
> index 4d7b3ccea078..4a4fd1971255 100644
> --- a/net/sctp/sm_make_chunk.c
> +++ b/net/sctp/sm_make_chunk.c
> @@ -1131,7 +1131,7 @@ struct sctp_chunk *sctp_make_violation_max_retrans(
>  					const struct sctp_association *asoc,
>  					const struct sctp_chunk *chunk)
>  {
> -	static const char error[] = "Association exceeded its max_retans count";
> +	static const char error[] = "Association exceeded its max_retrans count";
>  	size_t payload_len = sizeof(error) + sizeof(struct sctp_errhdr);
>  	struct sctp_chunk *retval;
>  
> -- 
> 2.17.0
> 
> 
Acked-by: Neil Horman <nhorman@tuxdriver.com>
