Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751112AbeEUUSk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 16:18:40 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:59928 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750837AbeEUUSh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 16:18:37 -0400
Date: Mon, 21 May 2018 16:18:32 -0400 (EDT)
Message-Id: <20180521.161832.85473627565332598.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, grygorii.strashko@ti.com,
        ivan.khoronzhuk@linaro.org, akpm@linux-foundation.org,
        j-keerthy@ti.com, bhumirks@gmail.com, hernan@vanguardiasur.com.ar,
        richardcochran@gmail.com, lukas@wunner.de, robh@kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/5] TI Ethernet driver warnings fixes
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180521184555.21555-1-f.fainelli@gmail.com>
References: <20180521184555.21555-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 21 May 2018 11:45:50 -0700

> Hi all,
> 
> This patch series attempts to fix properly the warnings observed with turning
> on COMPILE_TEST and TI Ethernet drivers on 64-bit hosts.
> 
> Since I don't have any of this hardware, please review carefully for possible
> breakage!

These seem extremely safe to me, and since I have a vested interest in seeing
these warning disappear from my tree....

Series applied, thanks :-)
