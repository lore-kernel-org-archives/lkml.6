Return-Path: <SRS0=OQ6t=NI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8EC7DECDE44
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 00:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E3DC20869
	for <linux-kernel@archiver.kernel.org>; Sun, 28 Oct 2018 00:03:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3E3DC20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728895AbeJ1IqV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 28 Oct 2018 04:46:21 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:37558 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728630AbeJ1IqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Oct 2018 04:46:21 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id D2A0B1487DEB8;
        Sat, 27 Oct 2018 17:03:35 -0700 (PDT)
Date:   Sat, 27 Oct 2018 17:03:33 -0700 (PDT)
Message-Id: <20181027.170333.305158882844306852.davem@davemloft.net>
To:     tomasbortoli@gmail.com
Cc:     vyasevich@gmail.com, nhorman@tuxdriver.com,
        marcelo.leitner@gmail.com, linux-sctp@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sctp: socket.c validate sprstat_policy
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cb41ca17-4bad-bd21-6938-aee960a8ba9b@gmail.com>
References: <20181027202026.32157-1-tomasbortoli@gmail.com>
        <cb41ca17-4bad-bd21-6938-aee960a8ba9b@gmail.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 27 Oct 2018 17:03:36 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomas Bortoli <tomasbortoli@gmail.com>
Date: Sat, 27 Oct 2018 22:43:43 +0200

> I just realized we also have to check for less than 0 indexes..

How about the fact that your original submission didn't even compile?

I hope you realized that first.
