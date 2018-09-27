Return-Path: <SRS0=J4ua=MJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83026C43382
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:16:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B6D72157C
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Sep 2018 03:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B6D72157C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726681AbeI0JdA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Sep 2018 05:33:00 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37566 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbeI0JdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Sep 2018 05:33:00 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id F2EA814547F75;
        Wed, 26 Sep 2018 20:16:56 -0700 (PDT)
Date:   Wed, 26 Sep 2018 20:16:56 -0700 (PDT)
Message-Id: <20180926.201656.67517716763683775.davem@davemloft.net>
To:     natechancellor@gmail.com
Cc:     Ariel.Elior@cavium.com, everest-linux-l2@cavium.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] qed: Avoid implicit enum conversion in
 qed_set_tunn_cls_info
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180924205334.7337-1-natechancellor@gmail.com>
References: <20180924205334.7337-1-natechancellor@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 26 Sep 2018 20:16:57 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nathan Chancellor <natechancellor@gmail.com>
Date: Mon, 24 Sep 2018 13:53:34 -0700

> Clang warns when one enumerated type is implicitly converted to another.
 ...
> Link: https://github.com/ClangBuiltLinux/linux/issues/125
> Signed-off-by: Nathan Chancellor <natechancellor@gmail.com>

Applied.
