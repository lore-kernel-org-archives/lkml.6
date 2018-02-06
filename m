Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752816AbeBFMZa (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 07:25:30 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:39044 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752324AbeBFMZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 07:25:22 -0500
X-Google-Smtp-Source: AH8x227zDwyMNJgp567aPRA7UePRp+dtn26HB4dEcm1C5oGZPI0ohteJ9F6mzm4kPMDqOqrWAge1+w==
Subject: Re: [PATCH -next] meson-gx-socinfo: make local function
 meson_gx_socinfo_init static
To: Wei Yongjun <weiyongjun1@huawei.com>, Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Arnaud Patard <arnaud.patard@rtp-net.org>
Cc: linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
References: <1515593988-78626-1-git-send-email-weiyongjun1@huawei.com>
From: Neil Armstrong <narmstrong@baylibre.com>
Organization: Baylibre
Message-ID: <3cb83737-bb60-7648-e72e-2d39590c8418@baylibre.com>
Date: Tue, 6 Feb 2018 13:25:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <1515593988-78626-1-git-send-email-weiyongjun1@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/01/2018 15:19, Wei Yongjun wrote:
> Fixes the following sparse warnings:
> 
> drivers/soc/amlogic/meson-gx-socinfo.c:100:12: warning:
>  symbol 'meson_gx_socinfo_init' was not declared. Should it be static?
> 
> Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
> ---
>  drivers/soc/amlogic/meson-gx-socinfo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/amlogic/meson-gx-socinfo.c b/drivers/soc/amlogic/meson-gx-socinfo.c
> index f2d8c3c..ea091f1 100644
> --- a/drivers/soc/amlogic/meson-gx-socinfo.c
> +++ b/drivers/soc/amlogic/meson-gx-socinfo.c
> @@ -97,7 +97,7 @@ static const char *socinfo_to_soc_id(u32 socinfo)
>  	return "Unknown";
>  }
>  
> -int __init meson_gx_socinfo_init(void)
> +static int __init meson_gx_socinfo_init(void)
>  {
>  	struct soc_device_attribute *soc_dev_attr;
>  	struct soc_device *soc_dev;
> 
> 
> 

Acked-by: Neil Armstrong <narmstrong@baylibre.com>
