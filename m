Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C07DECE562
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4BFDF2083A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:46:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4BFDF2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728893AbeIRHQX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 03:16:23 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53812 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbeIRHQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 03:16:23 -0400
Received: from localhost (unknown [104.240.4.228])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BC41114530F75;
        Mon, 17 Sep 2018 18:46:17 -0700 (PDT)
Date:   Mon, 17 Sep 2018 18:46:17 -0700 (PDT)
Message-Id: <20180917.184617.2024491375680695156.davem@davemloft.net>
To:     kai.heng.feng@canonical.com
Cc:     nic_swsd@realtek.com, hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] r8169: Align ASPM/CLKREQ setting function with
 vendor driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180912065821.7198-1-kai.heng.feng@canonical.com>
References: <20180912065821.7198-1-kai.heng.feng@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 17 Sep 2018 18:46:17 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 12 Sep 2018 14:58:20 +0800

> There's a small delay after setting ASPM in vendor drivers, r8101 and
> r8168.
> In addition, those drivers enable ASPM before ClkReq, also change that
> to align with vendor driver.
> 
> I haven't seen anything bad becasue of this, but I think it's better to
> keep in sync with vendor driver.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied.
