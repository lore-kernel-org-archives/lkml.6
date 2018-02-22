Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751420AbeBVTpM (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 14:45:12 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:51086 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751346AbeBVTpI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 14:45:08 -0500
Date: Thu, 22 Feb 2018 14:45:06 -0500 (EST)
Message-Id: <20180222.144506.1566524449614091768.davem@davemloft.net>
To: fthain@telegraphics.com.au
Cc: netdev@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/smc9194: Remove bogus CONFIG_MAC reference
From: David Miller <davem@davemloft.net>
In-Reply-To: <alpine.LNX.2.21.1802191406040.8@nippy.intranet>
References: <alpine.LNX.2.21.1802191406040.8@nippy.intranet>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Finn Thain <fthain@telegraphics.com.au>
Date: Thu, 22 Feb 2018 09:24:59 +1100 (AEDT)

> AFAIK the only version of smc9194.c with Mac support is the one in the
> linux-mac68k CVS repo, which never made it to the mainline.
> 
> Despite that, from v2.3.45, arch/m68k/config.in listed CONFIG_SMC9194
> under CONFIG_MAC. This mistake got carried over into Kconfig in v2.5.55.
> (See pre-git era "[PATCH] add m68k dependencies to net driver config".)
> 
> Signed-off-by: Finn Thain <fthain@telegraphics.com.au>

Applied, thank you.
