Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751972AbeELADT (ORCPT <rfc822;w@1wt.eu>);
        Fri, 11 May 2018 20:03:19 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:52408 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751263AbeELADS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 May 2018 20:03:18 -0400
Date: Fri, 11 May 2018 20:03:14 -0400 (EDT)
Message-Id: <20180511.200314.443537371627942204.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: bcm_sf2: Fix RX_CLS_LOC_ANY overwrite
 for last rule
From: David Miller <davem@davemloft.net>
In-Reply-To: <a6a1c828-567a-9b4c-01ae-d9b204dc1ffe@gmail.com>
References: <20180511232459.15980-1-f.fainelli@gmail.com>
        <a6a1c828-567a-9b4c-01ae-d9b204dc1ffe@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri, 11 May 2018 16:38:02 -0700

> David, please discard that for now, the IPv4 part is correct, but I am
> not fixing the bug correctly for the IPv6 part. v2 coming some time next
> week. Thank you!

Ok.
