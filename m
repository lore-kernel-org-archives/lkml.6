Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751892AbeFENAo (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 09:00:44 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:35452 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751625AbeFENAn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 09:00:43 -0400
Date: Tue, 05 Jun 2018 09:00:39 -0400 (EDT)
Message-Id: <20180605.090039.1115878490025405476.davem@davemloft.net>
To: hch@lst.de
Cc: andy.shevchenko@gmail.com, yuehaibing@huawei.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        jcliburn@gmail.com, chris.snook@gmail.com, benve@cisco.com,
        jdmason@kudzu.us, chessman@tux.org, jes@trained-monkey.org,
        rahul.verma@cavium.com
Subject: Re: [PATCH net-next 0/6] use pci_zalloc_consistent
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180605124929.GA13305@lst.de>
References: <20180605122851.23912-1-yuehaibing@huawei.com>
        <CAHp75VcWqO8hzbprP1FZJFmpu18iFXxHsu9uXw8RGngRf2jJhw@mail.gmail.com>
        <20180605124929.GA13305@lst.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Tue, 5 Jun 2018 14:49:29 +0200

> On Tue, Jun 05, 2018 at 03:39:16PM +0300, Andy Shevchenko wrote:
>> On Tue, Jun 5, 2018 at 3:28 PM, YueHaibing <yuehaibing@huawei.com> wrote:
>> >
>> 
>> Hmm... Is PCI case anyhow special or it's a simple wrapper on top of
>> dma.*alloc() ?
> 
> All drivers should move from pci_dma* to dma_* eventually.  Converting
> from one flavor of deprecated to another is completely pointless.

Agreed.
