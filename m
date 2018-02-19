Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753300AbeBSQNB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 19 Feb 2018 11:13:01 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:60970 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753110AbeBSQM7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Feb 2018 11:12:59 -0500
Date: Mon, 19 Feb 2018 11:12:57 -0500 (EST)
Message-Id: <20180219.111257.1329701897275591898.davem@davemloft.net>
To: gustavo@embeddedor.com
Cc: andrew@lunn.ch, vivien.didelot@savoirfairelinux.com,
        f.fainelli@gmail.com, richardcochran@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, garsilva@embeddedor.com
Subject: Re: [PATCH] net: dsa: mv88e6xxx: hwtstamp: remove unnecessary
 range checking tests
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180216174739.GA8415@embeddedgus>
References: <20180216174739.GA8415@embeddedgus>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Fri, 16 Feb 2018 11:47:39 -0600

> _port_ is already known to be a valid index in the callers [1]. So
> these checks are unnecessary.
> 
> [1] https://lkml.org/lkml/2018/2/16/469
> 
> Addresses-Coverity-ID: 1465287
> Addresses-Coverity-ID: 1465291
> Suggested-by: Richard Cochran <richardcochran@gmail.com>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied, thank you.
