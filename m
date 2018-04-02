Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753189AbeDBRSW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 2 Apr 2018 13:18:22 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:40128 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753144AbeDBRSV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Apr 2018 13:18:21 -0400
Date: Mon, 02 Apr 2018 13:18:17 -0400 (EDT)
Message-Id: <20180402.131817.1826947706300918872.davem@davemloft.net>
To: f.fainelli@gmail.com
Cc: netdev@vger.kernel.org, scott.branden@broadcom.com, andrew@lunn.ch,
        abhishek.shah@broadcom.com, ray.jui@broadcom.com,
        linux-kernel@vger.kernel.org, jon.mason@broadcom.com, nbd@nbd.name
Subject: Re: [PATCH net 0/2] net: bgmac: Couple of sparse warnings
From: David Miller <davem@davemloft.net>
In-Reply-To: <f9e08df4-f9fa-25d1-ad3e-a0d221e92b6d@gmail.com>
References: <20180401172630.12883-1-f.fainelli@gmail.com>
        <20180401.222128.167330838381844376.davem@davemloft.net>
        <f9e08df4-f9fa-25d1-ad3e-a0d221e92b6d@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 2 Apr 2018 10:17:36 -0700

> On 04/01/2018 07:21 PM, David Miller wrote:
>> From: Florian Fainelli <f.fainelli@gmail.com>
>> Date: Sun,  1 Apr 2018 10:26:28 -0700
>> 
>>> This patch series fixes a couple of warnings reported by sparse, should not
>>> cause any functional problems since bgmac is typically used on LE platforms
>>> anyway.
>> 
>> Series applied, thanks Florian.
> 
> I did not see this in net/master or included in your recent pull request
> to Linus, not a big deal, but I just want to make sure this is not lost
> somewhere ;)

All changes go into net-next as I prepare for a merge window pull request.
