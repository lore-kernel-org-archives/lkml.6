Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751333AbeDCNpr (ORCPT <rfc822;w@1wt.eu>);
        Tue, 3 Apr 2018 09:45:47 -0400
Received: from eddie.linux-mips.org ([148.251.95.138]:35390 "EHLO
        cvs.linux-mips.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750748AbeDCNpn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Apr 2018 09:45:43 -0400
Date: Tue, 3 Apr 2018 15:45:40 +0200
From: Ladislav Michl <ladis@linux-mips.org>
To: Colin King <colin.king@canonical.com>
Cc: Nicolas Ferre <nicolas.ferre@microchip.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [alsa-devel] [PATCH] ASoC: atmel_ssc_dai: fix spelling mistake:
 "Stoping" -> "Stopping"
Message-ID: <20180403134540.GA29017@lenoch>
References: <20180330154420.6903-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180330154420.6903-1-colin.king@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 30, 2018 at 04:44:20PM +0100, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>

Hello Colin,

> Trivial fix to spelling mistake in pr_debug message text

would you mind making this patch a bit less non-trivial and
change pr_debug to dev_dbg dropping Atmel_ssc_dai prefix?

Thank you.

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
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
