Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752191AbeEQKu5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 06:50:57 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:40327 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751715AbeEQKux (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 06:50:53 -0400
X-Google-Smtp-Source: AB8JxZrwsrO8pV/8gIDeLu5ocrUfBc+bR9RZUR24YHsr3BLK42OjsVHcTFW+F1ccZkANFhTiJqnydw==
Date: Thu, 17 May 2018 16:20:49 +0530
From: Vinod Koul <vinod.koul@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: agross@codeaurora.org, dmaengine@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: fix some doc warnings.
Message-ID: <20180517105049.GZ13271@vkoul-mobl>
References: <20180517095916.11362-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180517095916.11362-1-srinivas.kandagatla@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-05-18, 10:59, Srinivas Kandagatla wrote:
> diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> index 4a828c18099a..a05fff8a1447 100644
> --- a/drivers/dma/qcom/bam_dma.c
> +++ b/drivers/dma/qcom/bam_dma.c
> @@ -451,7 +451,7 @@ static void bam_reset_channel(struct bam_chan *bchan)
>  /**
>   * bam_chan_init_hw - Initialize channel hardware
>   * @bchan: bam channel
> - *
> + * @dir: DMA transfer direction

Do you want to add an empty line here?

>   * This function resets and initializes the BAM channel
-- 
~Vinod
