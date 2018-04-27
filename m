Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757461AbeD0GT1 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 02:19:27 -0400
Received: from mga12.intel.com ([192.55.52.136]:49959 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752108AbeD0GT0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 02:19:26 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,334,1520924400";
   d="scan'208";a="36561800"
Date: Fri, 27 Apr 2018 11:54:06 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: Baolin Wang <baolin.wang@linaro.org>
Cc: dan.j.williams@intel.com, eric.long@spreadtrum.com, broonie@kernel.org,
        dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/5] dmaengine: sprd: Add Spreadtrum DMA configuration
Message-ID: <20180427062405.GY6014@localhost>
References: <2ec1e8ddade0be5b4412b031b98d0d69a1af421f.1524054807.git.baolin.wang@linaro.org>
 <30ff22774f045db654d5e784716c3ee69e00775d.1524054807.git.baolin.wang@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30ff22774f045db654d5e784716c3ee69e00775d.1524054807.git.baolin.wang@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 10:00:49AM +0800, Baolin Wang wrote:

> +/*
> + * struct sprd_dma_config - DMA configuration structure
> + * @src_addr: the physical address where DMA slave data should be read
> + * @dst_addr: the physical address where DMA slave data should be written
> + * @fragment_len: specify one fragment transfer length
> + * @block_len: specify one block transfer length
> + * @transcation_len: specify one transcation transfer length
> + * @src_step: source transfer step
> + * @dst_step: destination transfer step
> + * @src_datawidth: source transfer data width
> + * @dst_datawidth: destination transfer data width
> + * @wrap_ptr: wrap pointer address, once the transfer address reaches the
> + * 'wrap_ptr', the next transfer address will jump to the 'wrap_to' address.
> + * @wrap_to: wrap jump to address
> + * @req_mode: specify the DMA request mode
> + * @int_mode: specify the DMA interrupt type
> + * @slave_id: slave channel requester id
> + */
> +struct sprd_dma_config {

can you please not duplicate the dma_slave_config here. If you want to save
your own values then please embed dma_slave_config here
-- 
~Vinod
