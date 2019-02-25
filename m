Return-Path: <SRS0=3gpS=RA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA82FC43381
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:06:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7C3D720842
	for <linux-kernel@archiver.kernel.org>; Mon, 25 Feb 2019 06:06:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726676AbfBYGGz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 Feb 2019 01:06:55 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:35602 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726048AbfBYGGz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Feb 2019 01:06:55 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5BD4514E04018;
        Sun, 24 Feb 2019 22:06:54 -0800 (PST)
Date:   Sun, 24 Feb 2019 22:06:53 -0800 (PST)
Message-Id: <20190224.220653.256212672271785631.davem@davemloft.net>
To:     ioana.ciornei@nxp.com
Cc:     leoyang.li@nxp.com, roy.pledge@nxp.com, ruxandra.radulescu@nxp.com,
        laurentiu.tudor@nxp.com, horia.geanta@nxp.com, brouer@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] soc: fsl: dpio: enable and configure cache stashing
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20190223084816.28985-1-ioana.ciornei@nxp.com>
References: <20190223084816.28985-1-ioana.ciornei@nxp.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sun, 24 Feb 2019 22:06:54 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ioana Ciornei <ioana.ciornei@nxp.com>
Date: Sat, 23 Feb 2019 08:48:42 +0000

> The first two patches enable cache stashing and configure the core cluster
> destination per software portal while the third patch is the one
> configuring the amount of stashing on a queue.

Should I merge this series in via my networking tree?

Thanks.
