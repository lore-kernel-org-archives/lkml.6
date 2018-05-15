Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752510AbeEOUsO (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 16:48:14 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:57818 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752304AbeEOUsN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 16:48:13 -0400
Date: Tue, 15 May 2018 16:45:02 -0400 (EDT)
Message-Id: <20180515.164502.1934826189006257590.davem@davemloft.net>
To: alexandre.belloni@bootlin.com
Cc: Allan.Nielsen@microsemi.com, razvan.stefanescu@nxp.com, po.liu@nxp.com,
        thomas.petazzoni@bootlin.com, andrew@lunn.ch, f.fainelli@gmail.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, jhogan@kernel.org
Subject: Re: [PATCH net-next v3 0/7] Microsemi Ocelot Ethernet switch
 support
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180514200500.2953-1-alexandre.belloni@bootlin.com>
References: <20180514200500.2953-1-alexandre.belloni@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Date: Mon, 14 May 2018 22:04:53 +0200

> The ocelot dts changes are here for reference and should probably go
> through the MIPS tree once the bindings are accepted.

Ok, series applied to net-next minus patches #5 and #6.

Thank you.
