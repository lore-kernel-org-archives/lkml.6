Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752195AbeENSuI (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 14:50:08 -0400
Received: from shards.monkeyblade.net ([184.105.139.130]:40088 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751422AbeENSuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 14:50:06 -0400
Date: Mon, 14 May 2018 14:50:04 -0400 (EDT)
Message-Id: <20180514.145004.1655310548325135142.davem@davemloft.net>
To: vivien.didelot@savoirfairelinux.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@savoirfairelinux.com, andrew@lunn.ch, f.fainelli@gmail.com
Subject: Re: [PATCH net-next 0/3] net: dsa: mv88e6xxx: remove Global 1 setup
From: David Miller <davem@davemloft.net>
In-Reply-To: <20180511211636.25995-1-vivien.didelot@savoirfairelinux.com>
References: <20180511211636.25995-1-vivien.didelot@savoirfairelinux.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vivien Didelot <vivien.didelot@savoirfairelinux.com>
Date: Fri, 11 May 2018 17:16:33 -0400

> The mv88e6xxx driver is still writing arbitrary registers at setup time,
> e.g. priority override bits. Add ops for them and provide specific setup
> functions for priority and stats before getting rid of the erroneous
> mv88e6xxx_g1_setup code, as previously done with Global 2.

Series applied, thanks Vivien.
