Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751575AbeBZQhW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 11:37:22 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:43934 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751416AbeBZQhU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 11:37:20 -0500
Date: Mon, 26 Feb 2018 11:37:18 -0500 (EST)
Message-Id: <20180226.113718.2265855249140521271.davem@davemloft.net>
To: colin.king@canonical.com
Cc: wei.liu2@citrix.com, paul.durrant@citrix.com,
        xen-devel@lists.xenproject.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] xen-netback: make function xenvif_rx_skb static
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180223171657.5748-1-colin.king@canonical.com>
References: <20180223171657.5748-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Fri, 23 Feb 2018 17:16:57 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> The function xenvif_rx_skb is local to the source and does not need
> to be in global scope, so make it static.
> 
> Cleans up sparse warning:
> drivers/net/xen-netback/rx.c:422:6: warning: symbol 'xenvif_rx_skb'
> was not declared. Should it be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
