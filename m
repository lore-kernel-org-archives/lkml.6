Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB70C07E85
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 00:31:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5117C2064D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 00:31:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5117C2064D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726473AbeLJAby (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Dec 2018 19:31:54 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:53376 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbeLJAby (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Dec 2018 19:31:54 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7D088144C6CA8;
        Sun,  9 Dec 2018 16:31:53 -0800 (PST)
Date:   Sun, 09 Dec 2018 16:31:52 -0800 (PST)
Message-Id: <20181209.163152.1641648923109797638.davem@davemloft.net>
To:     sd@queasysnail.net
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, sfr@canb.auug.org.au,
        netdev@vger.kernel.org, linux-next@vger.kernel.org,
        linux-kernel@vger.kernel.org, f.fainelli@gmail.com
Subject: Re: linux-next: Signed-off-by missing for commits in the net-next
 tree
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181209232722.GA4425@bistromath.localdomain>
References: <011f5be3-4bc1-2e64-0ddf-b43b8dbc4dcd@gmail.com>
        <20181209214907.GC21186@lunn.ch>
        <20181209232722.GA4425@bistromath.localdomain>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 09 Dec 2018 16:31:53 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sabrina Dubroca <sd@queasysnail.net>
Date: Mon, 10 Dec 2018 00:27:22 +0100

> Maybe Stephen's script to detect those missing sign-offs could be run
> as a commit/apply hook by David? This happens regularly, sometimes
> dropping more than just a sign-off.

Yeah, that would probably be a good idea, maybe something even on the
git.kernel.org side that won't let me push if I'm sending commits that
have this problem.
