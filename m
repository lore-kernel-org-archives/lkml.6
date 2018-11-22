Return-Path: <SRS0=Yw3T=OB=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F81BC43441
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:45:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2843420864
	for <linux-kernel@archiver.kernel.org>; Thu, 22 Nov 2018 07:45:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2843420864
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bootlin.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392670AbeKVSXN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 22 Nov 2018 13:23:13 -0500
Received: from mail.bootlin.com ([62.4.15.54]:44121 "EHLO mail.bootlin.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729423AbeKVSXM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Nov 2018 13:23:12 -0500
Received: by mail.bootlin.com (Postfix, from userid 110)
        id C256F20D29; Thu, 22 Nov 2018 08:44:57 +0100 (CET)
Received: from windsurf (aaubervilliers-681-1-94-205.w90-88.abo.wanadoo.fr [90.88.35.205])
        by mail.bootlin.com (Postfix) with ESMTPSA id 8BE7D20714;
        Thu, 22 Nov 2018 08:44:57 +0100 (CET)
Date:   Thu, 22 Nov 2018 08:44:57 +0100
From:   Thomas Petazzoni <thomas.petazzoni@bootlin.com>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <davem@davemloft.net>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: mvneta: remove redundant check for
 eee->tx_lpi_timer < 0
Message-ID: <20181122084457.2eb1adc9@windsurf>
In-Reply-To: <20181122064200.11572-1-yuehaibing@huawei.com>
References: <20181122064200.11572-1-yuehaibing@huawei.com>
Organization: Bootlin (formerly Free Electrons)
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, 22 Nov 2018 14:42:00 +0800, YueHaibing wrote:
> fixes the smatch warning:
> 
> drivers/net/ethernet/marvell/mvneta.c:4252 mvneta_ethtool_set_eee() warn:
>  unsigned 'eee->tx_lpi_timer' is never less than zero.
> 
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>

Acked-by: Thomas Petazzoni <thomas.petazzoni@bootlin.com>

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
