Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbeFEMqE (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:46:04 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35331 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751598AbeFEMqD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:46:03 -0400
X-Google-Smtp-Source: ADUXVKJwvslCFbOxYJeikgzN5WeF5Hut8b0TuHRkXA4fRKrh4GxQ7gDEYijHQviwu+oNFiOobBmYHTFD/YpmOFnMK4s=
MIME-Version: 1.0
In-Reply-To: <20180605124929.GA13305@lst.de>
References: <20180605122851.23912-1-yuehaibing@huawei.com> <CAHp75VcWqO8hzbprP1FZJFmpu18iFXxHsu9uXw8RGngRf2jJhw@mail.gmail.com>
 <20180605124929.GA13305@lst.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Jun 2018 15:46:02 +0300
Message-ID: <CAHp75VewE_eyw-xes4n7sBbZv0uGPu_QdPYaZwdEd_5AUCcvvg@mail.gmail.com>
Subject: Re: [PATCH net-next 0/6] use pci_zalloc_consistent
To: Christoph Hellwig <hch@lst.de>
Cc: YueHaibing <yuehaibing@huawei.com>,
        "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jcliburn@gmail.com, chris.snook@gmail.com, benve@cisco.com,
        Jon Mason <jdmason@kudzu.us>, chessman@tux.org, jes@trained-monkey.org,
        rahul.verma@cavium.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 3:49 PM, Christoph Hellwig <hch@lst.de> wrote:
> On Tue, Jun 05, 2018 at 03:39:16PM +0300, Andy Shevchenko wrote:
>> On Tue, Jun 5, 2018 at 3:28 PM, YueHaibing <yuehaibing@huawei.com> wrote:
>> >
>>
>> Hmm... Is PCI case anyhow special or it's a simple wrapper on top of
>> dma.*alloc() ?
>
> All drivers should move from pci_dma* to dma_* eventually.  Converting
> from one flavor of deprecated to another is completely pointless.

Exactly my impression. Thanks, Christoph for clarification.

YueHaibing, care to follow what Christoph said and change your series
accordingly?

-- 
With Best Regards,
Andy Shevchenko
