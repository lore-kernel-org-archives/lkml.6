Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751032AbeE2EqB (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 00:46:01 -0400
Received: from mail-pl0-f67.google.com ([209.85.160.67]:46344 "EHLO
        mail-pl0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750747AbeE2Ep7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 00:45:59 -0400
X-Google-Smtp-Source: AB8JxZpPh8xrEkF/7AP4QX9S2DoHuMUIKdIiHSRnvKQS/EJtFkuFibSRSYcJCFb/Nh6TjvCBhkRBdQ==
Date: Tue, 29 May 2018 10:15:56 +0530
From: Vinod Koul <vinod.koul@linaro.org>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: dan.j.williams@intel.com, eric.long@spreadtrum.com, broonie@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V4 1/2] dmaengine: sprd: Optimize the
 sprd_dma_prep_dma_memcpy()
Message-ID: <20180529044556.GC5666@vkoul-mobl>
References: <08819489e52add194fecf2b4b234fff9deecdb4c.1527065569.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <08819489e52add194fecf2b4b234fff9deecdb4c.1527065569.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-05-18, 17:31, Baolin Wang wrote:
> From: Eric Long <eric.long@spreadtrum.com>
> 
> This is one preparation patch, we can use default DMA configuration to
> implement the device_prep_dma_memcpy() interface instead of issuing
> sprd_dma_config().
> 
> We will implement one new sprd_dma_config() function with introducing
> device_prep_slave_sg() interface in following patch. So we can remove
> the obsolete sprd_dma_config() firstly.

Applied both, thanks

-- 
~Vinod
