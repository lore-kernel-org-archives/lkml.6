Return-Path: <SRS0=4Txr=QO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 222FFC282C2
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:48:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E5AFD2073D
	for <linux-kernel@archiver.kernel.org>; Thu,  7 Feb 2019 03:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726700AbfBGDsn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 Feb 2019 22:48:43 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:40298 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbfBGDsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Feb 2019 22:48:42 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id DD18B14017AC1;
        Wed,  6 Feb 2019 19:48:41 -0800 (PST)
Date:   Wed, 06 Feb 2019 19:48:41 -0800 (PST)
Message-Id: <20190206.194841.1230954195969874310.davem@davemloft.net>
To:     helgaas@kernel.org
Cc:     aleksey.makarov@cavium.com, rad@semihalf.com, pombredanne@nexb.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] net: Don't default Cavium PTP driver to 'y'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <154939964148.34496.18016063453530224332.stgit@bhelgaas-glaptop.roam.corp.google.com>
References: <154939964148.34496.18016063453530224332.stgit@bhelgaas-glaptop.roam.corp.google.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 06 Feb 2019 19:48:42 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bjorn Helgaas <helgaas@kernel.org>
Date: Tue, 05 Feb 2019 14:47:21 -0600

> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> 8c56df372bc1 ("net: add support for Cavium PTP coprocessor") added the
> Cavium PTP coprocessor driver and enabled it by default.  Remove the
> "default y" because the driver only applies to Cavium ThunderX processors.
> 
> Fixes: 8c56df372bc1 ("net: add support for Cavium PTP coprocessor")
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>

Applied.
