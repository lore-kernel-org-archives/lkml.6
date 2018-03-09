Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932254AbeCIQ6O (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 11:58:14 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:53696 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932157AbeCIQ6M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 11:58:12 -0500
Date: Fri, 09 Mar 2018 11:58:10 -0500 (EST)
Message-Id: <20180309.115810.954232560207995724.davem@davemloft.net>
To: gustavo@embeddedor.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        garsilva@embeddedor.com
Subject: Re: [PATCH] pktgen: Remove VLA usage
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180309054340.GA14439@embeddedgus>
References: <20180309054340.GA14439@embeddedgus>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Thu, 8 Mar 2018 23:43:40 -0600

> In preparation to enabling -Wvla, remove VLA usage and replace it
> with a fixed-length array instead.
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
> David,
> 
> I'm not sure how often this function is being called and,
> depending on the frequency it may be worth to use
> dynamic memory allocation instead?

It happens every time a config setting is made via the sysfs
files when debug is enabled.

This is not something that happens often.

So your patch is fine, applied to net-next, thanks.
