Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751819AbeCVScC (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 14:32:02 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:59204 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751617AbeCVScB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 14:32:01 -0400
Date: Thu, 22 Mar 2018 14:31:59 -0400 (EDT)
Message-Id: <20180322.143159.2085752623277697593.davem@davemloft.net>
To: madalin.bucur@nxp.com
Cc: geert.uytterhoeven@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsl/fman: remove unnecessary set_dma_ops() call and
 HAS_DMA dependency
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180321085819.23249-1-madalin.bucur@nxp.com>
References: <20180321085819.23249-1-madalin.bucur@nxp.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Madalin Bucur <madalin.bucur@nxp.com>
Date: Wed, 21 Mar 2018 03:58:19 -0500

> The platform device is no longer used for DMA mapping so the
> (questionable) setting of the DMA ops done here is no longer
> needed. Removing it together with the HAS_DMA dependency that
> it required.
> 
> Signed-off-by: Madalin Bucur <madalin.bucur@nxp.com>

This doesn't apply to any of my trees.
