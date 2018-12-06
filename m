Return-Path: <SRS0=GRxD=OP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A3E1C04EB8
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2ECC920892
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 12:48:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2ECC920892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729506AbeLFMsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Dec 2018 07:48:17 -0500
Received: from gloria.sntech.de ([185.11.138.130]:41732 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727832AbeLFMsR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Dec 2018 07:48:17 -0500
Received: from we0660.dip.tu-dresden.de ([141.76.178.148] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1gUt4c-00066E-6n; Thu, 06 Dec 2018 13:48:10 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Oskari Lemmela <oskari@lemmela.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Akash Gajjar <Akash_Gajjar@mentor.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] arm64: dts: rockchip: rockpro64 fix regulator gpios
Date:   Thu, 06 Dec 2018 13:48:09 +0100
Message-ID: <1745654.q3GSn5YZ1a@phil>
In-Reply-To: <20181201100817.20688-2-oskari@lemmela.net>
References: <20181201100817.20688-1-oskari@lemmela.net> <20181201100817.20688-2-oskari@lemmela.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 1. Dezember 2018, 11:08:16 CET schrieb Oskari Lemmela:
> Rockpro64 is not able boot if GPIO1_C1 pin is pulled high
> before loading linux kernel.
> 
> In rockpro64 GPIO1_C1 pin is connected vdd_cpu_b regulator
> VSEL pin. Pin should be pulled down in normal operation and
> pulled high in suspend.
> 
> PMIC LDO_REG2 is connected to touch panel connector.
> Rename regulator and set it to correct voltage.
> 
> PCIe power is controller by GPIO1_D0.
> 
> Schematics can be downloaded from:
> http://files.pine64.org/doc/rockpro64/rockpro64_v21-SCH.pdf
> 
> Signed-off-by: Oskari Lemmela <oskari@lemmela.net>

applied as fix for 4.20

Thanks
Heiko


