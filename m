Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754830AbeE2HYH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 29 May 2018 03:24:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:39066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750831AbeE2HYF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 May 2018 03:24:05 -0400
Date: Tue, 29 May 2018 12:54:01 +0530
From: Vinod <vkoul@kernel.org>
To: Robert Jarzmik <robert.jarzmik@free.fr>
Cc: Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Vinod Koul <vinod.koul@intel.com>,
        linux-arm-kernel@lists.infradead.org, dmaengine@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RESEND PATCH] dmaengine: pxa: add a default requestor policy
Message-ID: <20180529072401.GG5666@vkoul-mobl>
References: <20180526095418.22960-1-robert.jarzmik@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180526095418.22960-1-robert.jarzmik@free.fr>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26-05-18, 11:54, Robert Jarzmik wrote:
> @@ -762,6 +762,8 @@ static void pxad_free_chan_resources(struct dma_chan *dchan)
>  	dma_pool_destroy(chan->desc_pool);
>  	chan->desc_pool = NULL;
>  
> +	chan->drcmr = (u32)-1;

why not use U32_MAX for this?

-- 
~Vinod
