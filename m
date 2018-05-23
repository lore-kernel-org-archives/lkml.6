Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754760AbeEWQOO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 12:14:14 -0400
Received: from esa6.microchip.iphmx.com ([216.71.154.253]:19263 "EHLO
        esa6.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751646AbeEWQOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 12:14:11 -0400
X-IronPort-AV: E=Sophos;i="5.49,433,1520924400";
   d="scan'208";a="11836529"
Subject: Re: [PATCH] staging: wilc1000: fix spelling mistake: "Preamle" ->
 "Preamble"
To: Colin King <colin.king@canonical.com>,
        Aditya Shankar <aditya.shankar@microchip.com>,
        Ganesh Krishna <ganesh.krishna@microchip.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-wireless@vger.kernel.org>, <devel@driverdev.osuosl.org>
CC: <kernel-janitors@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20180522164905.10874-1-colin.king@canonical.com>
From: Claudiu Beznea <Claudiu.Beznea@microchip.com>
Message-ID: <0168c840-e962-53ce-4b30-705a5c80730c@microchip.com>
Date: Wed, 23 May 2018 19:14:07 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180522164905.10874-1-colin.king@canonical.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22.05.2018 19:49, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in netdev_err error message
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Reviewed-by: Claudiu Beznea <claudiu.beznea@microchip.com>

> ---
>  drivers/staging/wilc1000/host_interface.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/wilc1000/host_interface.c b/drivers/staging/wilc1000/host_interface.c
> index a2f82c885d63..7b613cd72d22 100644
> --- a/drivers/staging/wilc1000/host_interface.c
> +++ b/drivers/staging/wilc1000/host_interface.c
> @@ -577,7 +577,7 @@ static void handle_cfg_param(struct wilc_vif *vif, struct cfg_param_attr *param)
>  			wid_list[i].size = sizeof(char);
>  			hif_drv->cfg_values.preamble_type = preamble_type;
>  		} else {
> -			netdev_err(vif->ndev, "Preamle Range(0~2) over\n");
> +			netdev_err(vif->ndev, "Preamble Range(0~2) over\n");
>  			goto unlock;
>  		}
>  		i++;
> 
