Return-Path: <SRS0=NGUq=QT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58F21C282CA
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:50:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 359B5222C4
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Feb 2019 17:50:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730776AbfBLRud (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Feb 2019 12:50:33 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:55414 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728438AbfBLRuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Feb 2019 12:50:32 -0500
Received: from localhost (96-89-128-221-static.hfc.comcastbusiness.net [96.89.128.221])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 4077414C3E2E1;
        Tue, 12 Feb 2019 09:50:31 -0800 (PST)
Date:   Tue, 12 Feb 2019 09:50:30 -0800 (PST)
Message-Id: <20190212.095030.1445077555795164973.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, idosch@mellanox.com,
        linux-kernel@vger.kernel.org, devel@driverdev.osuosl.org,
        bridge@lists.linux-foundation.org, jiri@mellanox.com,
        andrew@lunn.ch, vivien.didelot@gmail.com
Subject: Re: [PATCH net-next 0/3] Remove getting
 SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190211211749.19847-1-f.fainelli@gmail.com>
References: <20190211211749.19847-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 12 Feb 2019 09:50:31 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Mon, 11 Feb 2019 13:17:46 -0800

> AFAICT there is no code that attempts to get the value of the attribute
> SWITCHDEV_ATTR_ID_PORT_BRIDGE_FLAGS while it is used with
> switchdev_port_attr_set().
> 
> This is effectively no doing anything and it can slow down future work
> that tries to make modifications in these areas so remove that.

Series applied.

> David, there should be no dependency with previous patch series, but
> again, feedback from Ido and Jiri would be welcome in case this was
> added for a reason.

Ok, is there going to be another respin of that switchdev_ops removal
series?
