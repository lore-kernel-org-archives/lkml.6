Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751377AbeDXUC2 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 16:02:28 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:39638 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750756AbeDXUC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 16:02:26 -0400
Date: Tue, 24 Apr 2018 16:02:25 -0400 (EDT)
Message-Id: <20180424.160225.1434022836243113911.davem@davemloft.net>
To: colin.king@canonical.com
Cc: ilyal@mellanox.com, aviadye@mellanox.com, davejwatson@fb.com,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/tls: remove redundant second null check on sgout
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180424123658.6541-1-colin.king@canonical.com>
References: <20180424123658.6541-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Tue, 24 Apr 2018 13:36:58 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> A duplicated null check on sgout is redundant as it is known to be
> already true because of the identical earlier check. Remove it.
> Detected by cppcheck:
> 
> net/tls/tls_sw.c:696: (warning) Identical inner 'if' condition is always
> true.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to net-next, thank you.
