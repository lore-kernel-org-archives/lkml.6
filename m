Return-Path: <SRS0=852P=K4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28BAC4646D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:49:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6577221888
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Aug 2018 15:49:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6577221888
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729855AbeHMScm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Aug 2018 14:32:42 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:52828 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728509AbeHMScm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Aug 2018 14:32:42 -0400
Received: from localhost (c-24-20-22-31.hsd1.or.comcast.net [24.20.22.31])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id EC74E14580457;
        Mon, 13 Aug 2018 08:49:54 -0700 (PDT)
Date:   Mon, 13 Aug 2018 08:49:54 -0700 (PDT)
Message-Id: <20180813.084954.419874402258078860.davem@davemloft.net>
To:     mdf@kernel.org
Cc:     keescook@chromium.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, alex.williams@ni.com
Subject: Re: [PATCH 0/2] net: nixge: Minor cleanups
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180811011941.6187-1-mdf@kernel.org>
References: <20180811011941.6187-1-mdf@kernel.org>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 13 Aug 2018 08:49:55 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Moritz Fischer <mdf@kernel.org>
Date: Fri, 10 Aug 2018 18:19:39 -0700

> in preparation of my 64-bit support series, here's some
> minor cleanup in preparation that gets rid of unneccesary
> accesses to the descriptor application fields.
> 
> I've confirmed that the hardware does not access the fields
> in all our configurations.

Series applied, thank you.
