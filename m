Return-Path: <SRS0=aqUf=NR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70084C32789
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:10:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 465E520827
	for <linux-kernel@archiver.kernel.org>; Tue,  6 Nov 2018 19:10:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 465E520827
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388260AbeKGEhg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 23:37:36 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:51038 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730406AbeKGEhg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 23:37:36 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2B43714543EE3;
        Tue,  6 Nov 2018 11:04:11 -0800 (PST)
Date:   Tue, 06 Nov 2018 11:04:10 -0800 (PST)
Message-Id: <20181106.110410.2119360943759218112.davem@davemloft.net>
To:     olof@lixom.net
Cc:     isdn@linux-pingi.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, isdn4linux@listserv.isdn4linux.de,
        mac@melware.de
Subject: Re: [PATCH v2] ISDN: eicon: Remove driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181102220026.6387-1-olof@lixom.net>
References: <20181102215047.6048-1-olof@lixom.net>
        <20181102220026.6387-1-olof@lixom.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 06 Nov 2018 11:04:11 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Olof Johansson <olof@lixom.net>
Date: Fri,  2 Nov 2018 15:00:26 -0700

> I started looking at the history of this driver, and last time the
> maintainer was active on the mailing list was when discussing how to
> remove it. This was in 2012:
> 
> https://lore.kernel.org/lkml/4F4DE175.30002@melware.de/
> 
> It looks to me like this has in practice been an orphan for quite a while.
> It's throwing warnings about stack size in a function that is in dire
> need of refactoring, and it's probably a case of "it's time to call it".
> 
> Cc: Armin Schindler <mac@melware.de>
> Cc: Karsten Keil <isdn@linux-pingi.de>
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
> 
> v2:
> Missed a git add of drivers/isdn/hardware/Kconfig

Applied to net-next.
