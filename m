Return-Path: <SRS0=uvhX=PT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7220C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A65952184B
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 21:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547243825;
	bh=q08N9m/491eI3HdRPirHlP98g4UFLmrA5depkyfVMc8=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=UWBinw87oDMqOw2zeX84CG+Kn7EHvI6NZRzsoX6uDqC1BZBjHo/+6i1lBb209ftcK
	 oSrWMU7fn5oIVxaclgC6e5ndeq07S8c/5J+ggoVN1+g+g8Xv7zyLOusA7D7EolfXfO
	 q35uhZZp8FsqP2/MScXNWfJfUw7cSaYVvLtwf6Dw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbfAKV5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Jan 2019 16:57:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:53554 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725536AbfAKV5E (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Jan 2019 16:57:04 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D09DE21841;
        Fri, 11 Jan 2019 21:57:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547243823;
        bh=q08N9m/491eI3HdRPirHlP98g4UFLmrA5depkyfVMc8=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=hVE96HrKgM1G79w4oeakMdBbnmbmVw1Xz4q3coTTNTOd3yIkNS0+5/FQaIc1he+mR
         HV3KZ5JdIt2zLsSBtSw2ufGdDX9KpvDeRLlkffirO5w2kNLQW0uzAhhAthfYaraZxx
         CQrUUeca+ePiI8GDYZyqOfzwdit+adE6PAOIKwXU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3 6/6] ARM: dts: qcom: pma8084: add interrupt controller properties
User-Agent: alot/0.8
In-Reply-To: <20190110011258.17227-7-masneyb@onstation.org>
References: <20190110011258.17227-1-masneyb@onstation.org> <20190110011258.17227-7-masneyb@onstation.org>
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
To:     Brian Masney <masneyb@onstation.org>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org
Message-ID: <154724382301.169631.10873741059969967637@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Fri, 11 Jan 2019 13:57:03 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Masney (2019-01-09 17:12:58)
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

