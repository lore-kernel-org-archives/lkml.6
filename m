Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752623AbeEJUNP (ORCPT <rfc822;w@1wt.eu>);
        Thu, 10 May 2018 16:13:15 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:36730 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752101AbeEJUNM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 May 2018 16:13:12 -0400
Date: Thu, 10 May 2018 16:13:10 -0400 (EDT)
Message-Id: <20180510.161310.1711109503750888571.davem@davemloft.net>
To: vivien.didelot@savoirfairelinux.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@savoirfairelinux.com, andrew@lunn.ch, f.fainelli@gmail.com
Subject: Re: [PATCH net-next 0/3] net: dsa: mv88e6xxx: cleanup Global
 Control 2 register
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180509153851.10207-1-vivien.didelot@savoirfairelinux.com>
References: <20180509153851.10207-1-vivien.didelot@savoirfairelinux.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Wed,  9 May 2018 11:38:48 -0400

> The mv88e6xxx driver still writes arbitrary values in the Global 1
> Control 2 register at setup, which layout differs a lot between chips.
> This results in an inconsistent configuration, for example with the
> Remote Management Unit (RMU).
> 
> The first patch adds an operation for the Cascade Port bits, the second
> patch sets the device number in the device mapping function and the
> third patch adds an operation to correctly disable the RMU.

Series applied.
