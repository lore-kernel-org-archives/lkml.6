Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932327AbeCMBG7 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 21:06:59 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:39150 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751484AbeCMBG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 21:06:57 -0400
Date: Mon, 12 Mar 2018 21:06:55 -0400 (EDT)
Message-Id: <20180312.210655.1112108258912491550.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, yxj790222@163.com, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: Fix dsa_is_user_port() test inversion
From: David Miller <davem@davemloft.net>
In-Reply-To: <1520895640-28139-1-git-send-email-f.fainelli@gmail.com>
References: <1520895640-28139-1-git-send-email-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 12 Mar 2018 16:00:40 -0700

> During the conversion to dsa_is_user_port(), a condition ended up being
> reversed, which would prevent the creation of any user port when using
> the legacy binding and/or platform data, fix that.
> 
> Fixes: 4a5b85ffe2a0 ("net: dsa: use dsa_is_user_port everywhere")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied and queued up for -stable, thanks Florian.
