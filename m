Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932511AbeCLPNF (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 11:13:05 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:60202 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932479AbeCLPNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 11:13:04 -0400
Date: Mon, 12 Mar 2018 11:13:02 -0400 (EDT)
Message-Id: <20180312.111302.544568010784710629.davem@davemloft.net>
To: colin.king@canonical.com
Cc: bryan.whitehead@microchip.com, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] lan743x: make functions lan743x_csr_read and
 lan743x_csr_read static
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180311165547.27500-1-colin.king@canonical.com>
References: <20180311165547.27500-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Sun, 11 Mar 2018 17:55:47 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> Functions lan743x_csr_read and lan743x_csr_read are local to the source
> and do not need to be in global scope, so make them static.
> 
> Cleans up sparse warning:
> drivers/net/ethernet/microchip/lan743x_main.c:56:5: warning: symbol
> lan743x_csr_read' was not declared. Should it be static?
> drivers/net/ethernet/microchip/lan743x_main.c:61:6: warning: symbol
> 'lan743x_csr_write' was not declared. Should it be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
