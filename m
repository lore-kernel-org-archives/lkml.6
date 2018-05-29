Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161247AbeE2DGG (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 23:06:06 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:49028 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161186AbeE2DGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 23:06:03 -0400
Date: Mon, 28 May 2018 23:06:00 -0400 (EDT)
Message-Id: <20180528.230600.1937722626242005505.davem@davemloft.net>
To: yangbo.lu@nxp.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, richardcochran@gmail.com,
        claudiu.manoil@nxp.com, robh+dt@kernel.org
Subject: Re: [PATCH 3/5] net: ethernet: gianfar_ethtool: get phc index
 through drvdata
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180525044038.37756-3-yangbo.lu@nxp.com>
References: <20180525044038.37756-1-yangbo.lu@nxp.com>
        <20180525044038.37756-3-yangbo.lu@nxp.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangbo Lu <yangbo.lu@nxp.com>
Date: Fri, 25 May 2018 12:40:36 +0800

> Global variable gfar_phc_index was used to get and store
> phc index through gianfar_ptp driver. However gianfar_ptp
> had been renamed as ptp_qoriq for QorIQ common PTP driver.
> This gfar_phc_index doesn't work any more, and the phc index
> is stored in drvdata now. This patch is to support getting
> phc index through ptp_qoriq drvdata.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Applied.
