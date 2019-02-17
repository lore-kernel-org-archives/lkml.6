Return-Path: <SRS0=Aihr=QY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2618C43381
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 18:37:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 77FE32186A
	for <linux-kernel@archiver.kernel.org>; Sun, 17 Feb 2019 18:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726137AbfBQShT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 17 Feb 2019 13:37:19 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:39632 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfBQShS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Feb 2019 13:37:18 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id BAF47106F2CD6;
        Sun, 17 Feb 2019 10:37:17 -0800 (PST)
Date:   Sun, 17 Feb 2019 10:37:17 -0800 (PST)
Message-Id: <20190217.103717.1311505316563655855.davem@davemloft.net>
To:     callum.sinclair@alliedtelesis.co.nz
Cc:     kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org,
        nikolay@cumulusnetworks.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, nicolas.dichtel@6wind.com
Subject: Re: [PATCH net-next v5] ipmr: ip6mr: Create new sockopt to clear
 mfc cache or vifs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190214024418.21490-2-callum.sinclair@alliedtelesis.co.nz>
References: <20190214024418.21490-1-callum.sinclair@alliedtelesis.co.nz>
        <20190214024418.21490-2-callum.sinclair@alliedtelesis.co.nz>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 17 Feb 2019 10:37:18 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Callum Sinclair <callum.sinclair@alliedtelesis.co.nz>
Date: Thu, 14 Feb 2019 15:44:18 +1300

> +#define MRT_FLUSH_VIFS	4	/* Flush multicast vifs */
> +#define MRT_FLUSH_VIFS_STATIC	8	/* Flush static multicast vifs */

Please rename to MRT_FLUSH_MIFS* as suggested by Nicolas and respin.

Thanks.
