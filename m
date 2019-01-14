Return-Path: <SRS0=tq6k=PW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02547C43387
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:45:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BE7B820883
	for <linux-kernel@archiver.kernel.org>; Mon, 14 Jan 2019 23:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547509511;
	bh=LIaMb+YFU44o+OvhNCMM3PHoA72ertXLI9cj5uaR8cc=;
	h=Subject:In-Reply-To:References:Cc:To:From:Date:List-ID:From;
	b=PyrVnIOHQA0Fk1/CH4cKuaglLRGBmtjV/eSSE9ZG3SX7H1hNcg2J/FqOk5n/eumWV
	 OGGxXdzzXDssJiKREi12HdwiQVIKFzt4cyo+J7+XAfuDpxPEZrZ/1HvHY8Qh9cYnJq
	 9CBxLe/g9DY8+Ir78xW2WhCXKK4FNFC/d261rkOo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727231AbfANXov (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 14 Jan 2019 18:44:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:35530 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726886AbfANXnC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Jan 2019 18:43:02 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D76EE2064C;
        Mon, 14 Jan 2019 23:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547509382;
        bh=LIaMb+YFU44o+OvhNCMM3PHoA72ertXLI9cj5uaR8cc=;
        h=Subject:In-Reply-To:References:Cc:To:From:Date:From;
        b=Hk+aCSc3qXdFP8TCIDkMCuIgEuS0EPEPBQnp/1YrdNzKKf7F+kXHX3lQBhvqQ5e6/
         v5e6MK+xwaF1jz+00ZlhzhohsUeHnww0gZ7s7g6QcRNU9knDkF3Qa1G+niYgJECnih
         SoEDDw8pI50xhgAK3puN9WhDQ2/logsx3tQkidAk=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 02/14] pinctrl: qcom: spmi-gpio: add support for three new variants
User-Agent: alot/0.8
In-Reply-To: <20190113154716.5145-3-masneyb@onstation.org>
References: <20190113154716.5145-1-masneyb@onstation.org> <20190113154716.5145-3-masneyb@onstation.org>
Cc:     marc.zyngier@arm.com, shawnguo@kernel.org, dianders@chromium.org,
        linux-gpio@vger.kernel.org, nicolas.dechesne@linaro.org,
        niklas.cassel@linaro.org, david.brown@linaro.org,
        robh+dt@kernel.org, mark.rutland@arm.com, thierry.reding@gmail.com,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
To:     Brian Masney <masneyb@onstation.org>, andy.gross@linaro.org,
        bjorn.andersson@linaro.org, linus.walleij@linaro.org
Message-ID: <154750938117.169631.3470865695587128631@swboyd.mtv.corp.google.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Mon, 14 Jan 2019 15:43:01 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Brian Masney (2019-01-13 07:47:04)
> Add support for qcom,pm8005-gpio, qcom,pm8998-gpio, and
> qcom,pmi8998-gpio. These three variants are already in use in some
> arm64 dtsi files. Those boards work since the generic binding
> qcom,spmi-gpio is also specified.
>=20
> Signed-off-by: Brian Masney <masneyb@onstation.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

