Return-Path: <SRS0=Tk4m=PR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AD1FC43612
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 173D621738
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Jan 2019 19:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1547063271;
	bh=qnDHRDfhu6JUMijVGvfdtRpMOGYTHWf5ASgGbTiV6hM=;
	h=Subject:Cc:To:In-Reply-To:From:References:Date:List-ID:From;
	b=bJ5Q/qVjETt+c2tZtj23vMekbeMA3Lza2t9qOTab8++eVuQHCUPOewlHhb/DdNtJr
	 2bKgxUrzqc3HHsIPhFz6b7LCT8DgNYl7TTrU7zhkB1EnvPczAfsWYAzkObRkQNDkb5
	 tHQCbB4VGZjpt/5PJTWVoemuDKOl5LrOjvvPxzEs=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728478AbfAITru (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Jan 2019 14:47:50 -0500
Received: from mail.kernel.org ([198.145.29.99]:41760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728356AbfAITru (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Jan 2019 14:47:50 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 68D7220859;
        Wed,  9 Jan 2019 19:47:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1547063269;
        bh=qnDHRDfhu6JUMijVGvfdtRpMOGYTHWf5ASgGbTiV6hM=;
        h=Subject:Cc:To:In-Reply-To:From:References:Date:From;
        b=LdLkIHhw/yAkcGR+DzRGHazdSHux0IrtezaNRIX9QC0hAVW3WwP8ogb1CZM29TWqD
         X72fpCA1XuWvSsATjqqUkiHyQr+4/6gVmA9LWN2Ne6YHtH3f6GRAuQ1Ud5DPgeWUDh
         LwHNjGuNJv2E11b8wYwxki/RNTOJSuVCOA9nQpUQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4] clk: qcom: smd: Add support for MSM8998 rpm clocks
Cc:     bjorn.andersson@linaro.org, marc.w.gonzalez@free.fr,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
To:     Jeffrey Hugo <jhugo@codeaurora.org>, mark.rutland@arm.com,
        mturquette@baylibre.com, robh+dt@kernel.org
In-Reply-To: <1545099336-5615-1-git-send-email-jhugo@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
User-Agent: alot/0.8
References: <1545099336-5615-1-git-send-email-jhugo@codeaurora.org>
Message-ID: <154706326873.15366.13916510775003275204@swboyd.mtv.corp.google.com>
Date:   Wed, 09 Jan 2019 11:47:48 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2018-12-17 18:15:36)
> Add rpm smd clocks, PMIC and bus clocks which are required on MSM8998
> for clients to vote on.
>=20
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---

Applied to clk-next

