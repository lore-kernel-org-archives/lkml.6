Return-Path: <SRS0=p8q0=NW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 400E2C43441
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 17:25:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3EAC214DB
	for <linux-kernel@archiver.kernel.org>; Sun, 11 Nov 2018 17:25:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3EAC214DB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729289AbeKLDOb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 11 Nov 2018 22:14:31 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:37176 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729222AbeKLDOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Nov 2018 22:14:31 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 76FDA1474EB69;
        Sun, 11 Nov 2018 09:25:24 -0800 (PST)
Date:   Sun, 11 Nov 2018 09:25:13 -0800 (PST)
Message-Id: <20181111.092513.1189098747245221056.davem@davemloft.net>
To:     suraj1998@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: net: ipv4: tcp_vegas
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1541956134-14029-1-git-send-email-suraj1998@gmail.com>
References: <20181108.103428.494936194513918478.davem@davemloft.net>
        <1541956134-14029-1-git-send-email-suraj1998@gmail.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 11 Nov 2018 09:25:24 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Suraj Singh <suraj1998@gmail.com>
Date: Sun, 11 Nov 2018 22:38:54 +0530

> I don't think you've been getting my emails because I've been sending them
> in response to the message-id of my patch. 

I got your email, I'm just too busy to reply.
