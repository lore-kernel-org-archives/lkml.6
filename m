Return-Path: <SRS0=jKyA=KN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 416A9C46462
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:17:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F33F020873
	for <linux-kernel@archiver.kernel.org>; Sun, 29 Jul 2018 20:17:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F33F020873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728938AbeG2VtW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 29 Jul 2018 17:49:22 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44494 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbeG2VtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Jul 2018 17:49:22 -0400
Received: from localhost (c-73-37-107-99.hsd1.or.comcast.net [73.37.107.99])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C8D9013E33738;
        Sun, 29 Jul 2018 13:17:41 -0700 (PDT)
Date:   Sun, 29 Jul 2018 13:17:41 -0700 (PDT)
Message-Id: <20180729.131741.711465145442387927.davem@davemloft.net>
To:     supertakumi86@gmail.com
Cc:     nic_swsd@realtek.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: realtek: r8169: Add spaces after commas
 coding style issue
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180728090217.GA19065@zenus>
References: <20180728090217.GA19065@zenus>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 29 Jul 2018 13:17:42 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sohil Ladhani <supertakumi86@gmail.com>
Date: Sat, 28 Jul 2018 14:32:21 +0530

> Fixed a coding style issue
> 
> Signed-off-by: Sohil Ladhani <supertakumi86@gmail.com>

This doesn't apply to the current net-next tree.
