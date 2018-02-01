Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754778AbeBATz1 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 14:55:27 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:50028 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754594AbeBATy6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 14:54:58 -0500
Date: Thu, 01 Feb 2018 14:54:56 -0500 (EST)
Message-Id: <20180201.145456.251900509374837057.davem@davemloft.net>
To: colin.king@canonical.com
Cc: skhare@vmware.com, pv-drivers@vmware.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vmxnet3: remove redundant initialization of pointer
 'rq'
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180201172921.22770-1-colin.king@canonical.com>
References: <20180201172921.22770-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Thu,  1 Feb 2018 17:29:21 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> Pointer rq is being initialized but this value is never read, it
> is being updated inside a for-loop. Remove the initialization and
> move it into the scope of the for-loop.
> 
> Cleans up clang warning:
> drivers/net/vmxnet3/vmxnet3_drv.c:2763:27: warning: Value stored
> to 'rq' during its initialization is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
