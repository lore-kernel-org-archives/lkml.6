Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754878AbeBATyz (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 14:54:55 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:50014 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754594AbeBATyq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 14:54:46 -0500
Date: Thu, 01 Feb 2018 14:54:44 -0500 (EST)
Message-Id: <20180201.145444.1341243515146963119.davem@davemloft.net>
To: colin.king@canonical.com
Cc: cooldavid@cooldavid.org, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: jme: remove unused initialization of 'rxdesc'
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180201165842.21906-1-colin.king@canonical.com>
References: <20180201165842.21906-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Thu,  1 Feb 2018 16:58:42 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer rxdesc is assigned a value that is never read, it is overwritten
> by a new assignment inside a while loop hence the initial assignment
> is redundant and can be removed.
> 
> Cleans up clang warning:
> drivers/net/ethernet/jme.c:1074:17: warning: Value stored to 'rxdesc'
> during its initialization is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
