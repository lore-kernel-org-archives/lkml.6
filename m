Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753996AbeDQN6q (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 09:58:46 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:55450 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753099AbeDQN6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 09:58:43 -0400
Date: Tue, 17 Apr 2018 09:58:41 -0400 (EDT)
Message-Id: <20180417.095841.2175928022934951986.davem@davemloft.net>
To: nicolas.dechesne@linaro.org
Cc: bjorn.andersson@linaro.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: qrtr: add MODULE_ALIAS_NETPROTO macro
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180417120326.11022-1-nicolas.dechesne@linaro.org>
References: <20180417120326.11022-1-nicolas.dechesne@linaro.org>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nicolas Dechesne <nicolas.dechesne@linaro.org>
Date: Tue, 17 Apr 2018 14:03:26 +0200

> To ensure that qrtr can be loaded automatically, when needed, if it is compiled
> as module.
> 
> Signed-off-by: Nicolas Dechesne <nicolas.dechesne@linaro.org>

Applied.
