Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17102C04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CB31C2081C
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 23:56:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="R1GJEA+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB31C2081C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbeLCX4k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 18:56:40 -0500
Received: from mail.kernel.org ([198.145.29.99]:51906 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725903AbeLCX4i (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 18:56:38 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 7FAC02073D;
        Mon,  3 Dec 2018 23:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543881397;
        bh=6tlG/xZ6+c9wLMf7+QD/g7Jcvn+v9jInTiXNWqzdx2Y=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=R1GJEA+T2LUUr9VcVjJqFHZ5ZdESonTiLfbamD0C/IuXzs68gwMBm7zwa8QglAD5u
         UhK2wPyPIaiLamUVEMAPnVuKNDoTG1FKI2l6IcfLwr9IrN6Jqp+NZT4zoEkB6KkSoc
         zr25dicFNZBmzE4p8ReHuuDjYsRddiVHrfD3uymo=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Andy Gross <andy.gross@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        David Brown <david.brown@linaro.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181130065655.26713-1-bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181130065655.26713-1-bjorn.andersson@linaro.org>
Message-ID: <154388139680.88331.14830807298283280853@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] arm64: dts: qcom: msm8998: Fix compatible of scm node
Date:   Mon, 03 Dec 2018 15:56:36 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Bjorn Andersson (2018-11-29 22:56:55)
> The scm binding and driver was updated to rely on the fallback to the
> default qcom,scm for any modern SoC and as such both are required. Add
> the default compatible to make the scm instance probe.
> =

> Fixes: d850156a226a ("arm64: dts: qcom: msm8998: Add firmware node")
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Reviewed-by: Stephen Boyd <sboyd@kernel.org>

