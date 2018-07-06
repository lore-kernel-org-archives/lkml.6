Return-Path: <SRS0=VV0n=JW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 504B7C3279B
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F211B216F9
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Jul 2018 18:24:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mz5RPM3n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F211B216F9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934388AbeGFSYo (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Jul 2018 14:24:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:55320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S934063AbeGFSYm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jul 2018 14:24:42 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 41ACE2254F;
        Fri,  6 Jul 2018 18:24:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530901482;
        bh=QfXsPTYjpsa+8zRbJ0gWjW62/iorK8XDM71DkR19n84=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=mz5RPM3nYgRGBtDtsOL/k5FdxCnZMc7tutkeIOMRwkxelgxKj5g4YJz03ocJA2R/c
         XMzCLrPk0FDFVIXqqAyNfx5Xc3nwXBDSdrRewNK2VCl8uThpTqEmXwQqbH4Lj7jtpJ
         XtTSzfzshITAnvim3Rnlcc0tpRuXD3lxvEvuWja0=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Vivek Gautam <vivek.gautam@codeaurora.org>,
        linux-clk@vger.kernel.org, mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180629113640.11888-1-vivek.gautam@codeaurora.org>
Cc:     andy.gross@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
References: <20180629113640.11888-1-vivek.gautam@codeaurora.org>
Message-ID: <153090148164.143105.10101604037427005480@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH RESEND 1/1] clk/mmcc-msm8996: Make mmagic_bimc_gdsc ALWAYS_ON
Date:   Fri, 06 Jul 2018 11:24:41 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Vivek Gautam (2018-06-29 04:36:40)
> Patch (7705bb7176b9 clk: qcom: mmcc-msm8996: leave all mmagic gdscs
> and clocks always enabled") makes all mmgaic gdscs ALWAYS_ON.
> The mmagic_bimc_gdsc is also needed to be turned on to get display
> working on 8x96.
> =

> Signed-off-by: Vivek Gautam <vivek.gautam@codeaurora.org>
> Cc: Rajendra Nayak <rnayak@codeaurora.org>
> Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
> Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> ---

Applied to clk-fixes

