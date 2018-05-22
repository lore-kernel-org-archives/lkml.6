Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751359AbeEVIhV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 04:37:21 -0400
Received: from mail-pl0-f66.google.com ([209.85.160.66]:35195 "EHLO
        mail-pl0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751114AbeEVIhR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 04:37:17 -0400
X-Google-Smtp-Source: AB8JxZr1Tg+CdIhuYB1AdRqcPDV6QQBIw4TZg2W7phzbTBy9iKaGSo57xVeFFgDz76UiB3NwjZyj+Q==
Date: Tue, 22 May 2018 14:07:14 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Colin King <colin.king@canonical.com>
Cc: Vaibhav Agarwal <vaibhav.sr@gmail.com>,
        Mark Greer <mgreer@animalcreek.com>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [greybus-dev] [PATCH] staging: greybus: fix spelling mistake:
 "Inavlid" -> "Invalid"
Message-ID: <20180522083714.z4gtlfd7adr353fg@vireshk-i7>
References: <20180522083342.5722-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522083342.5722-1-colin.king@canonical.com>
User-Agent: NeoMutt/20180323-120-3dd1ac
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-05-18, 09:33, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in dev_err error message
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  drivers/staging/greybus/audio_topology.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/greybus/audio_topology.c b/drivers/staging/greybus/audio_topology.c
> index de4b1b2b12f3..15e57f701630 100644
> --- a/drivers/staging/greybus/audio_topology.c
> +++ b/drivers/staging/greybus/audio_topology.c
> @@ -996,7 +996,7 @@ static int gbaudio_tplg_create_widget(struct gbaudio_module_info *module,
>  
>  	ret = gbaudio_validate_kcontrol_count(w);
>  	if (ret) {
> -		dev_err(module->dev, "Inavlid kcontrol count=%d for %s\n",
> +		dev_err(module->dev, "Invalid kcontrol count=%d for %s\n",
>  			w->ncontrols, w->name);
>  		return ret;
>  	}

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
