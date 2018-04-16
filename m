Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754182AbeDPJDz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 05:03:55 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:7172 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752941AbeDPJDy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 05:03:54 -0400
Subject: Re: [PATCH] IB: make INFINIBAND_ADDR_TRANS configurable
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "jgg@ziepe.ca" <jgg@ziepe.ca>,
        "gthelen@google.com" <gthelen@google.com>,
        "dledford@redhat.com" <dledford@redhat.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "tarick@google.com" <tarick@google.com>
References: <20180413070644.11974-1-gthelen@google.com>
 <9ad4563e701a38915d58552f9eee5b3602833ddf.camel@wdc.com>
From: oulijun <oulijun@huawei.com>
Message-ID: <79002036-47dc-9a57-8c00-43a44a6b100a@huawei.com>
Date: Mon, 16 Apr 2018 17:03:29 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.1.0
MIME-Version: 1.0
In-Reply-To: <9ad4563e701a38915d58552f9eee5b3602833ddf.camel@wdc.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.61.25.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2018/4/13 20:47, Bart Van Assche 写道:
> On Fri, 2018-04-13 at 00:06 -0700, Greg Thelen wrote:
>> Allow INFINIBAND without INFINIBAND_ADDR_TRANS.
>>
>> Signed-off-by: Greg Thelen <gthelen@google.com>
>> Cc: Tarick Bedeir <tarick@google.com>
>> ---
>>  drivers/infiniband/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/infiniband/Kconfig b/drivers/infiniband/Kconfig
>> index ee270e065ba9..f20a3977087c 100644
>> --- a/drivers/infiniband/Kconfig
>> +++ b/drivers/infiniband/Kconfig
>> @@ -61,7 +61,7 @@ config INFINIBAND_ON_DEMAND_PAGING
>>  	  pages on demand instead.
>>  
>>  config INFINIBAND_ADDR_TRANS
>> -	bool
>> +	bool "InfiniBand address translation"
>>  	depends on INFINIBAND
>>  	default y
> 
> Hello Greg,
> 
> Please change the short description from "InfiniBand address translation" (which
> is a misleading description) into "RDMA/CM". Please also add a help text that
> explains to people who are not RDMA experts what the RDMA/CM is.
> 
> Thanks,
> 
> Bart.
> 
Hi, Bart
  We need to select the INFINIBAND without INFINIBAND_ADDR_TRANS if use cm for others?

Thanks
Lijun Ou
> 
> 
> �{.n�+�������+%��lzwm��b�맲��r��zX��ݙ�����ܨ}���Ơz�&j:+v�������zZ+��+zf���h���~����i���z��w���?����&�)ߢf
> 
