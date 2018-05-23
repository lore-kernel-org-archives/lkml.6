Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934719AbeEWTrf convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 15:47:35 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:34284 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934232AbeEWTrc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 15:47:32 -0400
Date: Wed, 23 May 2018 15:47:30 -0400 (EDT)
Message-Id: <20180523.154730.2218442546759769824.davem@davemloft.net>
To: vokac.m@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, f.fainelli@gmail.com,
        vivien.didelot@savoirfairelinux.com, andrew@lunn.ch,
        mark.rutland@arm.com, robh+dt@kernel.org, michal.vokac@ysoft.com
Subject: Re: [PATCH net-next v3 0/7] Add support for QCA8334 switch
From: David Miller <davem@davemloft.net>
In-Reply-To: <1527056424-14528-1-git-send-email-michal.vokac@ysoft.com>
References: <1527056424-14528-1-git-send-email-michal.vokac@ysoft.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-2
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Michal Vok·Ë" <vokac.m@gmail.com>
Date: Wed, 23 May 2018 08:20:17 +0200

> This series basically adds support for a QCA8334 ethernet switch to the
> qca8k driver. It is a four-port variant of the already supported seven
> port QCA8337. Register map is the same for the whole familly and all chips
> have the same device ID.
> 
> Major part of this series enhances the CPU port setting. Currently the CPU
> port is not set to any sensible defaults compatible with the xGMII
> interface. This series forces the CPU port to its maximum bandwidth and
> also allows to adjust the new defaults using fixed-link device tree
> sub-node.
> 
> Alongside these changes I fixed two checkpatch warnings regarding SPDX and
> redundant parentheses.
> 
> Changes in v3:
>  - Rebased on latest net-next/master.
>  - Corrected fixed-link documentation.

Series applied, thank you.
