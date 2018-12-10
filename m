Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D8A0C04EB8
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:44:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 34EC32084C
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:44:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34EC32084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729541AbeLJToq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:44:46 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:43388 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727324AbeLJTop (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:44:45 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 20FBD1473816D;
        Mon, 10 Dec 2018 11:44:45 -0800 (PST)
Date:   Mon, 10 Dec 2018 11:44:44 -0800 (PST)
Message-Id: <20181210.114444.508863897404103110.davem@davemloft.net>
To:     colin.king@canonical.com
Cc:     yisen.zhuang@huawei.com, salil.mehta@huawei.com,
        shiju.jose@huawei.com, netdev@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH][net-next] net: hns3: fix spelling mistake "offser" ->
 "offset"
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181210092948.4244-1-colin.king@canonical.com>
References: <20181210092948.4244-1-colin.king@canonical.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 10 Dec 2018 11:44:45 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Colin King <colin.king@canonical.com>
Date: Mon, 10 Dec 2018 09:29:48 +0000

> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a msg string, fix this.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Applied.
