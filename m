Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754642AbeCGSZz (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 13:25:55 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:55284 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751220AbeCGSZw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 13:25:52 -0500
Date: Wed, 07 Mar 2018 13:25:51 -0500 (EST)
Message-Id: <20180307.132551.1339524852801277076.davem@davemloft.net>
To: colin.king@canonical.com
Cc: antoine.tenart@bootlin.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][net-next] net: mvpp2: make function
 mvpp2_check_hw_buf_num static
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180306152517.2770-1-colin.king@canonical.com>
References: <20180306152517.2770-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Tue,  6 Mar 2018 16:25:17 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> The function mvpp2_check_hw_buf_num is local to the source and does
> not need to be in global scope, so make it static.
> 
> Cleans up sparse warning:
> drivers/net/ethernet/marvell/mvpp2.c:4298:5: warning: symbol
> 'mvpp2_check_hw_buf_num' was not declared. Should it be static?
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Someone else submitted this already, but thanks for the submission.
