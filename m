Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BFADC43382
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:15:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF941206B7
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:15:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF941206B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727254AbeI2Akc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 20:40:32 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:39894 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726657AbeI2Akb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 20:40:31 -0400
Received: from localhost (c-24-18-158-142.hsd1.wa.comcast.net [24.18.158.142])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EFBA514787748;
        Fri, 28 Sep 2018 11:15:33 -0700 (PDT)
Date:   Fri, 28 Sep 2018 11:15:33 -0700 (PDT)
Message-Id: <20180928.111533.1894085157685911248.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     Ariel.Elior@cavium.com, everest-linux-l2@cavium.com,
        netdev@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qed: fix spelling mistake "b_cb_registred" ->
 "b_cb_registered"
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180927170454.7829-1-colin.king@canonical.com>
References: <20180927170454.7829-1-colin.king@canonical.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 28 Sep 2018 11:15:34 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Thu, 27 Sep 2018 18:04:54 +0100

> From: Colin Ian King <colin.king@canonical.com>
> 
> Trivial fix to spelling mistake struct field name, rename it.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied to net-next, thanks Colin.
