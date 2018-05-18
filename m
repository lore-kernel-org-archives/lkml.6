Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752229AbeERQJQ (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 12:09:16 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:46802 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751221AbeERQJG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 12:09:06 -0400
Date: Fri, 18 May 2018 12:09:04 -0400 (EDT)
Message-Id: <20180518.120904.2177695334432964567.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, jiri@resnulli.us, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: dsa: Do not register devlink for unused
 ports
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180517235539.19418-1-f.fainelli@gmail.com>
References: <20180517235539.19418-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Thu, 17 May 2018 16:55:39 -0700

> Even if commit 1d27732f411d ("net: dsa: setup and teardown ports") indicated
> that registering a devlink instance for unused ports is not a problem, and this
> is true, this can be confusing nonetheless, so let's not do it.
> 
> Fixes: 1d27732f411d ("net: dsa: setup and teardown ports")
> Reported-by: Jiri Pirko <jiri@resnulli.us>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied and queued up for -stable, thanks!
