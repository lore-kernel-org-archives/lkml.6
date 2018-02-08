Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752308AbeBHUFk (ORCPT <rfc822;w@1wt.eu>);
        Thu, 8 Feb 2018 15:05:40 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:48760 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751786AbeBHUFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Feb 2018 15:05:39 -0500
Date: Thu, 08 Feb 2018 15:05:36 -0500 (EST)
Message-Id: <20180208.150536.1732289776944691235.davem@davemloft.net>
To: gustavo@embeddedor.com
Cc: 3chas3@gmail.com, linux-atm-general@lists.sourceforge.net,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        garsilva@embeddedor.com
Subject: Re: [PATCH] atm: he: use 64-bit arithmetic instead of 32-bit
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180207161729.GA10329@embeddedgus>
References: <20180207161729.GA10329@embeddedgus>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Wed, 7 Feb 2018 10:17:29 -0600

> Add suffix ULL to constants 272, 204, 136 and 68 in order to give the
> compiler complete information about the proper arithmetic to use.
> Notice that these constants are used in contexts that expect
> expressions of type unsigned long long (64 bits, unsigned).
> 
> The following expressions are currently being evaluated using 32-bit
> arithmetic:
> 
> 272 * mult
> 204 * mult
> 136 * mult
> 68 * mult
> 
> Addresses-Coverity-ID: 201058
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied, thanks.
