Return-Path: <SRS0=AKhD=M3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 156FEC28CF8
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 06:14:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A79E620842
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Oct 2018 06:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A79E620842
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726588AbeJON5q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Oct 2018 09:57:46 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54452 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726164AbeJON5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Oct 2018 09:57:45 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 8EB7214178D1A;
        Sun, 14 Oct 2018 23:13:57 -0700 (PDT)
Date:   Sun, 14 Oct 2018 23:00:55 -0700 (PDT)
Message-Id: <20181014.230055.1599556082533969417.davem@davemloft.net>
To:     lists@wiesinger.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: net: dsa: b53: Keep CPU port as tagged in all VLANs - merge
 request
From:   David Miller <davem@davemloft.net>
In-Reply-To: <d189257f-1d06-8509-37ed-229b14ff14d7@wiesinger.com>
References: <d189257f-1d06-8509-37ed-229b14ff14d7@wiesinger.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 14 Oct 2018 23:13:57 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerhard Wiesinger <lists@wiesinger.com>
Date: Mon, 15 Oct 2018 07:08:53 +0200

> Hello David,
> 
> The dsa b53 net driver is broken since 4.15 kernels. This patch hasn't
> been merged into 4.18.latest yet (is already in net.git). Can you
> please integrate it in 4.18.15.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/davem/net.git/commit/drivers/net/dsa/b53/b53_common.c?id=ca8931948344c485569b04821d1f6bcebccd376b

Queued up, thanks.
