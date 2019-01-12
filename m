Return-Path: <SRS0=UXoZ=PU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F649C43387
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:24:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF8B20836
	for <linux-kernel@archiver.kernel.org>; Sat, 12 Jan 2019 19:24:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfALTYd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 12 Jan 2019 14:24:33 -0500
Received: from gloria.sntech.de ([185.11.138.130]:41808 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726617AbfALTYc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Jan 2019 14:24:32 -0500
Received: from p54b26ced.dip0.t-ipconnect.de ([84.178.108.237] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1giOtM-0006p6-8d; Sat, 12 Jan 2019 20:24:24 +0100
From:   Heiko Stuebner <heiko@sntech.de>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     hjc@rock-chips.com, airlied@linux.ie, robh+dt@kernel.org,
        mark.rutland@arm.com, mturquette@baylibre.com, sboyd@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v2 5/7] ARM: dts: rockchip: add rk3066 vop display nodes
Date:   Sat, 12 Jan 2019 20:24:23 +0100
Message-ID: <2822435.PgMx1mWbPR@phil>
In-Reply-To: <20181229133318.18128-6-jbx6244@gmail.com>
References: <20181229133318.18128-1-jbx6244@gmail.com> <20181229133318.18128-6-jbx6244@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am Samstag, 29. Dezember 2018, 14:33:16 CET schrieb Johan Jonker:
> From: Mark Yao <mark.yao@rock-chips.com>
> 
> This patch adds the core display subsystem and vop nodes to rk3066.
> 
> Signed-off-by: Mark Yao <mark.yao@rock-chips.com>
> Signed-off-by: Johan Jonker <jbx6244@gmail.com>

applied for 5.1

Thanks
Heiko


