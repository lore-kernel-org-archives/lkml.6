Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752721AbeDHQpH (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 12:45:07 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:51800 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751845AbeDHQpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 12:45:06 -0400
Date: Sun, 08 Apr 2018 12:45:03 -0400 (EDT)
Message-Id: <20180408.124503.332537054164377764.davem@davemloft.net>
To: esben.haabendal@gmail.com
Cc: netdev@vger.kernel.org, eha@deif.com, claudiu.manoil@freescale.com,
        robh+dt@kernel.org, mark.rutland@arm.com, garsilva@embeddedor.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] net/fsl_pq_mdio: Allow explicit speficition of
 TBIPA address
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180406123836.12019-1-esben.haabendal@gmail.com>
References: <20180406123836.12019-1-esben.haabendal@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Esben Haabendal <esben.haabendal@gmail.com>
Date: Fri,  6 Apr 2018 14:38:34 +0200

> From: Esben Haabendal <eha@deif.com>
> 
> This introduces a simpler and generic method for for finding (and mapping)
> the TBIPA register.
> 
> Instead of relying of complicated logic for finding the TBIPA register
> address based on the MDIO or MII register block base
> address, which even in some cases relies on undocumented shadow registers,
> a second "reg" entry for the mdio bus devicetree node specifies the TBIPA
> register.
> 
> Backwards compatibility is kept, as the existing logic is applied when
> only a single "reg" mapping is specified.
> 
> Signed-off-by: Esben Haabendal <eha@deif.com>

Applied.
