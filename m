Return-Path: <SRS0=aodX=LQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03BC9C43334
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 00:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D4752083B
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Sep 2018 00:17:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D4752083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726020AbeIBEbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Sep 2018 00:31:05 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53994 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725790AbeIBEbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Sep 2018 00:31:05 -0400
Received: from localhost (unknown [174.127.142.226])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id B4B38143A4A37;
        Sat,  1 Sep 2018 17:17:22 -0700 (PDT)
Date:   Sat, 01 Sep 2018 17:17:21 -0700 (PDT)
Message-Id: <20180901.171721.704901072821653508.davem@davemloft.net>
To:     ruxandra.radulescu@nxp.com
Cc:     netdev@vger.kernel.org, gregkh@linuxfoundation.org, andrew@lunn.ch,
        devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org,
        ioana.ciornei@nxp.com, laurentiu.tudor@nxp.com,
        madalin.bucur@nxp.com, horia.geanta@nxp.com
Subject: Re: [PATCH net-next v2 0/2] dpaa2-eth: Move DPAA2 Ethernet driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180829094240.27242-1-ruxandra.radulescu@nxp.com>
References: <20180829094240.27242-1-ruxandra.radulescu@nxp.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 01 Sep 2018 17:17:23 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Radulescu <ruxandra.radulescu@nxp.com>
Date: Wed, 29 Aug 2018 04:42:38 -0500

> The Freescale/NXP DPAA2 Ethernet driver was first included in
> drivers/staging, due to its dependencies on two components located
> there at the time of its initial submission:
> * the fsl-mc bus driver, which was moved to drivers/bus in kernel 4.17
> * the dpio driver, which was moved to drivers/soc/fsl in kernel 4.18
> 
> More information on the DPAA2 architecture and the interactions
> between the fsl-mc bus and the objects present on it can be found in:
> Documentation/networking/dpaa2/overview.rst
> 
> For easier review, the patch is generated without the -M option,
> although the driver files are moved without any code changes.
> 
> changes since v1[1]:
> * remove RFC label, since dependencies have been merged on net-next
> * add patch fixing a possible race at probe (reported by Andrew Lunn)
> 
> [1] https://lore.kernel.org/patchwork/patch/971333/

Series applied, thank you.
