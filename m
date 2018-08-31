Return-Path: <SRS0=Pvhj=LO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD2DC433F4
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:27:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA04320837
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Aug 2018 01:27:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/SUBQ5M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA04320837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727458AbeHaFcr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Aug 2018 01:32:47 -0400
Received: from mail.kernel.org ([198.145.29.99]:45026 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725807AbeHaFcr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Aug 2018 01:32:47 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0914D20837;
        Fri, 31 Aug 2018 01:27:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535678870;
        bh=KhKyCwFVTo2vZA9MyfLPYo+up6fuIOP8bu5fmzgYXHI=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=a/SUBQ5MDjNbhffafVtRYIE36FpxCFv9zCcbUbdEheiqx5u9FrNcbnZouatZeRbqG
         plr1F+nSns+h0u3vIgZpFz4pTmDiEnhFoDfEeJValBFX1LFqWQE/wY5T3PZxBo+5QK
         6gCemXhgsg6rWUx+jraRKItgO9tOb0fv0iN3Cjg0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Amit Nischal <anischal@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1533725239-14214-2-git-send-email-anischal@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>
References: <1533725239-14214-1-git-send-email-anischal@codeaurora.org>
 <1533725239-14214-2-git-send-email-anischal@codeaurora.org>
Message-ID: <153567886934.93865.7315233769224403089@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3] clk: qcom: Add camera clock controller driver for SDM845
Date:   Thu, 30 Aug 2018 18:27:49 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Nischal (2018-08-08 03:47:19)
> Add support for the camera clock controller found on SDM845
> based devices. This would allow camera drivers to probe and
> control their clocks.
> =

> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
> ---

Applied to clk-next

