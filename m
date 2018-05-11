Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751579AbeEKUga (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 16:36:30 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:50616 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750972AbeEKUg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 16:36:29 -0400
Date: Fri, 11 May 2018 16:36:28 -0400 (EDT)
Message-Id: <20180511.163628.791935735291449158.davem@davemloft.net>
To: dmurphy@ti.com
Cc: andrew@lunn.ch, f.fainelli@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] net: phy: DP83TC811: Introduce support for the
 DP83TC811 phy
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180511180819.5036-1-dmurphy@ti.com>
References: <20180511180819.5036-1-dmurphy@ti.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Murphy <dmurphy@ti.com>
Date: Fri, 11 May 2018 13:08:19 -0500

> Add support for the DP83811 phy.
> 
> The DP83811 supports both rgmii and sgmii interfaces.
> There are 2 part numbers for this the DP83TC811R does not
> reliably support the SGMII interface but the DP83TC811S will.
> 
> There is not a way to differentiate these parts from the
> hardware or register set.  So this is controlled via the DT
> to indicate which phy mode is required.  Or the part can be
> strapped to a certain interface.
> 
> Data sheet can be found here:
> http://www.ti.com/product/DP83TC811S-Q1/description
> http://www.ti.com/product/DP83TC811R-Q1/description
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>

Applied to net-next, thank you.
