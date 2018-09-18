Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB49ECE563
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:46:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C3312083A
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 01:46:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C3312083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbeIRHQ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 03:16:28 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:53824 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbeIRHQ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 03:16:28 -0400
Received: from localhost (unknown [104.240.4.228])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 85CD014530F75;
        Mon, 17 Sep 2018 18:46:22 -0700 (PDT)
Date:   Mon, 17 Sep 2018 18:46:22 -0700 (PDT)
Message-Id: <20180917.184622.39961415058381467.davem@davemloft.net>
To:     kai.heng.feng@canonical.com
Cc:     nic_swsd@realtek.com, hkallweit1@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] r8169: enable ASPM on RTL8106E
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180912065821.7198-2-kai.heng.feng@canonical.com>
References: <20180912065821.7198-1-kai.heng.feng@canonical.com>
        <20180912065821.7198-2-kai.heng.feng@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 17 Sep 2018 18:46:22 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Date: Wed, 12 Sep 2018 14:58:21 +0800

> The Intel SoC was prevented from entering lower idle state because
> of RTL8106E's ASPM was not enabled.
> 
> So enable ASPM on RTL8106E (chip version 39).
> Now the Intel SoC can enter lower idle state, power consumption and
> temperature are much lower.
> 
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied.
