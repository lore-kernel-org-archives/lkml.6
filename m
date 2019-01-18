Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DF90C07EBF
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:04:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DDBD2086D
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 19:04:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729251AbfARTEL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 18 Jan 2019 14:04:11 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:45988 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728832AbfARTEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Jan 2019 14:04:10 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 03D1114BA3537;
        Fri, 18 Jan 2019 11:04:09 -0800 (PST)
Date:   Fri, 18 Jan 2019 11:04:07 -0800 (PST)
Message-Id: <20190118.110407.2286468581643681605.davem@davemloft.net>
To:     ottosabart@seberm.com
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        netdev@vger.kernel.org, corbet@lwn.net
Subject: Re: [PATCH 1/1 RESEND] doc: net: fix bad references to network
 drivers
From:   David Miller <davem@davemloft.net>
In-Reply-To: <f6af749d99cf7dd9e5ba90824d0fe898ae69c793.1547466751.git.ottosabart@seberm.com>
References: <f6af749d99cf7dd9e5ba90824d0fe898ae69c793.1547466751.git.ottosabart@seberm.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 18 Jan 2019 11:04:10 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Otto Sabart <ottosabart@seberm.com>
Date: Mon, 14 Jan 2019 12:56:36 +0100

> Fix "reference to nonexisting document" warnings.
> 
> Fixes: b255e500c8dc ("net: documentation: build a directory structure
> for drivers")

Please do not chop up Fixes: tags, keep the entire text on one
continuous line.  I fixed it up for you this time.

> Signed-off-by: Otto Sabart <ottosabart@seberm.com>

Applied.
