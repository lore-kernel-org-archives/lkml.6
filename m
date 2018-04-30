Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753860AbeD3BAa (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 21:00:30 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:53776 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750826AbeD3BA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 21:00:29 -0400
Date: Sun, 29 Apr 2018 21:00:25 -0400 (EDT)
Message-Id: <20180429.210025.1829415202415126984.davem@davemloft.net>
To: vivien.didelot@savoirfairelinux.com
Cc: netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        linux-kernel@vger.kernel.org, kernel@savoirfairelinux.com
Subject: Re: [PATCH net-next 0/3] net: dsa: mv88e6xxx: remove Global 2 setup
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180427015646.24946-1-vivien.didelot@savoirfairelinux.com>
References: <20180427015646.24946-1-vivien.didelot@savoirfairelinux.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Thu, 26 Apr 2018 21:56:43 -0400

> Parts of the mv88e6xxx driver still write arbitrary registers of
> different banks at setup time, which is misleading especially when
> supporting multiple device models.
> 
> This patchset moves two features setup into the top lovel
> mv88e6xxx_setup function and kills the old Global 2 register bank setup
> function. It brings no functional changes.

Series applied, thanks Vivien.
