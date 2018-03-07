Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934104AbeCGRTK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 12:19:10 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:54370 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933278AbeCGRTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 12:19:08 -0500
Date: Wed, 07 Mar 2018 12:19:05 -0500 (EST)
Message-Id: <20180307.121905.1363133433451256877.davem@davemloft.net>
To: brandon.streiff@ni.com
Cc: andrew@lunn.ch, vivien.didelot@savoirfairelinux.com,
        robh+dt@kernel.org, mark.rutland@arm.com, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: dsa: marvell: describe
 compatibility string
From: David Miller <davem@davemloft.net>
In-Reply-To: <1520287522-308-1-git-send-email-brandon.streiff@ni.com>
References: <1520287522-308-1-git-send-email-brandon.streiff@ni.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brandon Streiff <brandon.streiff@ni.com>
Date: Mon, 5 Mar 2018 16:05:22 -0600

> There are two compatibility strings for mv88e6xxx, but it isn't clear
> from the documentation why only those two exist when the mv88e6xxx driver
> supports more than the 6085 and 6190. Briefly describe how the compatible
> property is used, and provide guidance on which to use.
> 
> The model list comes from looking at port_base_addr values (0x0 vs 0x10)
> in drivers/net/dsa/mv88e6xxx/chip.c.
> 
> Signed-off-by: Brandon Streiff <brandon.streiff@ni.com>

Applied.
