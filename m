Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752689AbeEOUmV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 16:42:21 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:42741 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752510AbeEOUmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 16:42:18 -0400
X-Google-Smtp-Source: AB8JxZreyd3HCJ3gS3KyJkl3Rshkyw0z64FicQ99ycbY2DkIjJdrobxz8de7f+eqOOwUxJmowu3BdQ==
Subject: Re: [PATCH][next] scripts/dtc: fix spelling mistake: "endpont" ->
 "endpoint"
To: Colin King <colin.king@canonical.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20180515090209.9165-1-colin.king@canonical.com>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <ff9f1b12-6d29-d247-81e6-92b10faac0d1@gmail.com>
Date: Tue, 15 May 2018 13:42:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180515090209.9165-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Colin,

On 05/15/18 02:02, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in FAIL message.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  scripts/dtc/checks.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
> index a2cc1036c915..9d253819e12c 100644
> --- a/scripts/dtc/checks.c
> +++ b/scripts/dtc/checks.c
> @@ -1536,7 +1536,7 @@ static void check_graph_endpoint(struct check *c, struct dt_info *dti,
>  		return;
>  
>  	if (!strprefixeq(node->name, node->basenamelen, "endpoint"))
> -		FAIL(c, dti, node, "graph endpont node name should be 'endpoint'");
> +		FAIL(c, dti, node, "graph endpoint node name should be 'endpoint'");
>  
>  	check_graph_reg(c, dti, node);
>  
> 

Thanks for catching this.

We import this file from the upstream dtc project.  Please send this same exact patch
to:

   David Gibson <david@gibson.dropbear.id.au>
   devicetree-compiler@vger.kernel.org

Thanks,

Frank
