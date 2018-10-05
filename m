Return-Path: <SRS0=9Qwj=MR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BD32C00449
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:55:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07D8121473
	for <linux-kernel@archiver.kernel.org>; Fri,  5 Oct 2018 21:55:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07D8121473
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=davemloft.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728958AbeJFEzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 6 Oct 2018 00:55:39 -0400
Received: from shards.monkeyblade.net ([23.128.96.9]:46990 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725772AbeJFEzi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Oct 2018 00:55:38 -0400
Received: from localhost (c-67-183-145-105.hsd1.wa.comcast.net [67.183.145.105])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 6699E13ADF96A;
        Fri,  5 Oct 2018 14:54:59 -0700 (PDT)
Date:   Fri, 05 Oct 2018 14:54:58 -0700 (PDT)
Message-Id: <20181005.145458.746711951646640462.davem@davemloft.net>
To:     vijaykhemka@fb.com
Cc:     sam@mendozajonas.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org,
        Justin.Lee1@Dell.com, joel@jms.id.au,
        linux-aspeed@lists.ozlabs.org, sdasari@fb.com, christian@cmd.nu
Subject: Re: [PATCH net-next] net/ncsi: Add NCSI OEM command support
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20181005174602.828803-1-vijaykhemka@fb.com>
References: <20181005174602.828803-1-vijaykhemka@fb.com>
X-Mailer: Mew version 6.7 on Emacs 26 / Mule 6.0 (HANACHIRUSATO)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Fri, 05 Oct 2018 14:54:59 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vijay Khemka <vijaykhemka@fb.com>
Date: Fri, 5 Oct 2018 10:46:01 -0700

> This patch adds OEM commands and response handling. It also defines OEM
> command and response structure as per NCSI specification along with its
> handlers.
> 
> ncsi_cmd_handler_oem: This is a generic command request handler for OEM
> commands
> ncsi_rsp_handler_oem: This is a generic response handler for OEM commands
> 
> Signed-off-by: Vijay Khemka <vijaykhemka@fb.com>
> Reviewed-by: Justin Lee <justin.lee1@dell.com>
> Reviewed-by: Samuel Mendoza-Jonas <sam@mendozajonas.com>

Applied.
