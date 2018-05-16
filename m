Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751290AbeEPSkv (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 14:40:51 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:43818 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbeEPSkt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 14:40:49 -0400
Date: Wed, 16 May 2018 14:40:47 -0400 (EDT)
Message-Id: <20180516.144047.1624723916101183580.davem@davemloft.net>
To: geert@linux-m68k.org
Cc: arnd@arndb.de, linux@dominikbrodowski.net, anemo@mba.ocn.ne.jp,
        netdev@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: 8390: ne: Fix accidentally removed RBTX4927
 support
From: David Miller <davem@davemloft.net>
In-Reply-To: <1526462281-20772-1-git-send-email-geert@linux-m68k.org>
References: <1526462281-20772-1-git-send-email-geert@linux-m68k.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 16 May 2018 11:18:01 +0200

> The configuration settings for RBTX4927 were accidentally removed,
> leading to a silently broken network interface.
> 
> Re-add the missing settings to fix this.
> 
> Fixes: 8eb97ff5a4ec941d ("net: 8390: remove m32r specific bits")
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
> ---
> Bisected between v4.9-rc2 (doh) and v4.17-rc5.
> 
> Note to myself: I should do more boot testing on RBTX4927.
> Fortunately I caught it before it ends up in a point release ;-)

Better to go on a wild bisect ride than not be able to find the
bug at all :-)

Applied, thanks.
