Return-Path: <SRS0=vePq=O3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C53C8C43387
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9BA9F218A2
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Dec 2018 23:50:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbeLRXun (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Dec 2018 18:50:43 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:44580 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727601AbeLRXum (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Dec 2018 18:50:42 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 398B714878782;
        Tue, 18 Dec 2018 15:50:42 -0800 (PST)
Date:   Tue, 18 Dec 2018 15:50:41 -0800 (PST)
Message-Id: <20181218.155041.273935089211418130.davem@davemloft.net>
To:     yuehaibing@huawei.com
Cc:     roopa@cumulusnetworks.com, nikolay@cumulusnetworks.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        bridge@lists.linux-foundation.org
Subject: Re: [PATCH net-next] net: bridge: remove unneeded variable 'err'
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181217094623.32668-1-yuehaibing@huawei.com>
References: <20181217094623.32668-1-yuehaibing@huawei.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 18 Dec 2018 15:50:42 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: YueHaibing <yuehaibing@huawei.com>
Date: Mon, 17 Dec 2018 17:46:23 +0800

> function br_multicast_toggle now always return 0,
> so the variable 'err' is unneeded.
> Also cleanup dead branch in br_changelink.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Applied.
