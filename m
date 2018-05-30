Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753926AbeE3R2D (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 13:28:03 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:44944 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753382AbeE3R2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 13:28:01 -0400
Date: Wed, 30 May 2018 13:27:59 -0400 (EDT)
Message-Id: <20180530.132759.1609983459551825219.davem@davemloft.net>
To: yangbo.lu@nxp.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, richardcochran@gmail.com,
        claudiu.manoil@nxp.com, robh+dt@kernel.org
Subject: Re: [v2] MAINTAINERS: add myself as maintainer for QorIQ PTP clock
 driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180529034744.44590-1-yangbo.lu@nxp.com>
References: <20180529034744.44590-1-yangbo.lu@nxp.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangbo Lu <yangbo.lu@nxp.com>
Date: Tue, 29 May 2018 11:47:44 +0800

> Added myself as maintainer for QorIQ PTP clock driver.
> Since gianfar_ptp.c was renamed to ptp_qoriq.c, let's
> maintain it under QorIQ PTP clock driver.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>
> ---
> Changes for v2:
> 	- Dropped dpaa2/rtc part.

Applied to net-next, thanks.
