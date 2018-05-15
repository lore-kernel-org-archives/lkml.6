Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752186AbeEOCoh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 22:44:37 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:45406 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752009AbeEOCog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 22:44:36 -0400
Date: Mon, 14 May 2018 22:44:35 -0400 (EDT)
Message-Id: <20180514.224435.1060844543476271046.davem@davemloft.net>
To: hpreg@vmware.com
Cc: netdev@vger.kernel.org, doshir@vmware.com, pv-drivers@vmware.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 1/2] vmxnet3: set the DMA mask before the first DMA
 map operation
From: David Miller <davem@davemloft.net>
In-Reply-To: <1526300907-79831-1-git-send-email-hpreg@vmware.com>
References: <1526300907-79831-1-git-send-email-hpreg@vmware.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: <hpreg@vmware.com>
Date: Mon, 14 May 2018 08:28:26 -0400

> The DMA mask must be set before, not after, the first DMA map operation, or
> the first DMA map operation could in theory fail on some systems.
> 
> Fixes: b0eb57cb97e78 ("VMXNET3: Add support for virtual IOMMU")
> Signed-off-by: Regis Duchesne <hpreg@vmware.com>
> Acked-by: Ronak Doshi <doshir@vmware.com>

Applied and queued up for -stable.
