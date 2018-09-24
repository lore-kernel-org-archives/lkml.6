Return-Path: <SRS0=40Mn=MG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06416ECE561
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:44:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE76C2083A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Sep 2018 12:44:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BE76C2083A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=sntech.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389201AbeIXSqi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Sep 2018 14:46:38 -0400
Received: from gloria.sntech.de ([185.11.138.130]:52750 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388693AbeIXSqh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Sep 2018 14:46:37 -0400
Received: from wd0156.dip.tu-dresden.de ([141.76.108.156] helo=phil.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.0:ECDHE_RSA_AES_256_CBC_SHA1:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1g4QE5-0001Dp-TG; Mon, 24 Sep 2018 14:44:33 +0200
From:   Heiko Stuebner <heiko@sntech.de>
To:     Craig Tatlor <ctatlor97@gmail.com>
Cc:     Taniya Das <tdas@codeaurora.org>, linux-arm-msm@vger.kernel.org,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-soc@vger.kernel.org
Subject: Re: [PATCH] clk: qcom: Add Global Clock controller (GCC) driver for SDM660
Date:   Mon, 24 Sep 2018 14:44:33 +0200
Message-ID: <9156720.4hgryJ20kK@phil>
In-Reply-To: <63F4E7C0-6925-4EC0-84B9-75B31AC664E4@gmail.com>
References: <20180407135934.26122-1-ctatlor97@gmail.com> <69cf26ba-5dae-e84c-2fa8-15699fdd9986@codeaurora.org> <63F4E7C0-6925-4EC0-84B9-75B31AC664E4@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Craig,

Am Montag, 13. August 2018, 09:45:09 CEST schrieb Craig Tatlor:
> On 13 August 2018 07:55:34 BST, Taniya Das <tdas@codeaurora.org> wrote:
> >Hello Craig,
> >
> >Could you please correct the authorship and also provide the reference 
> >to code where this is picked from?
> Okay, 
> Got code from here https://github.com/sonyxperiadev/kernel/blob/aosp/LA.UM.6.4.r1/drivers/clk/qcom/gcc-sdm660.c
> but changed it quite a bit for upstream,
> Should I change the commit author and add your signed off by and say I did cleanups on my signed off by.

yep, for something this huge it is really the correct way to keep the
original authorship intact as Taniya did the initial big work, and just
add you change-description, so something like

---- 8< ------
Add support for the global clock controller found on SDM660
based devices. This should allow most non-multimedia device
drivers to probe and control their clocks.
Based on CAF implementation.

Signed-off-by: Taniya Das <tdas@codeaurora.org>
[ description of changes ... often seen in these brackets ]
Signed-off-by: Craig Tatlor <ctatlor97@gmail.com>
---- 8< ------

Also, do you plan to continue working on this, as I would be interessted
in the clock driver for a sdm660-based phone as well.


Thanks
Heiko


