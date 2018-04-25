Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756494AbeDYS1X (ORCPT <rfc822;w@1wt.eu>);
        Wed, 25 Apr 2018 14:27:23 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:53280 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755712AbeDYSMi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Apr 2018 14:12:38 -0400
Date: Wed, 25 Apr 2018 14:12:37 -0400 (EDT)
Message-Id: <20180425.141237.1661627015961946958.davem@davemloft.net>
To: colin.king@canonical.com
Cc: allen.lkml@gmail.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: amd8111e: remove redundant duplicated if statement
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180425103113.8013-1-colin.king@canonical.com>
References: <20180425103113.8013-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Wed, 25 Apr 2018 11:31:13 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> There are two identical nested if statements, the second is redundant
> and can be removed. Also clean up white space formatting.
> 
> Cleans up cppcheck warning:
> drivers/net/ethernet/amd/amd8111e.c:1080: (warning) Identical inner 'if'
> condition is always true.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
