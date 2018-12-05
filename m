Return-Path: <SRS0=bZ9D=OO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 557D6C04EBF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177A520700
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Dec 2018 23:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544054287;
	bh=NNtQg/6toV100vCSXm6mwLVBu7ftayn+OySD+GkqFNM=;
	h=To:From:In-Reply-To:Cc:References:Subject:Date:List-ID:From;
	b=oH1Zbq/ABWxNMPSJBsyYusll03FFpdg3s5YQ8nRa0lth54Xi7RyZS4tRNs32IVYPI
	 w4aA3KP7m1eN7JeitovI0PM60vcX7egdq06mtSoc/NxAw+vodIoocRTBNxElf1m7UM
	 gRR+Naraj9w0Xk92M3PhPzX2fy5K3g8NFkPNsVZc=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 177A520700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729064AbeLEX6G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Dec 2018 18:58:06 -0500
Received: from mail.kernel.org ([198.145.29.99]:34690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728772AbeLEX6D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Dec 2018 18:58:03 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 012E5206B7;
        Wed,  5 Dec 2018 23:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544054283;
        bh=NNtQg/6toV100vCSXm6mwLVBu7ftayn+OySD+GkqFNM=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=gfPotBWR1NOxz67BPgdl3qd6zZtMjxQ9JVeIkN54QIPHFZ4peKJeswqtlk4MplEEn
         EV+Z/3EAPccKc1x3d7AlHigOOymwgKZW88gHbaTb91ri4JsGY1Ppp7G2y0FtL6NHip
         H5IWC7Oy01hAT2tXahbtnz14yJdHWtVOLnMbX6QI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181203183330.2073-4-bjorn.andersson@linaro.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Amit Kucheria <amit.kucheria@linaro.org>
References: <20181203183330.2073-1-bjorn.andersson@linaro.org>
 <20181203183330.2073-4-bjorn.andersson@linaro.org>
Message-ID: <154405428239.88331.7011103085906660742@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2 3/3] clk: qcom: gcc-msm8998: Add clkref clocks
Date:   Wed, 05 Dec 2018 15:58:02 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2018-12-03 10:33:30)
> Add clkref clocks for usb3, hdmi, ufs, pcie, and usb2. They are all
> sourced off CXO_IN, so parent them off "xo" until a proper link to the
> rpmcc can be described in DT.
> =

> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Applied to clk-next

