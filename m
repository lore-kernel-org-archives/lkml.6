Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D11ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1102320833
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:58:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1102320833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731494AbeIXTAx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 15:00:53 -0400
Received: from gloria.sntech.de ([185.11.138.130]:52850 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728650AbeIXTAw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 15:00:52 -0400
Received: from wd0156.dip.tu-dresden.de ([141.76.108.156] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1g4QRM-0001HS-9y; Mon, 24 Sep 2018 14:58:16 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Akash Gajjar <Akash_Gajjar@mentor.com>
Cc:     Deepak_Das@mentor.com, Pragnesh_Patel@mentor.com,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Brian Norris <briannorris@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Nickey Yang <nickey.yang@rock-chips.com>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Randy Li <ayaka@soulik.info>, Chris Zhong <zyw@rock-chips.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: rockchip: update pinmux setting in rk3399.dtsi
Date:   Mon, 24 Sep 2018 14:58:15 +0200
Message-ID: <1621920.B7a7Pky3iO@phil>
In-Reply-To: <1537368317-22170-1-git-send-email-Akash_Gajjar@mentor.com>
References: <Akash_Gajjar@mentor.com> <1537368317-22170-1-git-send-email-Akash_Gajjar@mentor.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Akash,

Am Mittwoch, 19. September 2018, 16:45:15 CEST schrieb Akash Gajjar:
> replace pin numbers with equivalent pin macro in rk3399.dtsi
> 
> Signed-off-by: Akash Gajjar <Akash_Gajjar@mentor.com>

so far my "policy" has been to have new stuff use the constants
but not mass-converting the old entries, due to me being anxious
about accidentially breaking some seldom used settings.

With the newly added linebreaks your change looks pretty much hand-
generated, so I guess there is a bit of probability for typos creeping in
and it of course also only adapts one of the Rockchip socs.

So while I _may_ be persuaded of a scripted conversion [including seeing
the script] doing all Rockchip socs (per architecture) at once, I currently
somehow prefer keeping the status quo ;-)


Heiko


