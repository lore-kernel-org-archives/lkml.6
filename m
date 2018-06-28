Return-Path: <SRS0=VxZE=JO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EE5FC43142
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:12:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E0DC42700A
	for <linux-kernel@archiver.kernel.org>; Thu, 28 Jun 2018 07:12:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0DC42700A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753567AbeF1HMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 Jun 2018 03:12:51 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46914 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751354AbeF1HMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jun 2018 03:12:50 -0400
Received: from localhost (unknown [211.196.191.92])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 56DCA10177610;
        Thu, 28 Jun 2018 00:12:45 -0700 (PDT)
Date:   Thu, 28 Jun 2018 16:12:43 +0900 (KST)
Message-Id: <20180628.161243.1522341952398584479.davem@davemloft.net>
To:     brandon.maier@rockwellcollins.com
Cc:     netdev@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        michal.simek@xilinx.com, clayton.shotwell@rockwellcollins.com,
        kristopher.cory@rockwellcollins.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: phy: xgmiitorgmii: Use correct
 mdio bus
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180626175050.71165-2-brandon.maier@rockwellcollins.com>
References: <20180626175050.71165-1-brandon.maier@rockwellcollins.com>
        <20180626175050.71165-2-brandon.maier@rockwellcollins.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 28 Jun 2018 00:12:49 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brandon Maier <brandon.maier@rockwellcollins.com>
Date: Tue, 26 Jun 2018 12:50:49 -0500

> The xgmiitorgmii is using the mii_bus of the device it's attached to,
> instead of the bus it was given during probe.
> 
> Signed-off-by: Brandon Maier <brandon.maier@rockwellcollins.com>

Applied.
