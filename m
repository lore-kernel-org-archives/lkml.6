Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752028AbeBAOnX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 09:43:23 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:43850 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbeBAOnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 09:43:19 -0500
Date: Thu, 01 Feb 2018 09:43:17 -0500 (EST)
Message-Id: <20180201.094317.1226307518693749272.davem@davemloft.net>
To: colin.king@canonical.com
Cc: sathya.perla@broadcom.com, ajit.khaparde@broadcom.com,
        sriharsha.basavapatna@broadcom.com, somnath.kotur@broadcom.com,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] be2net: remove redundant initialization of 'head' and
 pointer txq
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180131161425.15011-1-colin.king@canonical.com>
References: <20180131161425.15011-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Wed, 31 Jan 2018 16:14:25 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> Variable head is initialized to a value that is never read and is
> being updated to a new value a few lines later, hence this
> initialization is redundant and can be safely removed as well
> as the now unused pointer txq.
> 
> Cleans up clang warning:
> drivers/net/ethernet/emulex/benet/be_main.c:996:6: warning: Value
> stored to 'head' during its initialization is never read
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied, thank you.
