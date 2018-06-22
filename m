Return-Path: <SRS0=QLNC=JI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0504DC43142
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 04:45:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 872A323D36
	for <linux-kernel@archiver.kernel.org>; Fri, 22 Jun 2018 04:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 872A323D36
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751214AbeFVEo7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 Jun 2018 00:44:59 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:44454 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751052AbeFVEo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jun 2018 00:44:57 -0400
Received: from localhost (unknown [211.196.191.92])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 222D3119C1EC8;
        Thu, 21 Jun 2018 21:44:54 -0700 (PDT)
Date:   Fri, 22 Jun 2018 13:43:51 +0900 (KST)
Message-Id: <20180622.134351.2080770694318509260.davem@davemloft.net>
To:     neilb@suse.com
Cc:     tgraf@suug.ch, herbert@gondor.apana.org.au, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] Assorted rhashtables cleanups.
From:   David Miller <davem@davemloft.net>
In-Reply-To: <152929034948.23173.8671757672560065344.stgit@noble>
References: <152929034948.23173.8671757672560065344.stgit@noble>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 21 Jun 2018 21:44:57 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: NeilBrown <neilb@suse.com>
Date: Mon, 18 Jun 2018 12:52:50 +1000

> Following 7 patches are selections from a recent RFC series I posted
> that have all received suitable Acks.
> 
> The most visible changes are that rhashtable-types.h is now preferred
> for inclusion in include/linux/*.h rather than rhashtable.h, and
> that the full hash is used - no bits a reserved for a NULLS pointer.

Series applied to net-next, thanks Neil.
