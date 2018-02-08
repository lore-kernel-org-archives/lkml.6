Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752176AbeBHCtV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 21:49:21 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:39428 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751175AbeBHCtT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 21:49:19 -0500
Date: Wed, 07 Feb 2018 21:49:16 -0500 (EST)
Message-Id: <20180207.214916.370684288901847015.davem@davemloft.net>
To: svendev@arcx.com
Cc: andrew@lunn.ch, f.fainelli@gmail.com, helmut.buchsbaum@gmail.com,
        Maarten.Blomme@flir.com, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [PATCH v1 1/1] spi_ks8995: use regmap to access chip registers.
From: David Miller <davem@davemloft.net>
In-Reply-To: <1517930036-17618-2-git-send-email-svendev@arcx.com>
References: <1517930036-17618-1-git-send-email-svendev@arcx.com>
        <1517930036-17618-2-git-send-email-svendev@arcx.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sven Van Asbroeck <svendev@arcx.com>
Date: Tue, 6 Feb 2018 10:13:56 -0500

> The register map layouts used in this driver are well suited to
> being accessed through a regmap. This makes the driver simpler
> and shorter, by eliminating some spi boilerplate code.
> 
> Testing:
> - tested on a ksz8785.
> - not tested on the other supported chips (ks8995, ksz8864)
>   because I don't have access to them.
>   However, I instrumented the spi layer to verify that the
>   correct spi transactions are generated to read the ID
>   registers on those chips.
> 
> Signed-off-by: Sven Van Asbroeck <svendev@arcx.com>

Please resubmit this simplification when the net-next tree opens
back up.

Thank you.
