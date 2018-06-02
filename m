Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751638AbeFBOhK (ORCPT <rfc822;w@1wt.eu>);
        Sat, 2 Jun 2018 10:37:10 -0400
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41193 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750871AbeFBOhI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Jun 2018 10:37:08 -0400
X-Google-Smtp-Source: ADUXVKJrqbFs6knuN+SY2b9sJYwuTM2iJ8VpYio94t5duB6LV+PJ9EIvMRdoVok9QQ84tClG/14YYg==
From: Janusz Krzysztofik <jmkrzyszt@gmail.com>
To: Vinod Koul <vkoul@kernel.org>
Cc: dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Ujfalusi <peter.ujfalusi@ti.com>,
        Jarkko Nikula <jarkko.nikula@bitmer.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        Aaro Koskinen <aaro.koskinen@iki.fi>, Tony Lindgren <tony@atomide.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] DMA: OMAP: fix OMAP1510 incorrect residue_granularity
Date: Sat, 02 Jun 2018 16:37:22 +0200
Message-ID: <5702664.ZErQ22uL87@z50>
In-Reply-To: <20180602142204.17460-1-jmkrzyszt@gmail.com>
References: <20180602142204.17460-1-jmkrzyszt@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday, June 2, 2018 4:22:04 PM CEST Janusz Krzysztofik wrote:
> - by passing dma_caps.residue_granularity =
>   DMA_RESIDUE_GRANULARITY_DESCRIPTOR from drivers/dma/omap-dma.c.
> 
> Let's do the latter.
> 
> Created and tested against next-20180531 tag from linux-next tree.

I'm sorry, I missed 'git bisect reset' before testing the patch, it seems 
drivers/dma/omap-dma.c disappeared from next-20180531. I'll rework it and send 
again.

Thanks,
Janusz
