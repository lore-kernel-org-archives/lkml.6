Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754626AbeCGRXM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:23:12 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:54440 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754248AbeCGRXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:23:08 -0500
Date: Wed, 07 Mar 2018 12:23:06 -0500 (EST)
Message-Id: <20180307.122306.1887148645040810127.davem@davemloft.net>
To: hpuranik@codeaurora.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        timur@codeaurora.org
Subject: Re: [PATCH] net: qcom/emac: Use proper free methods during TX
From: David Miller <davem@davemloft.net>
In-Reply-To: <1520304486-14466-1-git-send-email-hpuranik@codeaurora.org>
References: <1520304486-14466-1-git-send-email-hpuranik@codeaurora.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hemanth Puranik <hpuranik@codeaurora.org>
Date: Tue,  6 Mar 2018 08:18:06 +0530

> This patch fixes the warning messages/call traces seen if DMA debug is
> enabled, In case of fragmented skb's memory was allocated using
> dma_map_page but freed using dma_unmap_single. This patch modifies buffer
> allocations in TX path to use dma_map_page in all the places and
> dma_unmap_page while freeing the buffers.
> 
> Signed-off-by: Hemanth Puranik <hpuranik@codeaurora.org>

Applied.
