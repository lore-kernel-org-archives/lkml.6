Return-Path: <SRS0=I82Q=LM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC740C433F5
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:22:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B75E2084D
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Aug 2018 08:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B75E2084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727959AbeH2MSB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Aug 2018 08:18:01 -0400
Received: from gloria.sntech.de ([185.11.138.130]:41392 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727190AbeH2MSB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Aug 2018 08:18:01 -0400
Received: from ip5f5a866f.dynamic.kabel-deutschland.de ([95.90.134.111] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1fuvji-0000St-9g; Wed, 29 Aug 2018 10:21:58 +0200
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Qiang Zhao <qiang.zhao@nxp.com>,
        Li Yang <leoyang.li@nxp.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Santosh Shilimkar <ssantosh@kernel.org>,
        linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org, linux-soc@vger.kernel.org
Subject: Re: [PATCH] soc: Convert to using %pOFn instead of device_node.name
Date:   Wed, 29 Aug 2018 10:21:57 +0200
Message-ID: <6932871.nBNBr6GJE4@diego>
In-Reply-To: <20180828015252.28511-43-robh@kernel.org>
References: <20180828015252.28511-1-robh@kernel.org> <20180828015252.28511-43-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Dienstag, 28. August 2018, 03:52:44 CEST schrieb Rob Herring:
> In preparation to remove the node name pointer from struct device_node,
> convert printf users to use the %pOFn format specifier.

>  drivers/soc/rockchip/pm_domains.c | 44 +++++++++++++++----------------

For the Rockchip-part
Acked-by: Heiko Stuebner <heiko@sntech.de>


