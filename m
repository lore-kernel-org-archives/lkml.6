Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753917AbeDMCGX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 22:06:23 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:60760 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752298AbeDMCGW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 22:06:22 -0400
Date: Thu, 12 Apr 2018 22:06:20 -0400 (EDT)
Message-Id: <20180412.220620.99394562394719633.davem@davemloft.net>
To: richardcochran@gmail.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, andrew@lunn.ch,
        f.fainelli@gmail.com, vivien.didelot@savoirfairelinux.com
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: Fix receive time stamp race
 condition.
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180412173540.rrjx5n62guchety2@localhost>
References: <20180409070314.12409-1-richardcochran@gmail.com>
        <20180409141931.kmltk4hridkj5fsk@localhost>
        <20180412173540.rrjx5n62guchety2@localhost>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Cochran <richardcochran@gmail.com>
Date: Thu, 12 Apr 2018 10:35:40 -0700

> On Mon, Apr 09, 2018 at 07:19:31AM -0700, Richard Cochran wrote:
>> Dave, please hold off on this patch.  I am seeing new problems in my
>> testing with this applied.  I still need to get to the bottom of
>> this.
> 
> Looks like the new problems are a HW/board glitch.
> 
> The patch is good to go.

Ok, applied and queued up for -stable.

Thanks.
