Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9FCDC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:42:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 788D821C16
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 21:42:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 788D821C16
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727162AbeHKAOE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 20:14:04 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:57872 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725754AbeHKAOE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 20:14:04 -0400
Received: from localhost (c-73-240-71-155.hsd1.or.comcast.net [73.240.71.155])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 0296314310525;
        Fri, 10 Aug 2018 14:42:24 -0700 (PDT)
Date:   Fri, 10 Aug 2018 14:42:24 -0700 (PDT)
Message-Id: <20180810.144224.1142211723851962889.davem@davemloft.net>
To:     fengguang.wu@intel.com
Cc:     manish.chopra@cavium.com, kbuild-all@01.org,
        netdev@vger.kernel.org, ariel.elior@cavium.com,
        everest-linux-l2@cavium.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH net-next] qed/qede: qede_setup_tc() can be static
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180810012959.GA22458@athens>
References: <201808100919.Z4vmd4cO%fengguang.wu@intel.com>
        <20180810012959.GA22458@athens>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 10 Aug 2018 14:42:25 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: kbuild test robot <fengguang.wu@intel.com>
Date: Fri, 10 Aug 2018 09:29:59 +0800

> Fixes: 5e7baf0fcb2a ("qed/qede: Multi CoS support.")
> Signed-off-by: kbuild test robot <fengguang.wu@intel.com>

Applied.
