Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F72C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:34:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AEB9020684
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:34:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEB9020684
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbeJCMVZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:21:25 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54704 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeJCMVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:21:25 -0400
Received: from localhost (c-67-183-145-105.hsd1.wa.comcast.net [67.183.145.105])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 15EAC142B4707;
        Tue,  2 Oct 2018 22:34:36 -0700 (PDT)
Date:   Tue, 02 Oct 2018 22:34:35 -0700 (PDT)
Message-Id: <20181002.223435.525347724145264567.davem@davemloft.net>
To:     alex_y_xu@yahoo.ca
Cc:     netdev@vger.kernel.org, hkallweit1@gmail.com, nic_swsd@realtek.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] r8169: always autoneg on resume
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1538319728.z22jaatdgh.astroid@alex-desktop.none>
References: <1538319728.z22jaatdgh.astroid@alex-desktop.none>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 02 Oct 2018 22:34:36 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Alex Xu (Hello71)" <alex_y_xu@yahoo.ca>
Date: Sun, 30 Sep 2018 11:06:39 -0400

> This affects at least versions 25 and 33, so assume all cards are broken
> and just renegotiate by default.
> 
> Fixes: 10bc6a6042c9 ("r8169: fix autoneg issue on resume with RTL8168E")
> Signed-off-by: Alex Xu (Hello71) <alex_y_xu@yahoo.ca>

Applied.
