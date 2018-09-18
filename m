Return-Path: <SRS0=fL2C=MA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83139C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:32:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A508206B5
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Sep 2018 16:32:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A508206B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730321AbeIRWFw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Sep 2018 18:05:52 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:35516 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728631AbeIRWFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Sep 2018 18:05:52 -0400
Received: from localhost (unknown [IPv6:2603:3023:50c:85e1:b5c5:ae11:3e54:6a07])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id CFE9A14700FDF;
        Tue, 18 Sep 2018 09:32:30 -0700 (PDT)
Date:   Tue, 18 Sep 2018 09:32:30 -0700 (PDT)
Message-Id: <20180918.093230.1954285517367290862.davem@davemloft.net>
To:     daniel@iogearbox.net
Cc:     vakul.garg@nxp.com, sfr@canb.auug.org.au, netdev@vger.kernel.org,
        linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
        davejwatson@fb.com, doronrk@fb.com
Subject: Re: linux-next: manual merge of the net-next tree with the net tree
From:   David Miller <davem@davemloft.net>
In-Reply-To: <5959dad0-dd02-1c3d-2487-13a69f8c507b@iogearbox.net>
References: <236589cd-b55d-1ceb-f236-36f9135f794e@iogearbox.net>
        <DB7PR04MB4252D31B8E79B789CC507D248B1D0@DB7PR04MB4252.eurprd04.prod.outlook.com>
        <5959dad0-dd02-1c3d-2487-13a69f8c507b@iogearbox.net>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 18 Sep 2018 09:32:31 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Tue, 18 Sep 2018 11:53:17 +0200

> Ok, I think usually tests assert current kernel behavior to make sure any changes
> coming in don't accidentally break expectations from applications as opposed to
> future tests that still need fixing, but I guess I'm fine either way how to resolve
> the conflict; leaving it up to DaveM. Thanks for clarifying!

I'm doing the merge right now and will leave both tests in.
