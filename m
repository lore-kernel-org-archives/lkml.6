Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D8B3C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:40:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03AF6248BC
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 18:40:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03AF6248BC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934512AbeGCSkx (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 14:40:53 -0400
Received: from gloria.sntech.de ([185.11.138.130]:45434 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934381AbeGCSkw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 14:40:52 -0400
Received: from x2f7fb7b.dyn.telefonica.de ([2.247.251.123] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1faQED-0003Fm-1N; Tue, 03 Jul 2018 20:40:41 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Randy Li <ayaka@soulik.info>
Cc:     linux-rockchip@lists.infradead.org, shawn.lin@rock-chips.com,
        klaus.goger@theobroma-systems.com, mark.rutland@arm.com,
        devicetree@vger.kernel.org, catalin.marinas@arm.com,
        will.deacon@arm.com, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] ARM64: dts: rockchip: add some pins to rk3399
Date:   Tue, 03 Jul 2018 20:40:39 +0200
Message-ID: <2032713.mjOMvqe6Sx@phil>
In-Reply-To: <20180621133210.9359-1-ayaka@soulik.info>
References: <20180621133210.9359-1-ayaka@soulik.info>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Donnerstag, 21. Juni 2018, 15:32:10 CEST schrieb Randy Li:
> Those pins would be used by many boards.
> 
> Signed-off-by: Randy Li <ayaka@soulik.info>

applied for 4.19 after fixing the subject (arm64 instead of ARM64 and
removing an unnecessary new blank line)


Thanks
Heiko



