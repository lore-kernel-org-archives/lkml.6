Return-Path: <SRS0=p5KC=ON=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73E80C04EB9
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 425A8214C1
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Dec 2018 01:30:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 425A8214C1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726119AbeLDBaK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 20:30:10 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:52070 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726005AbeLDBaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 20:30:08 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BCFF6133FACA7;
        Mon,  3 Dec 2018 17:30:07 -0800 (PST)
Date:   Mon, 03 Dec 2018 17:30:07 -0800 (PST)
Message-Id: <20181203.173007.1077715112709461361.davem@davemloft.net>
To:     tiny.windzz@gmail.com
Cc:     mlindner@marvell.com, stephen@networkplumber.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: marvell: convert to DEFINE_SHOW_ATTRIBUTE
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181203143411.13294-1-tiny.windzz@gmail.com>
References: <20181203143411.13294-1-tiny.windzz@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 03 Dec 2018 17:30:08 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yangtao Li <tiny.windzz@gmail.com>
Date: Mon,  3 Dec 2018 09:34:11 -0500

> Use DEFINE_SHOW_ATTRIBUTE macro to simplify the code.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>

Applied.
