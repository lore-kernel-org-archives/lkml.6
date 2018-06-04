Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751017AbeFDPbd (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 11:31:33 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:48468 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750723AbeFDPbb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 11:31:31 -0400
Date: Mon, 04 Jun 2018 11:31:29 -0400 (EDT)
Message-Id: <20180604.113129.2259414741108607335.davem@davemloft.net>
To: colin.king@canonical.com
Cc: igor.russkikh@aquantia.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: aquantia: make function aq_fw2x_get_mac_permanent
 static
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180601152834.17958-1-colin.king@canonical.com>
References: <20180601152834.17958-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Fri,  1 Jun 2018 16:28:34 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> The function aq_fw2x_get_mac_permanent is local to the source and does
> not need to be in global scope, so make it static.
> 
> Cleans up sparse warning:
> warning: symbol 'aq_fw2x_get_mac_permanent' was not declared. Should it
> be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to net-next, thank you.
