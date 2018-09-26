Return-Path: <SRS0=3sEf=MI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33CA9C43382
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:27:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1D0D20833
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Sep 2018 03:27:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1D0D20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726664AbeIZJiL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Sep 2018 05:38:11 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:45712 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726250AbeIZJiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Sep 2018 05:38:11 -0400
Received: from localhost (unknown [104.240.4.228])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C161514277F73;
        Tue, 25 Sep 2018 20:27:25 -0700 (PDT)
Date:   Tue, 25 Sep 2018 20:27:25 -0700 (PDT)
Message-Id: <20180925.202725.1892289063907812837.davem@davemloft.net>
To:     f.fainelli@gmail.com
Cc:     netdev@vger.kernel.org, andrew@lunn.ch,
        linux-kernel@vger.kernel.org, dongsheng.wang@hxt-semitech.com,
        cphealy@gmail.com, clemens.gruber@pqgruber.com,
        hkallweit1@gmail.com, nbd@nbd.name, harini.katakam@xilinx.com
Subject: Re: [PATCH net-next 0/2] net: phy: Eliminate unnecessary soft
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180925182846.30042-1-f.fainelli@gmail.com>
References: <20180925182846.30042-1-f.fainelli@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 25 Sep 2018 20:27:26 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Florian Fainelli <f.fainelli@gmail.com>
Date: Tue, 25 Sep 2018 11:28:44 -0700

> This patch series eliminates unnecessary software resets of the PHY.
> This should hopefully not break anybody's hardware; but I would
> appreciate testing to make sure this is is the case.
> 
> Sorry for this long email list, I wanted to make sure I reached out to
> all people who made changes to the Marvell PHY driver.
> 
> Thank you!
> 
> Changes since RFT:
> 
> - added Tested-by tags from Wang, Dongsheng, Andrew, Chris and Clemens

Series applied.
