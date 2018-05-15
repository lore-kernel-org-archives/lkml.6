Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752231AbeEOCpD (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 22:45:03 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:45414 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752009AbeEOCpC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 22:45:02 -0400
Date: Mon, 14 May 2018 22:45:01 -0400 (EDT)
Message-Id: <20180514.224501.737523188651166796.davem@davemloft.net>
To: hpreg@vmware.com
Cc: netdev@vger.kernel.org, doshir@vmware.com, pv-drivers@vmware.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] vmxnet3: use DMA memory barriers where required
From: David Miller <davem@davemloft.net>
In-Reply-To: <1526300090-78546-1-git-send-email-hpreg@vmware.com>
References: <1526300090-78546-1-git-send-email-hpreg@vmware.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: <hpreg@vmware.com>
Date: Mon, 14 May 2018 08:14:49 -0400

> The gen bits must be read first from (resp. written last to) DMA memory.
> The proper way to enforce this on Linux is to call dma_rmb() (resp.
> dma_wmb()).
> 
> Signed-off-by: Regis Duchesne <hpreg@vmware.com>
> Acked-by: Ronak Doshi <doshir@vmware.com>

Applied and queued up for -stable.
