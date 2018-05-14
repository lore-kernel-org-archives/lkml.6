Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752067AbeENGpz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 02:45:55 -0400
Received: from fllnx209.ext.ti.com ([198.47.19.16]:15131 "EHLO
        fllnx209.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751533AbeENGpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 02:45:53 -0400
Subject: Re: [PATCH -next] ASoC: omap: add sdma-pcm.c MODULE_LICENSE
To: Randy Dunlap <rdunlap@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>, <linux-omap@vger.kernel.org>,
        moderated for non-subscribers <alsa-devel@alsa-project.org>
CC: Andrew Morton <akpm@linux-foundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
References: <2bf2991a-da55-00a4-bc39-a0ee61bad4d0@infradead.org>
From: Peter Ujfalusi <peter.ujfalusi@ti.com>
Message-ID: <05c6b697-c2ca-85f2-afd6-d234bc9c1560@ti.com>
Date: Mon, 14 May 2018 09:45:52 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2bf2991a-da55-00a4-bc39-a0ee61bad4d0@infradead.org>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2018-05-13 04:41, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> ASoC: omap: add sdma-pcm.c MODULE_LICENSE
> 
> Fixes this build warning:
> 
> WARNING: modpost: missing MODULE_LICENSE() in sound/soc/omap/snd-soc-sdma.o

I have already submitted a fix:
http://mailman.alsa-project.org/pipermail/alsa-devel/2018-May/135940.html

> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Cc: Peter Ujfalusi <peter.ujfalusi@ti.com>
> Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>
> Cc: Liam Girdwood <lgirdwood@gmail.com>
> Cc: Mark Brown <broonie@kernel.org>
> ---
>  sound/soc/omap/sdma-pcm.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> --- linux-next-20180510.orig/sound/soc/omap/sdma-pcm.c
> +++ linux-next-20180510/sound/soc/omap/sdma-pcm.c
> @@ -9,6 +9,7 @@
>  #include <sound/pcm_params.h>
>  #include <sound/soc.h>
>  #include <sound/dmaengine_pcm.h>
> +#include <linux/module.h>
>  #include <linux/omap-dma.h>
>  
>  #include "sdma-pcm.h"
> @@ -66,3 +67,5 @@ int sdma_pcm_platform_register(struct de
>  	return devm_snd_dmaengine_pcm_register(dev, config, flags);
>  }
>  EXPORT_SYMBOL_GPL(sdma_pcm_platform_register);
> +
> +MODULE_LICENSE("GPL v2");
> 

- Péter

Texas Instruments Finland Oy, Porkkalankatu 22, 00180 Helsinki.
Y-tunnus/Business ID: 0615521-4. Kotipaikka/Domicile: Helsinki
