Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933609AbeD0PXl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 11:23:41 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:53372 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932879AbeD0PXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 11:23:24 -0400
Date: Fri, 27 Apr 2018 11:23:21 -0400 (EDT)
Message-Id: <20180427.112321.1722845947622725407.davem@davemloft.net>
To: maxime.chevallier@bootlin.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        antoine.tenart@bootlin.com, thomas.petazzoni@bootlin.com,
        gregory.clement@bootlin.com, miquel.raynal@bootlin.com,
        nadavh@marvell.com, stefanc@marvell.com, ymarkman@marvell.com,
        mw@semihalf.com, linux@armlinux.org.uk,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH net v2 0/2] net: mvpp2: Fix hangs when starting some
 interfaces on 7k/8k
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180425182117.28826-1-maxime.chevallier@bootlin.com>
References: <20180425182117.28826-1-maxime.chevallier@bootlin.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Date: Wed, 25 Apr 2018 20:21:15 +0200

> Armada 7K / 8K clock management has recently been reworked, see :
> 
> commit c7e92def1ef4 ("clk: mvebu: cp110: Fix clock tree representation")
> 
> I have been experiencing overall system hangs on MacchiatoBin when starting
> the eth1 interface since then. It turns out some clocks dependencies were
> missing in the PPv2 and xmdio driver, the clock rework made this visible.
> 
> This is the V2 series, that adds support for the missing 'MG Core clock' in
> mvpp2, and fixes an issue with the error path for the axi_clk.
> 
> Thanks to Gregory Clement for finding the root cause of this bug.
> 
> V2 : Remove all DT patches from this series, they will be merged through
>      the mvebu tree.

Series applied, thank you.
