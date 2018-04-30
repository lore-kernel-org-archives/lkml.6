Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752485AbeD3ISF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 04:18:05 -0400
Received: from mail-ot0-f171.google.com ([74.125.82.171]:37913 "EHLO
        mail-ot0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751906AbeD3ISD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 04:18:03 -0400
X-Google-Smtp-Source: AB8JxZod+6Qp4/f936q38rkysFSXTl3EtHkxi0s1Apja+jVW3eN33hHmniJWpp9p0bjIYxMTB14z7+Q92/AtS1m6Ic8=
MIME-Version: 1.0
In-Reply-To: <20180427062405.GY6014@localhost>
References: <2ec1e8ddade0be5b4412b031b98d0d69a1af421f.1524054807.git.baolin.wang@linaro.org>
 <30ff22774f045db654d5e784716c3ee69e00775d.1524054807.git.baolin.wang@linaro.org>
 <20180427062405.GY6014@localhost>
From: Baolin Wang <baolin.wang@linaro.org>
Date: Mon, 30 Apr 2018 16:18:02 +0800
Message-ID: <CAMz4ku+=NtjqTvxXy6mefGgZROX3D13vuvcrByhd=KzG=vQ+fA@mail.gmail.com>
Subject: Re: [PATCH v2 4/5] dmaengine: sprd: Add Spreadtrum DMA configuration
To: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <dan.j.williams@intel.com>,
        Eric Long <eric.long@spreadtrum.com>, Mark Brown <broonie@kernel.org>,
        dmaengine@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On 27 April 2018 at 14:24, Vinod Koul <vinod.koul@intel.com> wrote:
> On Thu, Apr 19, 2018 at 10:00:49AM +0800, Baolin Wang wrote:
>
>> +/*
>> + * struct sprd_dma_config - DMA configuration structure
>> + * @src_addr: the physical address where DMA slave data should be read
>> + * @dst_addr: the physical address where DMA slave data should be written
>> + * @fragment_len: specify one fragment transfer length
>> + * @block_len: specify one block transfer length
>> + * @transcation_len: specify one transcation transfer length
>> + * @src_step: source transfer step
>> + * @dst_step: destination transfer step
>> + * @src_datawidth: source transfer data width
>> + * @dst_datawidth: destination transfer data width
>> + * @wrap_ptr: wrap pointer address, once the transfer address reaches the
>> + * 'wrap_ptr', the next transfer address will jump to the 'wrap_to' address.
>> + * @wrap_to: wrap jump to address
>> + * @req_mode: specify the DMA request mode
>> + * @int_mode: specify the DMA interrupt type
>> + * @slave_id: slave channel requester id
>> + */
>> +struct sprd_dma_config {
>
> can you please not duplicate the dma_slave_config here. If you want to save
> your own values then please embed dma_slave_config here

Thanks for your suggestion. Will fix this in next version.

-- 
Baolin.wang
Best Regards
