Return-Path: <SRS0=1Lvk=PY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF1C3C43387
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:35:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C778A20675
	for <linux-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 04:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732076AbfAPEfO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 15 Jan 2019 23:35:14 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:33494 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728227AbfAPEfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Jan 2019 23:35:13 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 17C4614AAA9C1;
        Tue, 15 Jan 2019 20:35:13 -0800 (PST)
Date:   Tue, 15 Jan 2019 20:35:12 -0800 (PST)
Message-Id: <20190115.203512.745234019944172123.davem@davemloft.net>
To:     ottosabart@seberm.com
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, corbet@lwn.net
Subject: Re: [PATCH 0/3] doc: networking: integrate scaling document into
 doc tree
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cover.1547063330.git.ottosabart@seberm.com>
References: <cover.1547063330.git.ottosabart@seberm.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 15 Jan 2019 20:35:13 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Otto Sabart <ottosabart@seberm.com>
Date: Wed, 9 Jan 2019 20:57:01 +0100

> These patches integrate scaling document into documentation tree.
> 
> There are no semantic changes.

Jon, I assume this is another series you will take in.

Again, I expect no major conflicts with the networking tree.
