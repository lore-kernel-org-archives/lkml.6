Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751274AbeDXUBQ (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 16:01:16 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:39612 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751212AbeDXUBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 16:01:14 -0400
Date: Tue, 24 Apr 2018 16:01:11 -0400 (EDT)
Message-Id: <20180424.160111.115150071933075757.davem@davemloft.net>
To: colin.king@canonical.com
Cc: madalin.bucur@nxp.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fsl/fman_port: remove redundant check on
 port->rev_info.major
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180424113945.16371-1-colin.king@canonical.com>
References: <20180424113945.16371-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Tue, 24 Apr 2018 12:39:45 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> The check port->rev_info.major >= 6 is being performed twice, thus
> the inner second check is always true and is redundant, hence it
> can be removed. Detected by cppcheck.
> 
> drivers/net/ethernet/freescale/fman/fman_port.c:1394]: (warning)
> Identical inner 'if' condition is always true.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to net-next, thank you.
