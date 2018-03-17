Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752514AbeCQNWz (ORCPT <rfc822;w@1wt.eu>);
        Sat, 17 Mar 2018 09:22:55 -0400
Received: from mail.bootlin.com ([62.4.15.54]:53240 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752114AbeCQNWy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Mar 2018 09:22:54 -0400
Date: Sat, 17 Mar 2018 14:22:52 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Arnd Bergmann <arnd@arndb.de>,
        Linux-Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: linux-next: manual merge of the rtc tree with the asm-generic
 tree
Message-ID: <20180317132252.GG4123@piout.net>
References: <20180315185917.3316d781@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315185917.3316d781@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On 15/03/2018 at 18:59:17 +1100, Stephen Rothwell wrote:
> Hi Alexandre,
> 
> Today's linux-next merge of the rtc tree got a conflict in:
> 
>   drivers/rtc/rtc-tile.c
> 
> between commit:
> 
>   909ce75a0665 ("rtc: remove tile driver")
> 
> from the asm-generic tree and commit:
> 
>   1fbcb2aa1d64 ("rtc: tile: remove useless message")
> 
> from the rtc tree.
> 
> I fixed it up (see below) and can carry the fix as necessary. This
> is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

I've removed the patch from my tree as there is no point in modifying a
driver that is removed.


-- 
Alexandre Belloni, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
