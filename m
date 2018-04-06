Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751949AbeDFRhc (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 13:37:32 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:45272 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750807AbeDFRhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 13:37:31 -0400
Date: Fri, 06 Apr 2018 13:37:24 -0400 (EDT)
Message-Id: <20180406.133724.732891873487338396.davem@davemloft.net>
To: andrew@lunn.ch
Cc: esben.haabendal@gmail.com, netdev@vger.kernel.org, eha@deif.com,
        rasmus.villemoes@prevas.dk, f.fainelli@gmail.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] net: phy: marvell: Enable interrupt function on
 LED2 pin
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180406172928.GS17495@lunn.ch>
References: <20180405133504.12257-1-esben.haabendal@gmail.com>
        <20180405204029.665-1-esben.haabendal@gmail.com>
        <20180406172928.GS17495@lunn.ch>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Fri, 6 Apr 2018 19:29:28 +0200

> On Thu, Apr 05, 2018 at 10:40:29PM +0200, Esben Haabendal wrote:
>> From: Esben Haabendal <eha@deif.com>
>> 
>> The LED2[2]/INTn pin on Marvell 88E1318S as well as 88E1510/12/14/18 needs
>> to be configured to be usable as interrupt not only when WOL is enabled,
>> but whenever we rely on interrupts from the PHY.
>> 
>> Signed-off-by: Esben Haabendal <eha@deif.com>
>> Cc: Rasmus Villemoes <rasmus.villemoes@prevas.dk>
> 
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Applied, thanks everyone.
