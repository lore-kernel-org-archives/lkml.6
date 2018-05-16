Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751695AbeEPSPT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 14:15:19 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:43378 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750759AbeEPSPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 14:15:16 -0400
Date: Wed, 16 May 2018 14:15:14 -0400 (EDT)
Message-Id: <20180516.141514.1102545495330180859.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/3] net: Allow more drivers with COMPILE_TEST
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180515234825.11240-1-f.fainelli@gmail.com>
References: <20180515234825.11240-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 15 May 2018 16:48:22 -0700

> This patch series includes more drivers to be build tested with COMPILE_TEST
> enabled. This helps cover some of the issues I just ran into with missing
> a driver *sigh*.

Thank you for doing this.

Series applied.
