Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752020AbeFEMmW (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:42:22 -0400
Received: from verein.lst.de ([213.95.11.211]:60135 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751653AbeFEMmV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:42:21 -0400
Date: Tue, 5 Jun 2018 14:49:29 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: YueHaibing <yuehaibing@huawei.com>, Christoph Hellwig <hch@lst.de>,
        "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jcliburn@gmail.com, chris.snook@gmail.com, benve@cisco.com,
        Jon Mason <jdmason@kudzu.us>, chessman@tux.org, jes@trained-monkey.org,
        rahul.verma@cavium.com
Subject: Re: [PATCH net-next 0/6] use pci_zalloc_consistent
Message-ID: <20180605124929.GA13305@lst.de>
References: <20180605122851.23912-1-yuehaibing@huawei.com> <CAHp75VcWqO8hzbprP1FZJFmpu18iFXxHsu9uXw8RGngRf2jJhw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VcWqO8hzbprP1FZJFmpu18iFXxHsu9uXw8RGngRf2jJhw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 05, 2018 at 03:39:16PM +0300, Andy Shevchenko wrote:
> On Tue, Jun 5, 2018 at 3:28 PM, YueHaibing <yuehaibing@huawei.com> wrote:
> >
> 
> Hmm... Is PCI case anyhow special or it's a simple wrapper on top of
> dma.*alloc() ?

All drivers should move from pci_dma* to dma_* eventually.  Converting
from one flavor of deprecated to another is completely pointless.
