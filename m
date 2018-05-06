Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752383AbeEFWuz (ORCPT <rfc822;w@1wt.eu>);
        Sun, 6 May 2018 18:50:55 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:46147 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752368AbeEFWut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 May 2018 18:50:49 -0400
X-Google-Smtp-Source: AB8JxZpkNDfRhLEJpF3HNnIpUV5uS3K56D96sWGJ6Lkdg2C0u3Z4cnPvgMY9UPKqxhjQ7nDM4Q0KLQ==
Date: Sun, 6 May 2018 15:50:45 -0700
From: Eduardo Valentin <edubezval@gmail.com>
To: srplinux2008 <srplinux2008@gmail.com>
Cc: thierry.reding@gmail.com, jonathanh@nvidia.com,
        linux-tegra@vger.kernel.org, rui.zhang@intel.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH] thermal: tegra: soctherm: add const to struct
 thermal_cooling_device_ops
Message-ID: <20180506225044.GA25956@localhost.localdomain>
References: <1523188905-3066-1-git-send-email-srplinux2008@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523188905-3066-1-git-send-email-srplinux2008@gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 08, 2018 at 05:31:45PM +0530, srplinux2008 wrote:
> From: srp linux <srplinux2008@gmail.com>
> 
> Correct the typecast with const to struct thermal_cooling_device_ops.
> It is the last argument to the function thermal_of_cooling_device_register
> and this argument is of type const. So, declare this structure
> thermal_cooling_device_ops as constant.
> 
> Signed-off-by: srp linux <srplinux2008@gmail.com>

Please resend with your real name.

Thanks

> ---
>  drivers/thermal/tegra/soctherm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/tegra/soctherm.c b/drivers/thermal/tegra/soctherm.c
> index 455b58c..72da745 100644
> --- a/drivers/thermal/tegra/soctherm.c
> +++ b/drivers/thermal/tegra/soctherm.c
> @@ -926,7 +926,7 @@ static int throt_set_cdev_state(struct thermal_cooling_device *cdev,
>  	return 0;
>  }
>  
> -static struct thermal_cooling_device_ops throt_cooling_ops = {
> +static const struct thermal_cooling_device_ops throt_cooling_ops = {
>  	.get_max_state = throt_get_cdev_max_state,
>  	.get_cur_state = throt_get_cdev_cur_state,
>  	.set_cur_state = throt_set_cdev_state,
> -- 
> 2.7.4
> 
