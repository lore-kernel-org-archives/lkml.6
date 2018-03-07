Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754525AbeCGRUQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:20:16 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:54390 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754052AbeCGRUP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:20:15 -0500
Date: Wed, 07 Mar 2018 12:20:13 -0500 (EST)
Message-Id: <20180307.122013.819463937765026863.davem@davemloft.net>
To: garsilva@embeddedor.com
Cc: kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ipv6: ndisc: use true and false for boolean values
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180305221154.GA17126@embeddedor.com>
References: <20180305221154.GA17126@embeddedor.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <garsilva@embeddedor.com>
Date: Mon, 5 Mar 2018 16:11:54 -0600

> Assign true or false to boolean variables instead of an integer value.
> 
> This issue was detected with the help of Coccinelle.
> 
> Signed-off-by: Gustavo A. R. Silva <garsilva@embeddedor.com>

Applied, thanks.
