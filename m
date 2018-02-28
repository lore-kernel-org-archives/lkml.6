Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932197AbeB1OEb (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 09:04:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36414 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1752228AbeB1OEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 09:04:30 -0500
Date: Wed, 28 Feb 2018 15:04:25 +0100
From: Sabrina Dubroca <sd@queasysnail.net>
To: Arnd Bergmann <arnd@arndb.de>
Cc: "David S. Miller" <davem@davemloft.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        Jianlin Shi <jishi@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
        David Ahern <dsahern@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ipv4: avoid unused variable warning for sysctl
Message-ID: <20180228140425.GA2577@bistromath.localdomain>
References: <20180228133310.1816221-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180228133310.1816221-1-arnd@arndb.de>
User-Agent: Mutt/1.9.3 (2018-01-21)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2018-02-28, 14:32:48 +0100, Arnd Bergmann wrote:
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

Crap. Thanks, and sorry for the mess.

Acked-by: Sabrina Dubroca <sd@queasysnail.net>

-- 
Sabrina
