Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752960AbeDPWxc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 18:53:32 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:47860 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750989AbeDPWxa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 18:53:30 -0400
Date: Mon, 16 Apr 2018 18:53:29 -0400 (EDT)
Message-Id: <20180416.185329.1685075058961233827.davem@davemloft.net>
To: rdunlap@infradead.org
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] textsearch: fix kernel-doc warnings and add kernel-api
 section
From: David Miller <davem@davemloft.net>
In-Reply-To: <8f871cc5-dba8-c4d8-9dfb-ea61a2aa35a7@infradead.org>
References: <8f871cc5-dba8-c4d8-9dfb-ea61a2aa35a7@infradead.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>
Date: Mon, 16 Apr 2018 12:32:55 -0700

> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Make lib/textsearch.c usable as kernel-doc.
> Add textsearch() function family to kernel-api documentation.
> Fix kernel-doc warnings in <linux/textsearch.h>:
>   ../include/linux/textsearch.h:65: warning: Incorrect use of kernel-doc format:
> 	* get_next_block - fetch next block of data
>   ../include/linux/textsearch.h:82: warning: Incorrect use of kernel-doc format:
> 	* finish - finalize/clean a series of get_next_block() calls
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>

Applied, thanks Randy.
