Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F812C07E85
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:00:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BD5A20848
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 18:00:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="r/Nt2KCN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0BD5A20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726870AbeLCSAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 13:00:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:40992 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbeLCSAO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 13:00:14 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3D7E920848;
        Mon,  3 Dec 2018 18:00:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543860009;
        bh=sqBA184PpFR2QSHon8NpPSLk8hM29YPg+v/cSM3Yzyk=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=r/Nt2KCNTgWYZPDJpGy3M1qg/vaKgMPw+RrWmqmpeWcOUns1dP4IhpTkoKOCJVEbC
         G0bHo+BFENMMi0LL45usf06SD0DxKzIkVH/4SEqITXRq9Vr1Wt7znqiMkTW86BVnI+
         GiM2Xrjc9MLz4JcCjBCp8fkKdBa+64pYrVS/wxEg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Jeffrey Hugo <jhugo@codeaurora.org>, andy.gross@linaro.org,
        david.brown@linaro.org, mturquette@baylibre.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1543853623-7846-1-git-send-email-jhugo@codeaurora.org>
Cc:     bjorn.andersson@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeffrey Hugo <jhugo@codeaurora.org>
References: <1543853623-7846-1-git-send-email-jhugo@codeaurora.org>
Message-ID: <154386000851.88331.17854973463402271261@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v2] clk: qcom: Fix MSM8998 resets
Date:   Mon, 03 Dec 2018 10:00:08 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Jeffrey Hugo (2018-12-03 08:13:43)
> The offsets for the defined BCR reset registers does not match the hardwa=
re
> documentation.  Update the values to match the hardware documentation.
> =

> Fixes: b5f5f525c547 (clk: qcom: Add MSM8998 Global Clock Control (GCC) dr=
iver)
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---

Applied to clk-next

