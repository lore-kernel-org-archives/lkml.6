Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752089AbeEQKzX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 06:55:23 -0400
Received: from mail.kernel.org ([198.145.29.99]:39062 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751438AbeEQKzW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 06:55:22 -0400
Date: Thu, 17 May 2018 16:25:17 +0530
From: Vinod <vkoul@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: agross@codeaurora.org, dmaengine@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: fix some doc warnings.
Message-ID: <20180517105517.GA13271@vkoul-mobl>
References: <20180517095916.11362-1-srinivas.kandagatla@linaro.org>
 <20180517105049.GZ13271@vkoul-mobl>
 <c3b63215-ed0f-93ee-69df-6b22053f0479@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3b63215-ed0f-93ee-69df-6b22053f0479@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17-05-18, 11:53, Srinivas Kandagatla wrote:
> 
> 
> On 17/05/18 11:50, Vinod Koul wrote:
> > On 17-05-18, 10:59, Srinivas Kandagatla wrote:
> > > diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> > > index 4a828c18099a..a05fff8a1447 100644
> > > --- a/drivers/dma/qcom/bam_dma.c
> > > +++ b/drivers/dma/qcom/bam_dma.c
> > > @@ -451,7 +451,7 @@ static void bam_reset_channel(struct bam_chan *bchan)
> > >   /**
> > >    * bam_chan_init_hw - Initialize channel hardware
> > >    * @bchan: bam channel
> > > - *
> > > + * @dir: DMA transfer direction
> > 
> > Do you want to add an empty line here?
> > 
> TBH, Am not 100% sure it it adds any value.
> 
> Most of the function docs in the file have this same issue.. :-)
> 
> let me know if you still want an empty line, I can respin.

Yeah that's why asked, I can edit while applying so no issues

-- 
~Vinod
