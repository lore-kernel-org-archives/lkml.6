Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161341AbeE2DGQ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 28 May 2018 23:06:16 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:49036 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161186AbeE2DGJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 May 2018 23:06:09 -0400
Date: Mon, 28 May 2018 23:06:06 -0400 (EDT)
Message-Id: <20180528.230606.706036464221125474.davem@davemloft.net>
To: yangbo.lu@nxp.com
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, richardcochran@gmail.com,
        claudiu.manoil@nxp.com, robh+dt@kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: ptp: add ptp-qoriq.txt
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180525044038.37756-4-yangbo.lu@nxp.com>
References: <20180525044038.37756-1-yangbo.lu@nxp.com>
        <20180525044038.37756-4-yangbo.lu@nxp.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangbo Lu <yangbo.lu@nxp.com>
Date: Fri, 25 May 2018 12:40:37 +0800

> This patch is to add a documentation for ptp_qoriq dt-bindings.
> The description for ptp_qoriq dt-bindings was actually moved
> from Documentation/devicetree/bindings/net/fsl-tsec-phy.txt,
> since gianfar_ptp driver was moved to ptp_qoriq driver.
> 
> Signed-off-by: Yangbo Lu <yangbo.lu@nxp.com>

Applied.
