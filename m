Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBD6C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 33A7820657
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547510005;
	bh=ex6YdagVXmtPPG2vl9ZeBYZjZSh2wWlvK7ekrWhIqcE=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=TiAZvLaLtgVq5sNwAcHRWHAJJ9uo/P9w/GEEVSrQFxmUWs6/+/KUgPXEtelW10+vm
	 5uPvjuxc28cOYB67EtX7S+pJmDsCVRes7KWYgl+e1PvC8Qbv+iJ9Y+fe2T0bmAGGgn
	 6byWv4nWxVIrw5cdG0zw6leV7GQsYsgS6XNqyNN0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727390AbfANXxX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:53:23 -0500
Received: from mail.kernel.org ([198.145.29.99]:38162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727247AbfANXw6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 18:52:58 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8C13D206BA;
        Mon, 14 Jan 2019 23:44:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547509458;
        bh=ex6YdagVXmtPPG2vl9ZeBYZjZSh2wWlvK7ekrWhIqcE=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=c4OG3htWD9UHBMwckhQ2ZAEOwBwNzjIHD/1JIXVomuKLFuPeG4Nfg7pnYXbwHsXd2
         E6q+sdJMUAxyt+ylLB+giljS152xAWvgOzbqQeubECxGtRrBn9iFwl50kRtyPRMz0J
         ABNxf2Z4YzNmYgXWGyInnRbUDlSEW7wlp+D2/Ie4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 11/14] arm64: dts: qcom: pm8998: add interrupt controller properties
User-Agent: alot/0.8
In-Reply-To: <20190113154716.5145-12-masneyb@onstation.org>
References: <20190113154716.5145-1-masneyb@onstation.org> <20190113154716.5145-12-masneyb@onstation.org>
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
To:     Brian Masney <masneyb@onstation.org>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org
Message-ID: <154750945790.169631.8864796591953737083@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Mon, 14 Jan 2019 15:44:17 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Masney (2019-01-13 07:47:13)
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

