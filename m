Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751396AbeFDQuo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 12:50:44 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:41846 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751203AbeFDQum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 12:50:42 -0400
X-Google-Smtp-Source: ADUXVKLXvnTM86i6heMVlKjT69CeKDZ+LltQ1GqWSJhelIaDxP+JkmM/BPkKCeinwBVaeB1j3hLlCg==
Date: Mon, 4 Jun 2018 10:50:37 -0600
From: Jason Gunthorpe <jgg@ziepe.ca>
To: YueHaibing <yuehaibing@huawei.com>
Cc: oulijun@huawei.com, xavier.huwei@huawei.com,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
        dledford@redhat.com
Subject: Re: [PATCH] IB/hns: Use zeroing memory allocator instead of
 allocator/memset
Message-ID: <20180604165037.GA3403@ziepe.ca>
References: <20180603093222.24308-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180603093222.24308-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 03, 2018 at 05:32:22PM +0800, YueHaibing wrote:
> Use dma_zalloc_coherent for allocating zeroed memory and
> remove unnecessary memset function.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  drivers/infiniband/hw/hns/hns_roce_alloc.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)

Applied to for-next, thanks.

Jason
