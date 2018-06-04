Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751582AbeFDVCX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 17:02:23 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:52482 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751093AbeFDVCU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 17:02:20 -0400
Date: Mon, 04 Jun 2018 17:02:18 -0400 (EDT)
Message-Id: <20180604.170218.217162049102812570.davem@davemloft.net>
To: rdunlap@infradead.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        akpm@linux-foundation.org
Subject: Re: [PATCH] net: skbuff.h: drop unneeded <linux/slab.h>
From: David Miller <davem@davemloft.net>
In-Reply-To: <86ee9a53-3136-7a2c-e59a-57d4d078188f@infradead.org>
References: <86ee9a53-3136-7a2c-e59a-57d4d078188f@infradead.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>
Date: Sat, 2 Jun 2018 21:40:19 -0700

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> <linux/skbuff.h> does not use nor need <linux/slab.h>, so drop this
> header file from skbuff.h.
> 
> <linux/skbuff.h> is currently #included in around 1200 C source and
> header files, making it the 31st most-used header file.
> 
> Build tested [allmodconfig] on 20 arch-es.
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Applied, thanks Randy.
