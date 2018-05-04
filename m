Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751941AbeEDRjU (ORCPT <rfc822;w@1wt.eu>);
        Fri, 4 May 2018 13:39:20 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:36428 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751443AbeEDRjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 May 2018 13:39:19 -0400
Date: Fri, 04 May 2018 13:39:17 -0400 (EDT)
Message-Id: <20180504.133917.166242157820470842.davem@davemloft.net>
To: bigeasy@linutronix.de
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
Subject: Re: [PATCH 4/4] ide: don't enable/disable interrupts in force
 threaded-IRQ mode
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180504142446.30525-5-bigeasy@linutronix.de>
References: <20180504142446.30525-1-bigeasy@linutronix.de>
        <20180504142446.30525-5-bigeasy@linutronix.de>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Date: Fri,  4 May 2018 16:24:46 +0200

> The interrupts are enabled/disabled so the interrupt handler can run
> with enabled interrupts while serving the interrupt and not lose other
> interrupts especially the timer tick.
> If the system runs with force-threaded interrupts then there is no need
> to enable the interrupts.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

Acked-by: David S. Miller <davem@davemloft.net>
