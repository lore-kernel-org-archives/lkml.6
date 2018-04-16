Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753180AbeDPRnj (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 13:43:39 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:44464 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751159AbeDPRnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 13:43:37 -0400
Date: Mon, 16 Apr 2018 13:43:33 -0400 (EDT)
Message-Id: <20180416.134333.1584175683168282946.davem@davemloft.net>
To: ryder.lee@mediatek.com
Cc: sean.wang@mediatek.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] net: mediatek: use of_device_get_match_data()
From: David Miller <davem@davemloft.net>
In-Reply-To: <9bf87205f84062580934168774d690d4cd2bf26b.1523347340.git.ryder.lee@mediatek.com>
References: <31f944ab8dfcc1d7b6f03b35657a2a34825b5246.1523347340.git.ryder.lee@mediatek.com>
        <9bf87205f84062580934168774d690d4cd2bf26b.1523347340.git.ryder.lee@mediatek.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ryder Lee <ryder.lee@mediatek.com>
Date: Mon, 16 Apr 2018 10:33:41 +0800

> The usage of of_device_get_match_data() reduce the code size a bit.
> 
> Also, the only way to call mtk_probe() is to match an entry in
> of_mtk_match[], so match cannot be NULL.
> 
> Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>

Applied to net-next.
