Return-Path: <SRS0=k9B+=NF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4871C46475
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:53:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6795C207DD
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Oct 2018 22:53:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6795C207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727629AbeJZH2M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Oct 2018 03:28:12 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:34242 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726570AbeJZH2M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Oct 2018 03:28:12 -0400
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::cf9])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 78E9E13FEE1E5;
        Thu, 25 Oct 2018 15:53:39 -0700 (PDT)
Date:   Thu, 25 Oct 2018 15:53:35 -0700 (PDT)
Message-Id: <20181025.155335.2132843393553452471.davem@davemloft.net>
To:     vijaykhemka@fb.com
Cc:     sam@mendozajonas.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Justin.Lee1@Dell.com, joel@jms.id.au, linux-aspeed@lists.ozlabs.org
Subject: Re: [PATCH net-next] net/ncsi: Add NCSI Mellanox OEM command
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181025220413.2936698-1-vijaykhemka@fb.com>
References: <20181025220413.2936698-1-vijaykhemka@fb.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 25 Oct 2018 15:53:39 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijay Khemka <vijaykhemka@fb.com>
Date: Thu, 25 Oct 2018 15:04:13 -0700

> This patch adds OEM Mellanox commands and response handling. It also
> defines OEM Get MAC Address handler to get and configure the device.
> 
> ncsi_oem_gma_handler_mlx: This handler send NCSI mellanox command for
> getting mac address.
> ncsi_rsp_handler_oem_mlx: This handles response received for all
> mellanox OEM commands.
> ncsi_rsp_handler_oem_mlx_gma: This handles get mac address response and
> set it to device.
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>

net-next is closed, please resubmit this when the net-next tree opens
back up.

Thank you.
