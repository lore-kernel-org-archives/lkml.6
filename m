Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933984AbeEWSev (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 14:34:51 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:32926 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933291AbeEWSet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 14:34:49 -0400
Date: Wed, 23 May 2018 14:34:47 -0400 (EDT)
Message-Id: <20180523.143447.200125497788988369.davem@davemloft.net>
To: antoine.tenart@bootlin.com
Cc: linux@armlinux.org.uk, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        maxime.chevallier@bootlin.com, gregory.clement@bootlin.com,
        miquel.raynal@bootlin.com, nadavh@marvell.com, stefanc@marvell.com,
        ymarkman@marvell.com, mw@semihalf.com
Subject: Re: [PATCH net-next v2 0/3] net: sfp: small improvements
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180522101801.18947-1-antoine.tenart@bootlin.com>
References: <20180522101801.18947-1-antoine.tenart@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Antoine Tenart <antoine.tenart@bootlin.com>
Date: Tue, 22 May 2018 12:17:58 +0200

> A small series of patches improving the SFP support by adding a warning
> when no Tx disable pin is available, and making the i2c-bus property
> mandatory.
 ...
> Since v1:
>   - Removed the patch fixing the sfp driver when no i2c bus was described.
>   - Made two new patches to make the i2c-bus property mandatory for sfp modules.

Series applied, thank you.
