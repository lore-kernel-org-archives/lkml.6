Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933215AbeD1ATX (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 20:19:23 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:59820 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933115AbeD1ATW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 20:19:22 -0400
Date: Fri, 27 Apr 2018 20:19:20 -0400 (EDT)
Message-Id: <20180427.201920.2262338622552468340.davem@davemloft.net>
To: Jisheng.Zhang@synaptics.com
Cc: andrew@lunn.ch, vivien.didelot@savoirfairelinux.com,
        f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drivers: net: replace UINT64_MAX with U64_MAX
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180427161858.433aabf9@xhacker.debian>
References: <20180427161858.433aabf9@xhacker.debian>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jisheng Zhang <Jisheng.Zhang@synaptics.com>
Date: Fri, 27 Apr 2018 16:18:58 +0800

> U64_MAX is well defined now while the UINT64_MAX is not, so we fall
> back to drivers' own definition as below:
> 
> 	#ifndef UINT64_MAX
> 	#define UINT64_MAX             (u64)(~((u64)0))
> 	#endif
> 
> I believe this is in one phy driver then copied and pasted to other phy
> drivers.
> 
> Replace the UINT64_MAX with U64_MAX to clean up the source code.
> 
> Signed-off-by: Jisheng Zhang <Jisheng.Zhang@synaptics.com>

Looks good, applied to net-next, thanks.
