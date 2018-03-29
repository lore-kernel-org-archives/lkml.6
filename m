Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752610AbeC2QPa (ORCPT <rfc822;w@1wt.eu>);
        Thu, 29 Mar 2018 12:15:30 -0400
Received: from ale.deltatee.com ([207.54.116.67]:46446 "EHLO ale.deltatee.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752086AbeC2QP3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Mar 2018 12:15:29 -0400
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "james.smart@broadcom.com" <james.smart@broadcom.com>,
        "hch@lst.de" <hch@lst.de>, "sagi@grimberg.me" <sagi@grimberg.me>
References: <20180329160721.4691-1-logang@deltatee.com>
 <20180329160721.4691-4-logang@deltatee.com>
 <a60ddb463159bcc287998ecfafdc2753973a4828.camel@wdc.com>
From: Logan Gunthorpe <logang@deltatee.com>
Message-ID: <bb89dec3-97d9-67a1-f62e-05aac713a13e@deltatee.com>
Date: Thu, 29 Mar 2018 10:15:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <a60ddb463159bcc287998ecfafdc2753973a4828.camel@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: sagi@grimberg.me, hch@lst.de, james.smart@broadcom.com, linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, Bart.VanAssche@wdc.com
X-SA-Exim-Mail-From: logang@deltatee.com
Subject: Re: [PATCH 3/4] nvmet-fc: Don't use the count returned by the
 dma_map_sg call
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 29/03/18 10:14 AM, Bart Van Assche wrote:
> On Thu, 2018-03-29 at 10:07 -0600, Logan Gunthorpe wrote:
>> +	ret = fc_dma_map_sg(fod->tgtport->dev, sg, nent,
>> +			    ((fod->io_dir == NVMET_FCP_WRITE) ?
>> +				    DMA_FROM_DEVICE : DMA_TO_DEVICE));
>> +			    /* note: write from initiator perspective */
> 
> If you have to repost this patch please remove the four superfluous parentheses.

Ok, will do.

Thanks,

Logan
