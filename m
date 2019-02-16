Return-Path: <SRS0=3DzG=QX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 285A7C43381
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:32:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF14B222D9
	for <linux-kernel@archiver.kernel.org>; Sat, 16 Feb 2019 04:32:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394509AbfBPEco (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 23:32:44 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:49532 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726052AbfBPEco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 23:32:44 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 262CB14F126CA;
        Fri, 15 Feb 2019 20:32:43 -0800 (PST)
Date:   Fri, 15 Feb 2019 20:32:42 -0800 (PST)
Message-Id: <20190215.203242.1751897990893074948.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, shuah@kernel.org, idosch@mellanox.com,
        jiri@mellanox.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] selftests: forwarding: Add some missing
 configuration symbols
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190215181457.21101-1-f.fainelli@gmail.com>
References: <20190215181457.21101-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 15 Feb 2019 20:32:43 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Fri, 15 Feb 2019 10:14:52 -0800

> For the forwarding selftests to work, we need network namespaces when
> using veth/vrf otherwise ping/ping6 commands like these:
> 
> ip vrf exec vveth0 /bin/ping 192.0.2.2 -c 10 -i 0.1 -w 5
> 
> will fail because network namespaces may not be enabled.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

Applied.
