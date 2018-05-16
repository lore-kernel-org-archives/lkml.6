Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751868AbeEPSMV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 14:12:21 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:43298 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750847AbeEPSMU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 14:12:20 -0400
Date: Wed, 16 May 2018 14:12:18 -0400 (EDT)
Message-Id: <20180516.141218.827550466386531999.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch,
        vivien.didelot@savoirfairelinux.com, linux-kernel@vger.kernel.org,
        opendmb@gmail.com
Subject: Re: [PATCH net v2 0/3] net: dsa: bcm_sf2: CFP fixes
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180515230125.25886-1-f.fainelli@gmail.com>
References: <20180515230125.25886-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 15 May 2018 16:01:22 -0700

> This patch series fixes a number of usability issues with the SF2 Compact Field
> Processor code:
> 
> - we would not be properly bound checking the location when we let the kernel
>   automatically place rules with RX_CLS_LOC_ANY
> 
> - when using IPv6 rules and user space specifies a location identifier we
>   would be off by one in what the chain ID (within the Broadcom tag) indicates
> 
> - it would be possible to delete one of the two slices of an IPv6 while leaving
>   the other one programming leading to various problems

Series applied, thanks.

Queue up for -stable?
