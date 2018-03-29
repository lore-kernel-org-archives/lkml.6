Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752531AbeC2Qee (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:34:34 -0400
Received: from mail-qt0-f171.google.com ([209.85.216.171]:36507 "EHLO
        mail-qt0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751859AbeC2Qed (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:34:33 -0400
X-Google-Smtp-Source: AIpwx4/JcbVg9iVVr2/Q9rKN7Kjq0uBkrVrtBwOk33AHyQFQDmtcBOk9WssqvqywFiQ/GZD2P5EvOA==
Subject: Re: [PATCH 3/4] nvmet-fc: Don't use the count returned by the
 dma_map_sg call
To: Logan Gunthorpe <logang@deltatee.com>, linux-kernel@vger.kernel.org,
        linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
References: <20180329160721.4691-1-logang@deltatee.com>
 <20180329160721.4691-4-logang@deltatee.com>
 <03cb3610-8ec7-9dc4-9e0a-82f4c30de578@broadcom.com>
 <5ba62675-39b4-6409-5628-c59d8ae048de@deltatee.com>
From: James Smart <james.smart@broadcom.com>
Message-ID: <5a5ab779-c949-8caa-abff-88063e885cd5@broadcom.com>
Date: Thu, 29 Mar 2018 09:34:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <5ba62675-39b4-6409-5628-c59d8ae048de@deltatee.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/2018 9:30 AM, Logan Gunthorpe wrote:
> Can you elaborate? The 'data_sg_cnt' member was in 'struct
> nvmet_fc_fcp_iod' which is declared in fc.c so it doesn't seem sane for
> lower driver to access it... In fact the next patch in the series
> removes it completely.
>
> Logan

actually, I do think it's ok. about to post review on the next patch

-- james
