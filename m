Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751881AbeCTQHd (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 12:07:33 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:56336 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751405AbeCTQHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 12:07:31 -0400
Date: Tue, 20 Mar 2018 12:07:28 -0400 (EDT)
Message-Id: <20180320.120728.1961514582193776638.davem@davemloft.net>
To: christophe.jaillet@wanadoo.fr
Cc: heiko@sntech.de, branislav@radocaj.org, netdev@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH v2] net: ethernet: arc: Fix a potential memory leak if
 an optional regulator is deferred
From: David Miller <davem@davemloft.net>
In-Reply-To: <7fd57a4e79da41dccf55430cbc43de340a7f1826.1521061530.git.christophe.jaillet@wanadoo.fr>
References: <7fd57a4e79da41dccf55430cbc43de340a7f1826.1521061530.git.christophe.jaillet@wanadoo.fr>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Date: Sun, 18 Mar 2018 23:59:36 +0100

> If the optional regulator is deferred, we must release some resources.
> They will be re-allocated when the probe function will be called again.
> 
> Fixes: 6eacf31139bf ("ethernet: arc: Add support for Rockchip SoC layer device tree bindings")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> v2: v1 did not compile because of an erroneous variable name. s/ret/err/

Applied and queued up for -stable, thanks.
