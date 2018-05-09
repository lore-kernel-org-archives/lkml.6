Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S964853AbeEIRaC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 13:30:02 -0400
Received: from bh-25.webhostbox.net ([208.91.199.152]:55701 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935023AbeEIR36 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 13:29:58 -0400
Date: Wed, 9 May 2018 10:29:55 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-hwmon@vger.kernel.org,
        benh@kernel.crashing.org, paulus@samba.org, jdelvare@suse.com,
        stewart@linux.vnet.ibm.com
Subject: Re: [PATCH 3/3] hwmon: (ibmpowernv) Add energy sensors
Message-ID: <20180509172955.GB20996@roeck-us.net>
References: <1525688738-9185-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
 <1525688738-9185-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525688738-9185-4-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 07, 2018 at 03:55:38PM +0530, Shilpasri G Bhat wrote:
> This patch exports the accumulated power numbers of each power
> sensor maintained by OCC.
> 
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>

Acked-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/hwmon/ibmpowernv.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwmon/ibmpowernv.c b/drivers/hwmon/ibmpowernv.c
> index 74d9b5a..0298745 100644
> --- a/drivers/hwmon/ibmpowernv.c
> +++ b/drivers/hwmon/ibmpowernv.c
> @@ -51,6 +51,7 @@ enum sensors {
>  	POWER_SUPPLY,
>  	POWER_INPUT,
>  	CURRENT,
> +	ENERGY,
>  	MAX_SENSOR_TYPE,
>  };
>  
> @@ -78,6 +79,7 @@ enum sensors {
>  	{ "in"    },
>  	{ "power" },
>  	{ "curr"  },
> +	{ "energy" },
>  };
>  
>  struct sensor_data {
> -- 
> 1.8.3.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-hwmon" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
