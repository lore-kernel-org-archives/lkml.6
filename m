Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934040AbeCGRke (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:40:34 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:54684 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933415AbeCGRkb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:40:31 -0500
Date: Wed, 07 Mar 2018 12:40:29 -0500 (EST)
Message-Id: <20180307.124029.619020251426137855.davem@davemloft.net>
To: jbrunet@baylibre.com
Cc: andrew@lunn.ch, f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org
Subject: Re: [PATCH net-next] net: phy: mdio-mux: slience probe defer error
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180306111045.19315-1-jbrunet@baylibre.com>
References: <20180306111045.19315-1-jbrunet@baylibre.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jerome Brunet <jbrunet@baylibre.com>
Date: Tue,  6 Mar 2018 12:10:45 +0100

> If we fail to register the mdio bus due to probe defer, we should not
> print an error message. Just be silent in this case.
> 
> Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>

Applied, thanks Jerome.
