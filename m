Return-Path: <SRS0=e9m6=MP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA888C00449
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8469821479
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Oct 2018 05:23:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8469821479
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726713AbeJCMJx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Oct 2018 08:09:53 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54530 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726405AbeJCMJx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Oct 2018 08:09:53 -0400
Received: from localhost (c-67-183-145-105.hsd1.wa.comcast.net [67.183.145.105])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id A101814207562;
        Tue,  2 Oct 2018 22:23:05 -0700 (PDT)
Date:   Tue, 02 Oct 2018 22:23:04 -0700 (PDT)
Message-Id: <20181002.222304.276597319093873023.davem@davemloft.net>
To:     ben.dooks@codethink.co.uk
Cc:     netdev@vger.kernel.org, linux-kernel@lists.codethink.co.uk,
        oneukum@suse.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ben-linux@fluff.org
Subject: Re: [PATCH] net: usbnet: make driver_info const
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181001160243.10428-1-ben.dooks@codethink.co.uk>
References: <20181001160243.10428-1-ben.dooks@codethink.co.uk>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 02 Oct 2018 22:23:06 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ben Dooks <ben.dooks@codethink.co.uk>
Date: Mon,  1 Oct 2018 17:02:43 +0100

> From: Ben Dooks <ben-linux@fluff.org>
> 
> The driver_info field that is used for describing each of the usb-net
> drivers using the usbnet.c core all declare their information as const
> and the usbnet.c itself does not try and modify the struct.
> 
> It is therefore a good idea to make this const in the usbnet.c structure
> in case anyone tries to modify it.
> 
> Signed-off-by: Ben Dooks <ben-linux@fluff.org>
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>

Applied.
