Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4AD2C1B0F7
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:06:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CEA420883
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 22:06:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbfARWGr convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 17:06:47 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:47974 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729621AbfARWGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 17:06:46 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C7F6014BA5DD3;
        Fri, 18 Jan 2019 14:06:45 -0800 (PST)
Date:   Fri, 18 Jan 2019 14:06:45 -0800 (PST)
Message-Id: <20190118.140645.2258937070798530983.davem@davemloft.net>
To:     j.neuschaefer@gmx.net
Cc:     netdev@vger.kernel.org, sridhar.samudrala@intel.com,
        dsa@cumulusnetworks.com, mcroce@redhat.com,
        tobias.regnery@gmail.com, arnd@arndb.de,
        jakub.kicinski@netronome.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: Fix typo in NET_FAILOVER help text
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190117170220.32239-1-j.neuschaefer@gmx.net>
References: <20190117170220.32239-1-j.neuschaefer@gmx.net>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 18 Jan 2019 14:06:46 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
Date: Thu, 17 Jan 2019 18:02:18 +0100

> "also enables" should not be spelled as one word.
> 
> Fixes: cfc80d9a1163 ("net: Introduce net_failover driver")
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>

Applied.
