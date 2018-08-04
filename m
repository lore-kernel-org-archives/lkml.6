Return-Path: <SRS0=4jry=KT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26BA4C4646F
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 20:23:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D1E53208E6
	for <linux-kernel@archiver.kernel.org>; Sat,  4 Aug 2018 20:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1E53208E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729693AbeHDWZ2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Aug 2018 18:25:28 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:56926 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728309AbeHDWZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Aug 2018 18:25:28 -0400
Received: from localhost (unknown [172.58.40.140])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 372091403CE1A;
        Sat,  4 Aug 2018 13:23:37 -0700 (PDT)
Date:   Sat, 04 Aug 2018 13:23:35 -0700 (PDT)
Message-Id: <20180804.132335.1077646318247647006.davem@davemloft.net>
To:     zhongjiang@huawei.com
Cc:     woojung.huh@microchip.com, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Use ARRAY_SIZE to replace computing the size
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1533279195-50245-1-git-send-email-zhongjiang@huawei.com>
References: <1533279195-50245-1-git-send-email-zhongjiang@huawei.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Sat, 04 Aug 2018 13:23:37 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: zhong jiang <zhongjiang@huawei.com>
Date: Fri, 3 Aug 2018 14:53:13 +0800

> zhong jiang (2):
>   net:usb: Use ARRAY_SIZE instead of calculating the array size
>   include/net/bond_3ad: Simplify the code by using the ARRAY_SIZE

Series applied.
