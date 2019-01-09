Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 281F6C43387
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7BFD2183F
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547062965;
	bh=bHvLiL+mJwW4hxgJNVXeE/kVSEfp9vZrHOQeoC8Z7v8=;
	h=Subject:Cc:To:In-Reply-To:From:References:Date:List-ID:From;
	b=ag0s4BnkpHxWAdkZWv7FkW0p5qXqPVHVAz2GtdLZbcd3e1MVS94OaEomC/RKolZUo
	 d8ey2c4Sycoa1pmu2p+Wdn9i0wgS0b5rESzDzce1Xm0WhkNwZ6bv2aAFz8VnbNZUGU
	 juKlu2Ef3vBa/ykQ5PcW7/TR/RecPmiw3sy85R1U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728469AbfAITmn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:42:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:40970 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727123AbfAITmm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:42:42 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 435FD20859;
        Wed,  9 Jan 2019 19:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547062962;
        bh=bHvLiL+mJwW4hxgJNVXeE/kVSEfp9vZrHOQeoC8Z7v8=;
        h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
        b=HjyY+OUZnykC7jJS30GrHIcq0NM8aLRATGNz4coY5yeyuaw+7QlsuVZJSAuBhs9al
         D841//UCetpMaaFXzCh/FeC6u/10x7aeO+ZgLGwhFgu222U8BxASCjdJrw9ZW7+i58
         6rvmmrOPQ1jhmjPT5va+88/pk4DMLRczxYCqYoa0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v2 2/2] clk: Add Fixed MMIO clock driver
Cc:     linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jan Kotas <jank@cadence.com>
To:     Jan Kotas <jank@cadence.com>, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org
In-Reply-To: <20181213124929.32736-3-jank@cadence.com>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <20181213124929.32736-1-jank@cadence.com> <20181213124929.32736-3-jank@cadence.com>
Message-ID: <154706296156.15366.5318350293286114474@swboyd.mtv.corp.google.com>
Date:   Wed, 09 Jan 2019 11:42:41 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jan Kotas (2018-12-13 04:49:29)
> This patch adds a driver for Fixed MMIO clock.
> The driver reads a clock frequency value from a single 32-bit memory
> mapped register and registers it as a fixed rate clock.
>=20
> It can be enabled with COMMON_CLK_FIXED_MMIO Kconfig option.
>=20
> Signed-off-by: Jan Kotas <jank@cadence.com>
> ---

Applied to clk-next

