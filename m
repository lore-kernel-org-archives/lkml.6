Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2E31C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:52:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BF4142070B
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547509979;
	bh=vAOKz+ghu/flH20E3esI+3yQNEXJ9AZKzNOSovw5N7M=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=uN+xo920h/hk9L1uwiSgAp56oJ139LcTO9KaGPjme/o+6zy1OU/GkBznfoSfYvT29
	 Id05bvUYCgPqHd/TvPdw8qHk21v0Y3vUisoDAEO4kCnRVQPBdOuVwF2BDakNJxbgLf
	 utPm8KTgyCc0oZmzcZZXZP7ZgB4BcWxkhZ/Rsi9A=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727311AbfANXw6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:52:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:38160 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727162AbfANXw5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 18:52:57 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B62092086D;
        Mon, 14 Jan 2019 23:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547509466;
        bh=vAOKz+ghu/flH20E3esI+3yQNEXJ9AZKzNOSovw5N7M=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=t5q5/cF0fmbW0PffBNdUOMiK8woK6K4R0P4Eqw6ROxUV9sG7DN1gWVqhdWauvMKXP
         B+HmWY0WbmHoJevyqz+mUva1o9Injbe85aYM9VT2L+LMigsxCMX0b4dTzA0WCR8B82
         SzPzsP8PP5020CTA7QYoCTgFt52PsIm6mJNkf/5s=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 10/14] arm64: dts: qcom: pm8005: add interrupt controller properties
User-Agent: alot/0.8
In-Reply-To: <20190113154716.5145-11-masneyb@onstation.org>
References: <20190113154716.5145-1-masneyb@onstation.org> <20190113154716.5145-11-masneyb@onstation.org>
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
To:     Brian Masney <masneyb@onstation.org>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org
Message-ID: <154750946602.169631.8968643639464096663@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Mon, 14 Jan 2019 15:44:26 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Masney (2019-01-13 07:47:12)
> Add interrupt controller properties now that spmi-gpio is a proper
> hierarchical IRQ chip. The interrupts property is no longer needed so
> remove it.
>=20
> This change was not tested on any hardware but the same change was
> tested on qcom-pm8941.dtsi using a LG Nexus 5 (hammerhead) phone with
> no issues.
>=20
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

