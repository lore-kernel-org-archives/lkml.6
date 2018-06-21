Return-Path: <SRS0=bmN+=JH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1437BC43140
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:48:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A850920874
	for <linux-kernel@archiver.kernel.org>; Thu, 21 Jun 2018 00:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A850920874
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754533AbeFUAsC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Jun 2018 20:48:02 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46144 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754309AbeFUAsA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jun 2018 20:48:00 -0400
Received: from localhost (unknown [61.102.160.122])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 54886147025A2;
        Wed, 20 Jun 2018 17:47:58 -0700 (PDT)
Date:   Thu, 21 Jun 2018 09:47:54 +0900 (KST)
Message-Id: <20180621.094754.1271801827587737268.davem@davemloft.net>
To:     anders.roxell@linaro.org
Cc:     shuah@kernel.org, fw@strlen.de, shannon.nelson@oracle.com,
        netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selftests: net: add config fragments
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180619164111.30785-1-anders.roxell@linaro.org>
References: <20180619164111.30785-1-anders.roxell@linaro.org>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 20 Jun 2018 17:47:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anders Roxell <anders.roxell@linaro.org>
Date: Tue, 19 Jun 2018 18:41:11 +0200

> Add fragments to pass bridge and vlan tests.
> 
> Fixes: 33b01b7b4f19 ("selftests: add rtnetlink test script")
> Signed-off-by: Anders Roxell <anders.roxell@linaro.org>

Applied, thank you.
