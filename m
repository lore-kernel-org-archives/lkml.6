Return-Path: <SRS0=q0iV=PB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1C43C64E79
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FEC1214D8
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Dec 2018 22:42:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725849AbeLXWmh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Dec 2018 17:42:37 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37666 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725788AbeLXWmh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Dec 2018 17:42:37 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AA4DA100AF102;
        Mon, 24 Dec 2018 14:42:36 -0800 (PST)
Date:   Mon, 24 Dec 2018 14:42:36 -0800 (PST)
Message-Id: <20181224.144236.490577501389170972.davem@davemloft.net>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, jon.maloy@ericsson.com, ying.xue@windriver.com,
        netdev@vger.kernel.org, tipc-discussion@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net/netlink_compat: Fix a missing check of
 nla_parse_nested
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181224005453.9992-1-pakki001@umn.edu>
References: <20181224005453.9992-1-pakki001@umn.edu>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 24 Dec 2018 14:42:37 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Aditya Pakki <pakki001@umn.edu>
Date: Sun, 23 Dec 2018 18:54:53 -0600

> In tipc_nl_compat_sk_dump(), if nla_parse_nested() fails, it could return
> an error. To be consistent with other invocations of the function call,
> on error, the fix passes the return value upstream.
> 
> Signed-off-by: Aditya Pakki <pakki001@umn.edu>

Applied, thanks.
