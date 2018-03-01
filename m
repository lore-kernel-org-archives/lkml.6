Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161022AbeCASiy (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 13:38:54 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:36106 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1033978AbeCASiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 13:38:52 -0500
Date: Thu, 01 Mar 2018 13:38:49 -0500 (EST)
Message-Id: <20180301.133849.828156667575255120.davem@davemloft.net>
To: arnd@arndb.de
Cc: kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, jishi@redhat.com,
        sd@queasysnail.net, sbrivio@redhat.com, dsahern@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ipv4: avoid unused variable warning for sysctl
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180228133310.1816221-1-arnd@arndb.de>
References: <20180228133310.1816221-1-arnd@arndb.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 28 Feb 2018 14:32:48 +0100

> The newly introudced ip_min_valid_pmtu variable is only used when
> CONFIG_SYSCTL is set:
> 
> net/ipv4/route.c:135:12: error: 'ip_min_valid_pmtu' defined but not used [-Werror=unused-variable]
> 
> This moves it to the other variables like it, to avoid the harmless
> warning.
> 
> Fixes: c7272c2f1229 ("net: ipv4: don't allow setting net.ipv4.route.min_pmtu below 68")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks Arnd.
