Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752078AbeENU3h (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 16:29:37 -0400
Received: from 72-48-214-68.dyn.grandenetworks.net ([72.48.214.68]:39020 "EHLO
        smtp.opengridcomputing.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751962AbeENU3f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 16:29:35 -0400
Subject: Re: linux-next: build warning after merge of the rdma tree
From: Steve Wise <swise@opengridcomputing.com>
To: Jason Gunthorpe <jgg@mellanox.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Doug Ledford <dledford@redhat.com>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20180507094454.4a71f8a2@canb.auug.org.au>
 <20180514180326.GM21517@mellanox.com>
 <2c3cedda-da0c-8a7a-e950-7d32c02af95f@opengridcomputing.com>
Openpgp: preference=signencrypt
Autocrypt: addr=swise@opengridcomputing.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <ce892196-8690-7ec6-4727-efb3f03d311e@opengridcomputing.com>
Date: Mon, 14 May 2018 15:29:37 -0500
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <2c3cedda-da0c-8a7a-e950-7d32c02af95f@opengridcomputing.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/14/2018 1:09 PM, Steve Wise wrote:
>
> On 5/14/2018 1:03 PM, Jason Gunthorpe wrote:
>> On Mon, May 07, 2018 at 09:44:54AM +1000, Stephen Rothwell wrote:
>>> Hi all,
>>>
>>> After merging the rdma tree, today's linux-next build (x86_64
>>> allmodconfig) produced this warning:
>>>
>>> drivers/infiniband/hw/cxgb4/restrack.c: In function 'fill_res_qp_entry':
>>> drivers/infiniband/hw/cxgb4/restrack.c:140:6: warning: 'last_rq_idx' may be used uninitialized in this function [-Wmaybe-uninitialized]
>>>   if (rdma_nl_put_driver_u32(msg, "idx", idx))
>>>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/infiniband/hw/cxgb4/restrack.c:180:20: note: 'last_rq_idx' was declared here
>>>   u16 first_rq_idx, last_rq_idx;
>>>                     ^~~~~~~~~~~
>>> drivers/infiniband/hw/cxgb4/restrack.c:140:6: warning: 'first_rq_idx' may be used uninitialized in this function [-Wmaybe-uninitialized]
>>>   if (rdma_nl_put_driver_u32(msg, "idx", idx))
>>>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/infiniband/hw/cxgb4/restrack.c:180:6: note: 'first_rq_idx' was declared here
>>>   u16 first_rq_idx, last_rq_idx;
>>>       ^~~~~~~~~~~~
>>> drivers/infiniband/hw/cxgb4/restrack.c:228:6: warning: 'last_sq_idx' may be used uninitialized in this function [-Wmaybe-uninitialized]
>>>   if (fill_swsqes(msg, &wq.sq, first_sq_idx, fsp, last_sq_idx, lsp))
>>>       ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>> drivers/infiniband/hw/cxgb4/restrack.c:228:6: warning: 'first_sq_idx' may be used uninitialized in this function [-Wmaybe-uninitialized]
>>>
>>> Introduced by commit
>>>
>>>   056f9c7f39bf ("iw_cxgb4: dump detailed driver-specific QP information")
>>>
>> SteveW, is there a patch to fix this that I'm missing?
>>
>> Thanks,
>> Jason
> Hey Jason, 
>
> I'll send you one shortly. 
>
> Steve.
>

Posted:  https://patchwork.kernel.org/patch/10399081/

Steve.
