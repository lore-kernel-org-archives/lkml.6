Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752605AbeEVRSi (ORCPT <rfc822;w@1wt.eu>);
        Tue, 22 May 2018 13:18:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:34958 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752550AbeEVRSf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 May 2018 13:18:35 -0400
Date: Tue, 22 May 2018 18:18:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Colin King <colin.king@canonical.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: adc: fix spelling mistake: "Freeacale" ->
 "Freescale"
Message-ID: <20180522181829.1073346d@archlinux>
In-Reply-To: <20180521091654.17989-1-colin.king@canonical.com>
References: <20180521091654.17989-1-colin.king@canonical.com>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 May 2018 10:16:54 +0100
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in module description text
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Applied to the togreg branch of iio.git.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/imx7d_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/imx7d_adc.c b/drivers/iio/adc/imx7d_adc.c
> index cfab31162845..ad6764fb2a23 100644
> --- a/drivers/iio/adc/imx7d_adc.c
> +++ b/drivers/iio/adc/imx7d_adc.c
> @@ -604,5 +604,5 @@ static struct platform_driver imx7d_adc_driver = {
>  module_platform_driver(imx7d_adc_driver);
>  
>  MODULE_AUTHOR("Haibo Chen <haibo.chen@freescale.com>");
> -MODULE_DESCRIPTION("Freeacale IMX7D ADC driver");
> +MODULE_DESCRIPTION("Freescale IMX7D ADC driver");
>  MODULE_LICENSE("GPL v2");
