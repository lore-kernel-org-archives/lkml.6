Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751946AbeFENEb (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:04:31 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:8647 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1751775AbeFENE3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:04:29 -0400
Subject: Re: [PATCH net-next 0/6] use pci_zalloc_consistent
To: Andy Shevchenko <andy.shevchenko@gmail.com>,
        Christoph Hellwig <hch@lst.de>
References: <20180605122851.23912-1-yuehaibing@huawei.com>
 <CAHp75VcWqO8hzbprP1FZJFmpu18iFXxHsu9uXw8RGngRf2jJhw@mail.gmail.com>
 <20180605124929.GA13305@lst.de>
 <CAHp75VewE_eyw-xes4n7sBbZv0uGPu_QdPYaZwdEd_5AUCcvvg@mail.gmail.com>
CC: "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        <jcliburn@gmail.com>, <chris.snook@gmail.com>, <benve@cisco.com>,
        Jon Mason <jdmason@kudzu.us>, <chessman@tux.org>,
        <jes@trained-monkey.org>, <rahul.verma@cavium.com>
From: YueHaibing <yuehaibing@huawei.com>
Message-ID: <8bb9feec-790c-d6f9-1546-278434c6a93e@huawei.com>
Date: Tue, 5 Jun 2018 21:04:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <CAHp75VewE_eyw-xes4n7sBbZv0uGPu_QdPYaZwdEd_5AUCcvvg@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.31.96]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2018/6/5 20:46, Andy Shevchenko wrote:
> On Tue, Jun 5, 2018 at 3:49 PM, Christoph Hellwig <hch@lst.de> wrote:
>> On Tue, Jun 05, 2018 at 03:39:16PM +0300, Andy Shevchenko wrote:
>>> On Tue, Jun 5, 2018 at 3:28 PM, YueHaibing <yuehaibing@huawei.com> wrote:
>>>>
>>>
>>> Hmm... Is PCI case anyhow special or it's a simple wrapper on top of
>>> dma.*alloc() ?
>>
>> All drivers should move from pci_dma* to dma_* eventually.  Converting
>> from one flavor of deprecated to another is completely pointless.
> 
> Exactly my impression. Thanks, Christoph for clarification.
> 
> YueHaibing, care to follow what Christoph said and change your series
> accordingly?

ok, will send v2
> 
