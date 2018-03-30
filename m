Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751258AbeC3KWl (ORCPT <rfc822;w@1wt.eu>);
        Fri, 30 Mar 2018 06:22:41 -0400
Received: from mail.bootlin.com ([62.4.15.54]:35382 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750765AbeC3KWk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Mar 2018 06:22:40 -0400
Date: Fri, 30 Mar 2018 12:22:27 +0200
From: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To: Gregory CLEMENT <gregory.clement@bootlin.com>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, Antoine Tenart <antoine.tenart@bootlin.com>,
        =?UTF-8?B?TWlxdcOobA==?= Raynal <miquel.raynal@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>, stefanc@marvell.com,
        ymarkman@marvell.com, Yelena Krivosheev <yelena@marvell.com>
Subject: Re: [PATCH] net: mvneta: fix enable of all initialized RXQs
Message-ID: <20180330122227.02c64a7a@windsurf>
In-Reply-To: <20180330100531.5995-1-gregory.clement@bootlin.com>
References: <20180330100531.5995-1-gregory.clement@bootlin.com>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.15.1-dirty (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Fri, 30 Mar 2018 12:05:31 +0200, Gregory CLEMENT wrote:
> From: Yelena Krivosheev <yelena@marvell.com>
> 
> In mvneta_port_up() we enable relevant RX and TX port queues by write
> queues bit map to an appropriate register.
> 
> q_map must be ZERO in the beginning of this process.
> 
> Signed-off-by: Yelena Krivosheev <yelena@marvell.com>
> Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>

Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
