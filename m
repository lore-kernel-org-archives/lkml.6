Return-Path: <SRS0=sLOc=QZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 170DAC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:10:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E17BB21479
	for <linux-kernel@archiver.kernel.org>; Mon, 18 Feb 2019 20:10:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728755AbfBRUK2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 Feb 2019 15:10:28 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:53730 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727341AbfBRUK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Feb 2019 15:10:27 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BF80912DE65FA;
        Mon, 18 Feb 2019 12:10:26 -0800 (PST)
Date:   Mon, 18 Feb 2019 12:10:26 -0800 (PST)
Message-Id: <20190218.121026.1539031523062218783.davem@davemloft.net>
To:     yamada.masahiro@socionext.com
Cc:     netdev@vger.kernel.org, linux-hams@vger.kernel.org,
        t.sailer@alumni.ethz.ch, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: hamradio: remove unused hweight*() defines
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1550471725-5575-1-git-send-email-yamada.masahiro@socionext.com>
References: <1550471725-5575-1-git-send-email-yamada.masahiro@socionext.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 18 Feb 2019 12:10:27 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Mon, 18 Feb 2019 15:35:25 +0900

> This file does not use hweight*() at all, and the definition is
> surrounded by #if 0 ... #endif.
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to net-next, thanks.
