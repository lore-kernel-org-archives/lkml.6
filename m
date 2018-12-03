Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54C85C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:04:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EFAE420851
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 06:04:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EFAE420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725861AbeLCGEQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 01:04:16 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:57994 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725812AbeLCGEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 01:04:16 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D63CE14F37EDC;
        Sun,  2 Dec 2018 22:04:14 -0800 (PST)
Date:   Sun, 02 Dec 2018 22:04:12 -0800 (PST)
Message-Id: <20181202.220412.1682693749796493451.davem@davemloft.net>
To:     joris.gutjahr@gmail.com
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Malformatted switch statment
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181028164546.17178-1-joris.gutjahr@gmail.com>
References: <20181028164546.17178-1-joris.gutjahr@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 02 Dec 2018 22:04:15 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Joris Gutjahr <joris.gutjahr@gmail.com>
Date: Sun, 28 Oct 2018 17:45:46 +0100

> I fixed this coding style error I got after running
> checkpatch --file on this file.
> The problem was that the whole case block was on one line.
> 
> Signed-off-by: Joris Gutjahr <joris.gutjahr@gmail.com>

Frankly I think the existing code is more compact and easier
to read and understand.

Checkpatch is a tool, and it's results need be interpreated
and evaluated by human beings.  It's not to be taken as the
final verdict.

I'm not applying this, sorry.
