Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752331AbeC0OjP (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 10:39:15 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:40498 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751103AbeC0OjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 10:39:13 -0400
Date: Tue, 27 Mar 2018 10:39:11 -0400 (EDT)
Message-Id: <20180327.103911.924179090835764688.davem@davemloft.net>
To: colin.king@canonical.com
Cc: dan.carpenter@oracle.com, sam@mendozajonas.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/ncsi: check for null return from call to
 nla_nest_start
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180326112712.31165-1-colin.king@canonical.com>
References: <20180326112712.31165-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Mon, 26 Mar 2018 12:27:12 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> The call to nla_nest_start calls nla_put which can lead to a NULL
> return so it's possible for attr to become NULL and we can potentially
> get a NULL pointer dereference on attr.  Fix this by checking for
> a NULL return.
> 
> Detected by CoverityScan, CID#1466125 ("Dereference null return")
> 
> Fixes: 955dc68cb9b2 ("net/ncsi: Add generic netlink family")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, but...

Colin, please start marking your Subject lines properly with "[PATCH
net-next]" for patches targetting net-next as opposed to net.

Thank you.
