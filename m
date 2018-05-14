Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751985AbeENAYC (ORCPT <rfc822;w@1wt.eu>);
        Sun, 13 May 2018 20:24:02 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:51482 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750929AbeENAYA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 May 2018 20:24:00 -0400
Date: Sun, 13 May 2018 20:23:59 -0400 (EDT)
Message-Id: <20180513.202359.1371810410522802833.davem@davemloft.net>
To: hch@lst.de
Cc: netdev@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, tedheadster@gmail.com
Subject: Re: [PATCH] 3c59x: convert to generic DMA API
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180512101650.1693-1-hch@lst.de>
References: <20180512101650.1693-1-hch@lst.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christoph Hellwig <hch@lst.de>
Date: Sat, 12 May 2018 12:16:50 +0200

> This driver supports EISA devices in addition to PCI devices, and relied
> on the legacy behavior of the pci_dma* shims to pass on a NULL pointer
> to the DMA API, and the DMA API being able to handle that.  When the
> NULL forwarding broke the EISA support got broken.  Fix this by converting
> to the DMA API instead of the legacy PCI shims.
> 
> Fixes: 4167b2ad ("PCI: Remove NULL device handling from PCI DMA API")
> Reported-by: tedheadster <tedheadster@gmail.com>
> Tested-by: tedheadster <tedheadster@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied and queued up for -stable, thanks.
