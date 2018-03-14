Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751543AbeCNOCw (ORCPT <rfc822;w@1wt.eu>);
        Wed, 14 Mar 2018 10:02:52 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:33068 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750827AbeCNOCv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Mar 2018 10:02:51 -0400
Date: Wed, 14 Mar 2018 10:02:44 -0400 (EDT)
Message-Id: <20180314.100244.2217493270868265936.davem@davemloft.net>
To: gustavo@embeddedor.com
Cc: arnd@arndb.de, jianjian.wang1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pktgen: Fix memory leak in pktgen_if_write
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180314080727.GA17319@embeddedgus>
References: <20180314080727.GA17319@embeddedgus>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Wed, 14 Mar 2018 03:07:27 -0500

> _buf_ is an array and the one that must be freed is _tp_ instead.
> 
> Fixes: a870a02cc963 ("pktgen: use dynamic allocation for debug print buffer")
> Reported-by: Wang Jian <jianjian.wang1@gmail.com>
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied, thanks.
