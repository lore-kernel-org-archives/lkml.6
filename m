Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752737AbeBFQZk (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 11:25:40 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:45526 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752630AbeBFQZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 11:25:25 -0500
Date: Tue, 06 Feb 2018 11:25:23 -0500 (EST)
Message-Id: <20180206.112523.173878106111040737.davem@davemloft.net>
To: wsa+renesas@sang-engineering.com
Cc: linux-kernel@vger.kernel.org, dan.carpenter@oracle.com,
        linux-renesas-soc@vger.kernel.org, thomas.lendacky@amd.com,
        netdev@vger.kernel.org
Subject: Re: [PATCH 4/4] net: amd-xgbe: fix comparison to bitshift when
 dealing with a mask
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180205201002.23621-5-wsa+renesas@sang-engineering.com>
References: <20180205201002.23621-1-wsa+renesas@sang-engineering.com>
        <20180205201002.23621-5-wsa+renesas@sang-engineering.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wolfram Sang <wsa+renesas@sang-engineering.com>
Date: Mon,  5 Feb 2018 21:10:01 +0100

> Due to a typo, the mask was destroyed by a comparison instead of a bit
> shift.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Applied and queued up for -stable, thanks.
