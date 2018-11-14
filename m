Return-Path: <SRS0=v0ik=NZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F6F8C43441
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 00:30:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C774A22360
	for <linux-kernel@archiver.kernel.org>; Wed, 14 Nov 2018 00:30:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C774A22360
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731370AbeKNKbc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 14 Nov 2018 05:31:32 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:60630 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727005AbeKNKbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Nov 2018 05:31:32 -0500
Received: from localhost (unknown [64.114.255.97])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 5651814BF6C7A;
        Tue, 13 Nov 2018 16:30:46 -0800 (PST)
Date:   Tue, 13 Nov 2018 16:30:42 -0800 (PST)
Message-Id: <20181113.163042.2086307929074044277.davem@davemloft.net>
To:     ivan.khoronzhuk@linaro.org
Cc:     grygorii.strashko@ti.com, linux-omap@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 0/4] net: ethernet: ti: cpsw: allow vlan h/w
 timestamping
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181112140023.12407-1-ivan.khoronzhuk@linaro.org>
References: <20181112140023.12407-1-ivan.khoronzhuk@linaro.org>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 13 Nov 2018 16:30:46 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Date: Mon, 12 Nov 2018 16:00:19 +0200

> The patchset adds several improvements and allows vlan h/w ts.
> 
> Based on net-next/master

Series applied, thanks.
