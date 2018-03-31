Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753028AbeCaIyY (ORCPT <rfc822;w@1wt.eu>);
        Sat, 31 Mar 2018 04:54:24 -0400
Received: from mail.bootlin.com ([62.4.15.54]:50314 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751910AbeCaIyX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Mar 2018 04:54:23 -0400
Date: Sat, 31 Mar 2018 10:54:20 +0200
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Colin King <colin.king@canonical.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ASoC: atmel_ssc_dai: fix spelling mistake: "Stoping" ->
 "Stopping"
Message-ID: <20180331085420.GE14180@piout.net>
References: <20180330154420.6903-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330154420.6903-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/03/2018 at 16:44:20 +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake in pr_debug message text
> 
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  sound/soc/atmel/atmel_ssc_dai.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/sound/soc/atmel/atmel_ssc_dai.c b/sound/soc/atmel/atmel_ssc_dai.c
> index a1e2c5682dcd..1c7af0ca98ec 100644
> --- a/sound/soc/atmel/atmel_ssc_dai.c
> +++ b/sound/soc/atmel/atmel_ssc_dai.c
> @@ -820,7 +820,7 @@ static int atmel_ssc_hw_params(struct snd_pcm_substream *substream,
>  		if (ret < 0) {
>  			printk(KERN_WARNING
>  					"atmel_ssc_dai: request_irq failure\n");
> -			pr_debug("Atmel_ssc_dai: Stoping clock\n");
> +			pr_debug("Atmel_ssc_dai: Stopping clock\n");
>  			clk_disable(ssc_p->ssc->clk);
>  			return ret;
>  		}
> -- 
> 2.15.1
> 

-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
