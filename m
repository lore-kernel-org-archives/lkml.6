Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751225AbeEPSoQ (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 14:44:16 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:43872 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbeEPSoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 14:44:15 -0400
Date: Wed, 16 May 2018 14:44:11 -0400 (EDT)
Message-Id: <20180516.144411.1533939435811485671.davem@davemloft.net>
To: yuehaibing@huawei.com
Cc: peppe.cavallaro@st.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alexandre.torgue@st.com
Subject: Re: [PATCH net-next] net: stmmac: Remove useless test before
 clk_disable_unprepare
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180516105919.25436-1-yuehaibing@huawei.com>
References: <20180516105919.25436-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Wed, 16 May 2018 18:59:19 +0800

> clk_disable_unprepare() already checks that the clock pointer is valid.
> No need to test it before calling it.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
