Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CAE3C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:53:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D8657206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547509992;
	bh=sPDbrRsvkLL+xxqmPkGSHnzgPyhg9er1dIGFpQoe6Hw=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=yR7ZxPRWjA8OHJU+6c6zqmkiByPjJ6NrNnXN1AiMPtWJ5r/mveQGjaLR169guWxn9
	 hJeMrRakveqayMMvZlSaa3Uwv4RhxYP+rM3USB4lT+aAzWvfczpiQQjzCo2Cwd/7Ov
	 ENlYPVirxC3oW4jCCuwEelDh/UgwEg7XWLw9ThQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727355AbfANXxF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:53:05 -0500
Received: from mail.kernel.org ([198.145.29.99]:38158 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbfANXw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 18:52:58 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D12A120657;
        Mon, 14 Jan 2019 23:43:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547509425;
        bh=sPDbrRsvkLL+xxqmPkGSHnzgPyhg9er1dIGFpQoe6Hw=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=Asag9XIOPwXgLzPKpw+fN3vvxVqEss20XfxbB9eFjs2tP933XKKgf16gW1uTTF7Xg
         c7Kf5OHceFR+KqWSFriFSdjPEdPwDwv8yMPAuXmxKsEOnfPI/vmfBOv6VmlIZ6rmAq
         cNndOdCBaTa7HpJ+tmtBQxuotXnYY86GYCWdvrpI=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 13/14] arm64: dts: qcom: pmi8998: add interrupt controller properties
User-Agent: alot/0.8
In-Reply-To: <20190113154716.5145-14-masneyb@onstation.org>
References: <20190113154716.5145-1-masneyb@onstation.org> <20190113154716.5145-14-masneyb@onstation.org>
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
To:     Brian Masney <masneyb@onstation.org>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org
Message-ID: <154750942515.169631.3493832994858414803@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Mon, 14 Jan 2019 15:43:45 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Masney (2019-01-13 07:47:15)
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

