Return-Path: <SRS0=eGoB=KA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4212ECDFAA
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B06AB20870
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Jul 2018 20:44:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B06AB20870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730745AbeGPVNF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 16 Jul 2018 17:13:05 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:59838 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728470AbeGPVNF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jul 2018 17:13:05 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 45EB31434E85A;
        Mon, 16 Jul 2018 13:43:59 -0700 (PDT)
Date:   Mon, 16 Jul 2018 13:43:58 -0700 (PDT)
Message-Id: <20180716.134358.200002474943581895.davem@davemloft.net>
To:     clabbe@baylibre.com
Cc:     alexandre.torgue@st.com, peppe.cavallaro@st.com,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH] net: ethernet: stmmac: fix documentation warning
From:   David Miller <davem@davemloft.net>
In-Reply-To: <1531482615-12905-1-git-send-email-clabbe@baylibre.com>
References: <1531482615-12905-1-git-send-email-clabbe@baylibre.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 16 Jul 2018 13:43:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Corentin Labbe <clabbe@baylibre.com>
Date: Fri, 13 Jul 2018 11:50:15 +0000

> This patch remove the following documentation warning
> drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c:103: warning: Excess function parameter 'priv' description in 'stmmac_axi_setup'
> It was introduced in commit afea03656add7 ("stmmac: rework DMA bus setting and introduce new platform AXI structure")
> 
> Signed-off-by: Corentin Labbe <clabbe@baylibre.com>

Applied.
