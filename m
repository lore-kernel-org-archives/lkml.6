Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5EDAC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 753C42083A
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:09:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 753C42083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbeJRNIU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 09:08:20 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54740 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727348AbeJRNIU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 09:08:20 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6CD1513AE1A9A;
        Wed, 17 Oct 2018 22:09:10 -0700 (PDT)
Date:   Wed, 17 Oct 2018 22:09:09 -0700 (PDT)
Message-Id: <20181017.220909.99491116337869620.davem@davemloft.net>
To:     gustavo@embeddedor.com
Cc:     linux-kernel@vger.kernel.org, andrew@lunn.ch, f.fainelli@gmail.com,
        quentin.schulz@bootlin.com, netdev@vger.kernel.org
Subject: Re: [PATCH net-next v3 0/2] fix signedness bug and memory leak in
 mscc driver
From:   David Miller <davem@davemloft.net>
In-Reply-To: <cover.1539710647.git.gustavo@embeddedor.com>
References: <cover.1539710647.git.gustavo@embeddedor.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 17 Oct 2018 22:09:10 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Date: Tue, 16 Oct 2018 19:33:17 +0200

> This patchset aims to fix a signedness bug in function
> vsc85xx_downshift_get() and a memory leak in function
> vsc8574_config_pre_init().
> 
> Changes in v3:
>  - Add Quentin's Reviewed-by to commit log in patch 2/2.
>  - Post the series to netdev.
> 
> Changes in v2:
>  - Add Quentin's Reviewed-by to commit log in patch 1/2.
>  - Jump to out label so all functions in the driver exit with the PHY
>    set to access the standard page. Thanks to Quentin Schulz for
>    pointing this out.

Series applied to net-next.
