Return-Path: <SRS0=TO5I=LL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07D5C433F4
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:58:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8766520868
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Aug 2018 22:58:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="kePrG68F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8766520868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbeH2Cwl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Aug 2018 22:52:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:46078 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727067AbeH2Cwk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Aug 2018 22:52:40 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8D3412087D;
        Tue, 28 Aug 2018 22:58:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535497129;
        bh=rcs9XQLWeANryxqa6R9jMZTorw39eqvINm82LTfpaAY=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=kePrG68FUiK+8p5vbTz5dudZ81kJIfrD+cRB9d1iv1NVNwGr7Bci08Z4syssDA2KC
         oSNajzyDyZttFJzIPdMB7NUEpqWP0+8ExTdWxXcM8pJoi48KzgUcQ1mI5z8TqKENIe
         o+fIuka18IfNd6oSdTemgKRmioeyniEc4z0jhax0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Douglas Anderson <dianders@chromium.org>, andy.gross@linaro.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180724174513.174018-3-dianders@chromium.org>
Cc:     tdas@codeaurora.org, girishm@codeaurora.org,
        linux-arm-msm@vger.kernel.org, anischal@codeaurora.org,
        bjorn.andersson@linaro.org, grahamr@codeaurora.org,
        linux-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        linux-kernel@vger.kernel.org, David Brown <david.brown@linaro.org>
References: <20180724174513.174018-1-dianders@chromium.org>
 <20180724174513.174018-3-dianders@chromium.org>
Message-ID: <153549712900.129321.5184166575110028723@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 2/2] clk: qcom: Add qspi (Quad SPI) clocks for sdm845
Date:   Tue, 28 Aug 2018 15:58:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Douglas Anderson (2018-07-24 10:45:13)
> Add both the interface and core clock.
> =

> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> (am from https://lore.kernel.org/patchwork/patch/966680/mbox)
> =

> ---

Applied to clk-next

