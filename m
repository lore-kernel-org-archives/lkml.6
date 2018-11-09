Return-Path: <SRS0=IvFc=NU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 603B1C43441
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 05:02:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0E6802086C
	for <linux-kernel@archiver.kernel.org>; Fri,  9 Nov 2018 05:02:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKe/W6vF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E6802086C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbeKIOlB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 9 Nov 2018 09:41:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:53698 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727474AbeKIOlB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Nov 2018 09:41:01 -0500
Received: from localhost (unknown [171.76.98.79])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8369B20825;
        Fri,  9 Nov 2018 05:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541739730;
        bh=r5G1rLwWhHyIkCRtFR3nrunoqLnSXRCNWd7gHFTJRIs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YKe/W6vFfwU6eGnRyLBOUjEq+PAZTf6ap/ba4SIb07D4eGkH08lTmQvz54HPRl33e
         aDMjyhGb64YG5hGQapdhC+f9dIZLfwZ3vLxDe+Kd3oggTAIwwoTVR3AKFAlznYKVZB
         cBGOoYjs54MeJEvJVVLPgA8Zg6yfps7ACN7n74qw=
Date:   Fri, 9 Nov 2018 10:32:01 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 12/18] arm64: dts: qcom: pms405: add gpios
Message-ID: <20181109050201.GJ12092@vkoul-mobl>
References: <20181108184009.18430-1-vkoul@kernel.org>
 <20181108184009.18430-13-vkoul@kernel.org>
 <CAL_JsqJSszvQ0QC0LLT4ho+xMgiMJRVJyrM93OgH21Neu6xMqw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL_JsqJSszvQ0QC0LLT4ho+xMgiMJRVJyrM93OgH21Neu6xMqw@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08-11-18, 15:42, Rob Herring wrote:
> On Thu, Nov 8, 2018 at 12:41 PM Vinod Koul <vkoul@kernel.org> wrote:
> >
> > Add the GPIOs present on PMS405 chip.
> >
> > Signed-off-by: Vinod Koul <vkoul@kernel.org>
> > ---
> >  arch/arm64/boot/dts/qcom/pms405.dtsi | 19 +++++++++++++++++++
> >  1 file changed, 19 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/pms405.dtsi b/arch/arm64/boot/dts/qcom/pms405.dtsi
> > index 2b275bbdafa3..85a3228abaf9 100644
> > --- a/arch/arm64/boot/dts/qcom/pms405.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/pms405.dtsi
> > @@ -10,6 +10,25 @@
> >                 #address-cells = <1>;
> >                 #size-cells = <0>;
> >
> > +               pms405_gpios: gpios@c000 {
> 
> gpio@...

OK will update...

-- 
~Vinod
