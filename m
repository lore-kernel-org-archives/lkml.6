Return-Path: <SRS0=aTzB=K7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB17C4321D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:27:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E48FA2147A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Aug 2018 19:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E48FA2147A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726215AbeHPW14 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Aug 2018 18:27:56 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:60824 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725783AbeHPW14 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Aug 2018 18:27:56 -0400
Received: from localhost (unknown [205.153.50.125])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id AA4C3145E668B;
        Thu, 16 Aug 2018 12:27:36 -0700 (PDT)
Date:   Thu, 16 Aug 2018 12:27:36 -0700 (PDT)
Message-Id: <20180816.122736.1276296581513153374.davem@davemloft.net>
To:     ivan.khoronzhuk@linaro.org
Cc:     grygorii.strashko@ti.com, corbet@lwn.net, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] Documentation: networking: ti-cpsw: correct
 cbs parameters for Eth1 100Mb
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180815202953.10137-1-ivan.khoronzhuk@linaro.org>
References: <20180815202953.10137-1-ivan.khoronzhuk@linaro.org>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 16 Aug 2018 12:27:36 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>
Date: Wed, 15 Aug 2018 23:29:53 +0300

> If set cbs parameters calculated for 1000Mb, but use on 100Mb port
> w/o h/w offload (for cpsw offload it doesn't matter), it works
> incorrectly. According to the example and testing board, second port
> is 100Mb interface. Correct them on recalculated for 100Mb interface.
> It allows to use the same command for CBS software implementation for
> board in example.
> 
> Signed-off-by: Ivan Khoronzhuk <ivan.khoronzhuk@linaro.org>

Applied, thanks.
