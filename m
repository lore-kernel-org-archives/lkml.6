Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752168AbeEQK74 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 06:59:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:40002 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751356AbeEQK7y (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 06:59:54 -0400
Date: Thu, 17 May 2018 16:29:49 +0530
From: Vinod <vkoul@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: agross@codeaurora.org, dmaengine@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] dmaengine: qcom: bam_dma: fix some doc warnings.
Message-ID: <20180517105949.GA2932@vkoul-mobl>
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
> Building kernel with W=1 throws up below warnings:
> bam_dma.c:459: warning: Function parameter or member 'dir'
> 	not described in 'bam_chan_init_hw'
> bam_dma.c:697: warning: Function parameter or member 'chan'
> 	not described in 'bam_dma_terminate_all'
> bam_dma.c:697: warning: Excess function parameter 'bchan'
> 	description in 'bam_dma_terminate_all'
> bam_dma.c:964: warning: Function parameter or member 'bchan'
> 	not described in 'bam_start_dma'
> 
> Fix these!.

Applied both, thanks

-- 
~Vinod
