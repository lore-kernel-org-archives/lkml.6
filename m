Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752416AbeCZQLt (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 12:11:49 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:52742 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752005AbeCZQLr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 12:11:47 -0400
Date: Mon, 26 Mar 2018 12:11:45 -0400 (EDT)
Message-Id: <20180326.121145.136604200411684413.davem@davemloft.net>
To: colin.king@canonical.com
Cc: subashab@codeaurora.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: qualcomm: rmnet: check for null ep to avoid null
 pointer dereference
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180323235157.8129-1-colin.king@canonical.com>
References: <20180323235157.8129-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Fri, 23 Mar 2018 23:51:57 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> The call to rmnet_get_endpoint can potentially return NULL so check
> for this to avoid any subsequent null pointer dereferences on a NULL
> ep.
> 
> Detected by CoverityScan, CID#1465385 ("Dereference null return value")
> 
> Fixes: 23790ef12082 ("net: qualcomm: rmnet: Allow to configure flags for existing devices")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to net-next, thanks.
