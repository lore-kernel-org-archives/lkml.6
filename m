Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S937263AbeE2DGh (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 23:06:37 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:49054 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932502AbeE2DGd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 23:06:33 -0400
Date: Mon, 28 May 2018 23:06:31 -0400 (EDT)
Message-Id: <20180528.230631.1400838711386498433.davem@davemloft.net>
To: yangbo.lu@nxp.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, richardcochran@gmail.com,
        claudiu.manoil@nxp.com, robh+dt@kernel.org
Subject: Re: [PATCH 5/5] MAINTAINERS: add myself as maintainer for QorIQ
 PTP clock driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180525044038.37756-5-yangbo.lu@nxp.com>
References: <20180525044038.37756-1-yangbo.lu@nxp.com>
        <20180525044038.37756-5-yangbo.lu@nxp.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangbo Lu <yangbo.lu@nxp.com>
Date: Fri, 25 May 2018 12:40:38 +0800

> Added myself as maintainer for QorIQ PTP clock driver.
> Since gianfar_ptp.c was renamed to ptp_qoriq.c, let's
> also maintain it under QorIQ PTP clock driver.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Because of the dependency on the staging tree changes, this
doesn't apply cleanly to net-next.

You'll have to figure out how you want to sort this out.
