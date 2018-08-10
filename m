Return-Path: <SRS0=aVpA=KZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713DEC46464
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:11:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 21F9322402
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Aug 2018 15:11:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rS43PIKo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21F9322402
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbeHJRl2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Aug 2018 13:41:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:40606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727381AbeHJRl2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Aug 2018 13:41:28 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 66903223FF;
        Fri, 10 Aug 2018 15:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533913872;
        bh=X/OIsil/dre8jQJSDyizABNVKTlZeNvjVEH+4HPPgXQ=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=rS43PIKoT+OXKQroPIs3vXEVR9vuOiC9gUR/ReD6fJA7TpBOpKzi4FKN+2fp2BjHF
         5Yn6JD7VDVD35wwO/y5WhoshBAJmrU+eYoI9oIp2AtIRv86j8RpLRArORpbalsNuK3
         uwkTYPnoXCC47WSdXtpHPvnf3YdFti2UNtLs8WGw=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180809220119.18932-1-bjorn.andersson@linaro.org>
Cc:     Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20180809220119.18932-1-bjorn.andersson@linaro.org>
Message-ID: <153391387168.37448.10798348572941173469@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2] clk: qcom: Add some missing gcc clks for msm8996
Date:   Fri, 10 Aug 2018 08:11:11 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2018-08-09 15:01:19)
> From: Rajendra Nayak <rnayak@codeaurora.org>
> =

> Add a few missing gcc clks for msm8996
> =

> Signed-off-by: Rajendra Nayak <rnayak@codeaurora.org>
> [bjorn: omit aggre0_noc_qosgen_extref_clk]
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

This is still going on?! I'm going to ignore Rob's auto email on this
patch.

