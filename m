Return-Path: <SRS0=TRGe=OU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75312C6783B
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:26:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3962C2084E
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Dec 2018 21:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1544563573;
	bh=cx/LJoXcmXsAMm3oEL8FLB0cxAHt1sjQFwQN2RrEAxg=;
	h=In-Reply-To:To:Subject:From:References:Cc:Date:List-ID:From;
	b=l6QZZY+gKTJQlLai+l725g1E/vRSXEDEE7a4eqmZmrF0ocOyCWHNzniFqzSvYAMYZ
	 ANvpMQf+zeQPxduOgzqbvq6NmGZpSNmpXJo0H4Frg6kskyWTrLZ6RC0yw24zc1VBAB
	 KJpSqwBv2A+booxbDc2cN9lrnoaIu1GQ8v9q99RA=
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3962C2084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726272AbeLKV0M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Dec 2018 16:26:12 -0500
Received: from mail.kernel.org ([198.145.29.99]:34470 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726134AbeLKV0L (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Dec 2018 16:26:11 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1664F2084E;
        Tue, 11 Dec 2018 21:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1544563571;
        bh=cx/LJoXcmXsAMm3oEL8FLB0cxAHt1sjQFwQN2RrEAxg=;
        h=In-Reply-To:To:Subject:From:References:Cc:Date:From;
        b=qn1cKS+xnIyA1vfcZIgRiv3VLvghpdUi2f7Ujm7MDCjKCJHfG/VNxT3bNiL5iF6AH
         zQSK0To6GOJ9b9oOk+MfKSRuPo65boNnXRYAWjsg19hSKZB1++fZ31ic4ynrbk/GDh
         ca24G1ukYwY5hPGoCZoVjIUXsd9bpey5+zEEJSTo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1544558404-1705-1-git-send-email-jhugo@codeaurora.org>
Message-ID: <154456357033.17204.6634705913514698304@swboyd.mtv.corp.google.com>
To:     Jeffrey Hugo <jhugo@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, mturquette@baylibre.com
Subject: Re: [PATCH] clk: qcom: Add missing msm8998 resets
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.7
References: <1544558404-1705-1-git-send-email-jhugo@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
Date:   Tue, 11 Dec 2018 13:26:10 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2018-12-11 12:00:04)
> commit c0cb7c7e7164 ("clk: qcom: Enumerate remaining msm8998 resets")
> missed two USB2 resets.  Add them.
>=20
> Fixes: c0cb7c7e7164 ("clk: qcom: Enumerate remaining msm8998 resets")
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---

Applied to clk-next

