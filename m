Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751890AbeFEMjT (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 08:39:19 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:42154 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751667AbeFEMjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 08:39:17 -0400
X-Google-Smtp-Source: ADUXVKLEwCAvo14OAoHvfyojYMjgf/JCujjGwSVmt0SZjdjDpGahcew429uXXXi8uvKRHT/jF4JsH/KnlSH6oVT2cjk=
MIME-Version: 1.0
In-Reply-To: <20180605122851.23912-1-yuehaibing@huawei.com>
References: <20180605122851.23912-1-yuehaibing@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 5 Jun 2018 15:39:16 +0300
Message-ID: <CAHp75VcWqO8hzbprP1FZJFmpu18iFXxHsu9uXw8RGngRf2jJhw@mail.gmail.com>
Subject: Re: [PATCH net-next 0/6] use pci_zalloc_consistent
To: YueHaibing <yuehaibing@huawei.com>, Christoph Hellwig <hch@lst.de>
Cc: "David S. Miller" <davem@davemloft.net>,
        netdev <netdev@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        jcliburn@gmail.com, chris.snook@gmail.com, benve@cisco.com,
        Jon Mason <jdmason@kudzu.us>, chessman@tux.org, jes@trained-monkey.org,
        rahul.verma@cavium.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 5, 2018 at 3:28 PM, YueHaibing <yuehaibing@huawei.com> wrote:
>

Hmm... Is PCI case anyhow special or it's a simple wrapper on top of
dma.*alloc() ?

> YueHaibing (6):
>   net: hippi: use pci_zalloc_consistent
>   net: atheros: use pci_zalloc_consistent
>   net: neterion: use pci_zalloc_consistent
>   netxen_nic: use pci_zalloc_consistent
>   net: tlan: use pci_zalloc_consistent
>   enic: use pci_zalloc_consistent
>
>  drivers/net/ethernet/atheros/atl1e/atl1e_main.c    |  2 +-
>  drivers/net/ethernet/atheros/atlx/atl1.c           |  8 +++----
>  drivers/net/ethernet/atheros/atlx/atl2.c           |  5 ++--
>  drivers/net/ethernet/cisco/enic/vnic_dev.c         |  3 +--
>  drivers/net/ethernet/neterion/s2io.c               | 10 ++++----
>  .../net/ethernet/qlogic/netxen/netxen_nic_ctx.c    | 26 ++++++++------------
>  drivers/net/ethernet/ti/tlan.c                     |  7 +++---
>  drivers/net/hippi/rrunner.c                        | 28 +++++++++-------------
>  8 files changed, 35 insertions(+), 54 deletions(-)
>
> --
> 2.7.0
>
>



-- 
With Best Regards,
Andy Shevchenko
