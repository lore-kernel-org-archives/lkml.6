Return-Path: <SRS0=Z5ET=M6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79C0FC5ACCC
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4717F208E4
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Oct 2018 05:15:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4717F208E4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbeJRNO1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Oct 2018 09:14:27 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:54802 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727331AbeJRNO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Oct 2018 09:14:27 -0400
Received: from localhost (c-67-183-62-245.hsd1.wa.comcast.net [67.183.62.245])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 15F5E13AE1A9F;
        Wed, 17 Oct 2018 22:15:16 -0700 (PDT)
Date:   Wed, 17 Oct 2018 22:15:15 -0700 (PDT)
Message-Id: <20181017.221515.528292765899192548.davem@davemloft.net>
To:     vijaykhemka@fb.com
Cc:     sam@mendozajonas.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Justin.Lee1@Dell.com, joel@jms.id.au, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH net-next v5] net/ncsi: Add NCSI Broadcom OEM command
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181016191319.1909502-1-vijaykhemka@fb.com>
References: <20181016191319.1909502-1-vijaykhemka@fb.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 17 Oct 2018 22:15:16 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijay Khemka <vijaykhemka@fb.com>
Date: Tue, 16 Oct 2018 12:13:19 -0700

> This patch adds OEM Broadcom commands and response handling. It also
> defines OEM Get MAC Address handler to get and configure the device.
> 
> ncsi_oem_gma_handler_bcm: This handler send NCSI broadcom command for
> getting mac address.
> ncsi_rsp_handler_oem_bcm: This handles response received for all
> broadcom OEM commands.
> ncsi_rsp_handler_oem_bcm_gma: This handles get mac address response and
> set it to device.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

Applied.
