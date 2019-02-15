Return-Path: <SRS0=lv5c=QW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 467B3C43381
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 195D821925
	for <linux-kernel@archiver.kernel.org>; Fri, 15 Feb 2019 09:14:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392331AbfBOJOm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 Feb 2019 04:14:42 -0500
Received: from gloria.sntech.de ([185.11.138.130]:59984 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfBOJOl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Feb 2019 04:14:41 -0500
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1guZZb-0000Ao-Mk; Fri, 15 Feb 2019 10:14:19 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     Akash Gajjar <Akash_Gajjar@mentor.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Oskari Lemmela <oskari@lemmela.net>,
        Shohei Maruyama <cheat.sc.linux@outlook.com>,
        Levin Du <djw@t-chip.com.cn>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] arm64: dts: rockchip: rockpro64 dts make regulator more readable
Date:   Fri, 15 Feb 2019 10:14:19 +0100
Message-ID: <3848940.W0AIcLlWW9@diego>
In-Reply-To: <20190213170651.3210-2-Akash_Gajjar@mentor.com>
References: <20190213170651.3210-1-Akash_Gajjar@mentor.com> <20190213170651.3210-2-Akash_Gajjar@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Mittwoch, 13. Februar 2019, 18:06:37 CET schrieb Akash Gajjar:
> rename dc12, vcc_sys, vcc1v8_pmu regulators and make it more redable as per
> the schematic of rk3399-rockpro64.
> 
> Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>

applied for (hopefully) 5.1

Thanks
Heiko


