Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755981AbeEaSST (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 14:18:19 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:32768 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755848AbeEaSSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 14:18:16 -0400
Date: Thu, 31 May 2018 14:18:14 -0400 (EDT)
Message-Id: <20180531.141814.40192043884836878.davem@davemloft.net>
To: fthain@telegraphics.com.au
Cc: tsbogend@alpha.franken.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/sonic: Use dma_mapping_error()
From: David Miller <davem@davemloft.net>
In-Reply-To: <cba8175deaf9d631ae000088aea1ccf1c444909b.1527649393.git.fthain@telegraphics.com.au>
References: <cba8175deaf9d631ae000088aea1ccf1c444909b.1527649393.git.fthain@telegraphics.com.au>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finn Thain <fthain@telegraphics.com.au>
Date: Wed, 30 May 2018 13:03:51 +1000

> With CONFIG_DMA_API_DEBUG=y, calling sonic_open() produces the
> message, "DMA-API: device driver failed to check map error".
> Add the missing dma_mapping_error() call.
> 
> Cc: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Applied, thanks.
