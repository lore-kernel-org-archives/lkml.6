Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A649AC433F5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:58:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 45E642087E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:58:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rOyOz6p6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45E642087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbeH2Cwi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:52:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:45996 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbeH2Cwh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:52:37 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id BF55220868;
        Tue, 28 Aug 2018 22:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535497126;
        bh=MGKbJG8RPTfJg+ipA++JDY+sxpc9VaWBoR+TriAPhNE=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=rOyOz6p6+giB/JK6KzXlr5N695WkBmTLX+tSLnyMSmaJNEp1e3bLnvW8322d7FBh4
         35OMUI2F/Sam76bWZsm3fujAXCrcKsA09OjHY25dLNZ+cAyUhwl9nymixyNO2eFydd
         wPeXhFgCzJKo9pyZfOjuUKGkwddtDgLU9x5cBM3E=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Douglas Anderson <dianders@chromium.org>, andy.gross@linaro.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180724174513.174018-2-dianders@chromium.org>
Cc:     tdas@codeaurora.org, girishm@codeaurora.org,
        linux-arm-msm@vger.kernel.org, anischal@codeaurora.org,
        bjorn.andersson@linaro.org, grahamr@codeaurora.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
References: <20180724174513.174018-1-dianders@chromium.org>
 <20180724174513.174018-2-dianders@chromium.org>
Message-ID: <153549712610.129321.16004641950033414292@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 1/2] clk: qcom: Add qspi (Quad SPI) clock defines for sdm845
 to header
Date:   Tue, 28 Aug 2018 15:58:46 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2018-07-24 10:45:12)
> These clocks will need to be defined in the clock driver and
> referenced in device tree files.
> =

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Applied to clk-next

