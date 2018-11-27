Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A690C43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:10:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4A4302082F
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 00:10:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A4302082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727695AbeK0LGr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 06:06:47 -0500
Received: from gloria.sntech.de ([185.11.138.130]:33206 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726888AbeK0LGr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 06:06:47 -0500
Received: from ip5f5a905a.dynamic.kabel-deutschland.de ([95.90.144.90] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gRQxn-0003Ll-4o; Tue, 27 Nov 2018 01:10:51 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Otavio Salvador <otavio@ossystems.com.br>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/4] ARM: dts: rockchip: Fix the PMU interrupt number for rv1108
Date:   Tue, 27 Nov 2018 01:10:50 +0100
Message-ID: <2879557.jOLLiySa25@phil>
In-Reply-To: <20181126173506.24068-1-otavio@ossystems.com.br>
References: <20181126173506.24068-1-otavio@ossystems.com.br>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Montag, 26. November 2018, 18:35:03 CET schrieb Otavio Salvador:
> According to the Rockchip vendor tree the PMU interrupt number is
> 76, so fix it accordingly.
> 
> Signed-off-by: Otavio Salvador <otavio@ossystems.com.br>
> Tested-by: Fabio Berton <fabio.berton@ossystems.com.br>

applied for 4.21

Thanks
Heiko


