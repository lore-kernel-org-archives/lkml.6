Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758643AbeD0TD0 (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 15:03:26 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:56436 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758203AbeD0TDZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 15:03:25 -0400
Date: Fri, 27 Apr 2018 15:03:23 -0400 (EDT)
Message-Id: <20180427.150323.1018656244013606101.davem@davemloft.net>
To: vivien.didelot@savoirfairelinux.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, joe@perches.com
Subject: Re: [RFC PATCH] MAINTAINERS: add davem in NETWORKING DRIVERS
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180426234735.30112-1-vivien.didelot@savoirfairelinux.com>
References: <20180426234735.30112-1-vivien.didelot@savoirfairelinux.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Thu, 26 Apr 2018 19:47:35 -0400

> "./scripts/get_maintainer.pl -f" does not actually show us David as the
> maintainer of drivers/net directories such as team, bonding, phy or dsa.
> Adding him in an M: entry of NETWORKING DRIVERS fixes this.
> 
> Signed-off-by: Vivien Didelot <vivien.didelot@savoirfairelinux.com>

Yeah, might as well.

Applied, th anks.
