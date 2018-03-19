Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754689AbeCSAMj (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 20:12:39 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:33072 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754531AbeCSAMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 20:12:34 -0400
Date: Sun, 18 Mar 2018 20:12:28 -0400 (EDT)
Message-Id: <20180318.201228.2201277107982982829.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, l.stach@pengutronix.de,
        fugang.duan@nxp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: fec: Fix unbalanced PM runtime calls
From: David Miller <davem@davemloft.net>
In-Reply-To: <f1ba3f3e-adef-c7f0-d9b2-47bbdade91f5@gmail.com>
References: <20180318194952.31411-1-f.fainelli@gmail.com>
        <20180318.163501.2001276876693998811.davem@davemloft.net>
        <f1ba3f3e-adef-c7f0-d9b2-47bbdade91f5@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Sun, 18 Mar 2018 14:42:22 -0700

> On 03/18/2018 01:35 PM, David Miller wrote:
>> Queue this up for -stable?
> 
> I would be inclined to say yes, it was not exactly easy to track down a
> set of commits, since this was changed quite a bit.

Ok, queued up.
