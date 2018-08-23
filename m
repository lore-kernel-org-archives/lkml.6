Return-Path: <SRS0=AKWg=LG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 306ABC4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1D3620936
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Aug 2018 04:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1D3620936
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728439AbeHWIHL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Aug 2018 04:07:11 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:41534 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728121AbeHWIHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Aug 2018 04:07:10 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 60492100A2000;
        Wed, 22 Aug 2018 21:39:25 -0700 (PDT)
Date:   Wed, 22 Aug 2018 21:39:24 -0700 (PDT)
Message-Id: <20180822.213924.602801295731723249.davem@davemloft.net>
To:     sam@mendozajonas.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
Subject: Re: [PATCH net] net/ncsi: Fixup .dumpit message flags and ID check
 in Netlink handler
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180822045744.9267-1-sam@mendozajonas.com>
References: <20180822045744.9267-1-sam@mendozajonas.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 22 Aug 2018 21:39:25 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Samuel Mendoza-Jonas <sam@mendozajonas.com>
Date: Wed, 22 Aug 2018 14:57:44 +1000

> The ncsi_pkg_info_all_nl() .dumpit handler is missing the NLM_F_MULTI
> flag, causing additional package information after the first to be lost.
> Also fixup a sanity check in ncsi_write_package_info() to reject out of
> range package IDs.
> 
> Signed-off-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>

Applied.
