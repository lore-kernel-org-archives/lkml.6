Return-Path: <SRS0=izC1=MS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3710C67871
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 17:28:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8F75A206B2
	for <linux-kernel@archiver.kernel.org>; Sat,  6 Oct 2018 17:28:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8F75A206B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727945AbeJGAca (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 20:32:30 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56986 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726348AbeJGAc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 20:32:29 -0400
Received: from localhost (c-67-183-145-105.hsd1.wa.comcast.net [67.183.145.105])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EF4EA13E99DE8;
        Sat,  6 Oct 2018 10:28:18 -0700 (PDT)
Date:   Sat, 06 Oct 2018 10:28:15 -0700 (PDT)
Message-Id: <20181006.102815.1648316987275753897.davem@davemloft.net>
To:     ben.dooks@codethink.co.uk
Cc:     netdev@vger.kernel.org, David.Laight@aculab.com, oneukum@suse.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-kernel@lists.codethink.co.uk
Subject: Re: [PATCH] usbnet: smsc95xx: simplify tx_fixup code
From:   David Miller <davem@davemloft.net>
In-Reply-To: <40033993674bb8b5ef33ac33f28f3aff@codethink.co.uk>
References: <20181002165602.21033-1-ben.dooks@codethink.co.uk>
        <20181005.142412.601607260441380535.davem@davemloft.net>
        <40033993674bb8b5ef33ac33f28f3aff@codethink.co.uk>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 06 Oct 2018 10:28:19 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Sat, 06 Oct 2018 12:27:27 +0100

> Thanks, got a new version of the series just being tested with this.
> Should it go into the original, or as a separate change?

Into the original.
