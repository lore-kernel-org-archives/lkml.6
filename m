Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752674AbeCZRKG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 13:10:06 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:53662 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751748AbeCZRKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 13:10:03 -0400
Date: Mon, 26 Mar 2018 13:10:02 -0400 (EDT)
Message-Id: <20180326.131002.382607463474769029.davem@davemloft.net>
To: sean.wang@mediatek.com
Cc: andrew@lunn.ch, f.fainelli@gmail.com,
        vivien.didelot@savoirfairelinux.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net 2/2] net: dsa: mt7530: fix module autoloading for
 OF platform drivers
From: David Miller <davem@davemloft.net>
In-Reply-To: <cb3bdedb65fca8e206ba081b0dfd69667c3f7804.1522057659.git.sean.wang@mediatek.com>
References: <2497321afc9156f7954e813721f60a0a95c03bd2.1522057659.git.sean.wang@mediatek.com>
        <cb3bdedb65fca8e206ba081b0dfd69667c3f7804.1522057659.git.sean.wang@mediatek.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: <sean.wang@mediatek.com>
Date: Mon, 26 Mar 2018 18:07:10 +0800

> From: Sean Wang <sean.wang@mediatek.com>
> 
> It's required to create a modules.alias via MODULE_DEVICE_TABLE helper
> for the OF platform driver. Otherwise, module autoloading cannot work.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>

Applied.
