Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752035AbeBZQeJ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 11:34:09 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:43876 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751236AbeBZQeI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 11:34:08 -0500
Date: Mon, 26 Feb 2018 11:34:05 -0500 (EST)
Message-Id: <20180226.113405.1105061701822631136.davem@davemloft.net>
To: colin.king@canonical.com
Cc: linux-net-drivers@solarflare.com, ecree@solarflare.com,
        bkenward@solarflare.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sfc: falcon: remove duplicated bit-wise or of
 LOOPBACK_SGMII
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180223140056.27219-1-colin.king@canonical.com>
References: <20180223140056.27219-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Fri, 23 Feb 2018 14:00:56 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> Bit pattern LOOPBACK_SGMII is being bit-wise or'd twice; remove the
> redundant 2nd LOOPBACK_SGMII
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to net-next, thanks.
