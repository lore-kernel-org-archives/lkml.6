Return-Path: <SRS0=0/YT=MK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F0C4C43143
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:52:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6BC320779
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Sep 2018 18:52:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KT2HfnkI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6BC320779
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726755AbeI2BRH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Sep 2018 21:17:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:47476 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbeI2BRH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Sep 2018 21:17:07 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F0A6220779;
        Fri, 28 Sep 2018 18:52:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1538160721;
        bh=GRC1d/CHlfQxfTL1mfniDCIxVXbsAXzvcdc5SjWQc94=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=KT2HfnkIkMBcNgR7E0JAATJSTxa2myiMY1njI7exdcVdfLT3Sm6vsvbBiFPMPqyzx
         8KmngO1g4vMPIhs0URpGpOpvfLN8zcUIV12pIzpxjE1O34pVMCDkWzY6xKWtBmNO76
         SFHCipBc3FSLUkGUBFVjCzqWxdEW+I2v0Q75UvFc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1537266338-18661-2-git-send-email-tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        Taniya Das <tdas@codeaurora.org>
References: <1537266338-18661-1-git-send-email-tdas@codeaurora.org>
 <1537266338-18661-2-git-send-email-tdas@codeaurora.org>
Message-ID: <153816072037.119890.18002276806722272121@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v5 1/2] dt-bindings: clock: Introduce QCOM LPASS clock bindings
Date:   Fri, 28 Sep 2018 11:52:00 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-09-18 03:25:37)
> Add device tree bindings for Low Power Audio subsystem clock controller f=
or
> Qualcomm Technology Inc's SDM845 SoCs.
> =

> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Applied to clk-next

