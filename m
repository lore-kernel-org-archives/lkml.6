Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A78F0C282C0
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:07:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 723282184C
	for <linux-kernel@archiver.kernel.org>; Wed, 23 Jan 2019 17:07:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727055AbfAWRHy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 23 Jan 2019 12:07:54 -0500
Received: from shards.monkeyblade.net ([23.128.96.9]:47000 "EHLO
        shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725871AbfAWRHx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Jan 2019 12:07:53 -0500
Received: from localhost (unknown [IPv6:2601:601:9f80:35cd::bf5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 57EF614EC9753;
        Wed, 23 Jan 2019 09:07:53 -0800 (PST)
Date:   Wed, 23 Jan 2019 09:07:52 -0800 (PST)
Message-Id: <20190123.090752.886730643895076177.davem@davemloft.net>
To:     skalluru@marvell.com
Cc:     gustavo@embeddedor.com, rasesh.mody@cavium.com,
        sudarsana.kalluru@cavium.com, Dept-GELinuxNICDev@cavium.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] bna: Mark expected switch fall-throughs
From:   David Miller <davem@davemloft.net>
In-Reply-To: <CY4PR18MB125398716A4A84409D301F7AD3990@CY4PR18MB1253.namprd18.prod.outlook.com>
References: <20190123075328.GA25319@embeddedor>
        <CY4PR18MB125398716A4A84409D301F7AD3990@CY4PR18MB1253.namprd18.prod.outlook.com>
X-Mailer: Mew version 6.8 on Emacs 26.1
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Wed, 23 Jan 2019 09:07:53 -0800 (PST)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sudarsana Reddy Kalluru <skalluru@marvell.com>
Date: Wed, 23 Jan 2019 08:03:12 +0000

> -----Original Message-----
> From: Gustavo A. R. Silva [mailto:gustavo@embeddedor.com] 
> Sent: 23 January 2019 13:23
> To: Rasesh Mody <rasesh.mody@cavium.com>; Sudarsana Kalluru <sudarsana.kalluru@cavium.com>; Dept-GELinuxNICDev@cavium.com; David S. Miller <davem@davemloft.net>
> Cc: netdev@vger.kernel.org; linux-kernel@vger.kernel.org; Gustavo A. R. Silva <gustavo@embeddedor.com>
> Subject: [PATCH net-next] bna: Mark expected switch fall-throughs
> 
> External Email
> 
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases where we are expecting to fall through.
> 
> This patch fixes the following warnings:
> 
> drivers/net/ethernet/brocade/bna/bfa_ioc.c:790:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
> drivers/net/ethernet/brocade/bna/bfa_ioc.c:860:3: warning: this statement may fall through [-Wimplicit-fallthrough=]
> 
> Warning level 3 was used: -Wimplicit-fallthrough=3
> 
> This patch is part of the ongoing efforts to enabling -Wimplicit-fallthrough
> 
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>

Applied.
