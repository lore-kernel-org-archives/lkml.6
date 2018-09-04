Return-Path: <SRS0=7C3F=LS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32441C43334
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:51:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C986C20659
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Sep 2018 04:51:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C986C20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbeIDJO2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Sep 2018 05:14:28 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:51150 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726093AbeIDJO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Sep 2018 05:14:27 -0400
Received: from localhost (74-93-104-98-Washington.hfc.comcastbusiness.net [74.93.104.98])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id C293512139FE2;
        Mon,  3 Sep 2018 21:51:07 -0700 (PDT)
Date:   Mon, 03 Sep 2018 21:51:07 -0700 (PDT)
Message-Id: <20180903.215107.929144059014660952.davem@davemloft.net>
To:     ivan@de.ibm.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        chunkeey@gmail.com
Subject: Re: [PATCH v2] net/ibm/emac: wrong emac_calc_base call was used by
 typo
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20180903072628.19986-1-ivan@de.ibm.com>
References: <20180903072628.19986-1-ivan@de.ibm.com>
X-Mailer: Mew version 6.7 on Emacs 25.3 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 03 Sep 2018 21:51:08 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ivan Mikhaylov <ivan@de.ibm.com>
Date: Mon, 3 Sep 2018 10:26:28 +0300

> __emac_calc_base_mr1 was used instead of __emac4_calc_base_mr1
> by copy-paste mistake for emac4syn.
> 
> Fixes: 45d6e545505fd32edb812f085be7de45b6a5c0af ("net/ibm/emac: add 8192 rx/tx fifo size")
> Signed-off-by: Ivan Mikhaylov <ivan@de.ibm.com>

Applied.
