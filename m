Return-Path: <SRS0=bKrn=NQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F662C0044C
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:21:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 626702085A
	for <linux-kernel@archiver.kernel.org>; Mon,  5 Nov 2018 23:21:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XX8n7rGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 626702085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbeKFInn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 6 Nov 2018 03:43:43 -0500
Received: from mail.kernel.org ([198.145.29.99]:52346 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725751AbeKFInn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Nov 2018 03:43:43 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C6A92085A;
        Mon,  5 Nov 2018 23:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1541460095;
        bh=tro0WHJ9IHInCnIlK0dkB2qpINcjgvD+wN9XRZpxQFc=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=XX8n7rGfUplvcgGtcvA9/fQfYPSK2SmbdEjjlLL3xT/PIJs/SwsuMYhkITBRQS+oM
         aExh+tvFx14ZC1dzeCZfxn5hZyBY2S8b98KWGANFIrkQVa3YiQ4alaQYWuv4/fQ9Bl
         8jYch9sl/PNKJydWzXEnFy1vAtus7uYB4H9NBOcA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1541414117-27864-1-git-send-email-tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        Taniya Das <tdas@codeaurora.org>
References: <1541414117-27864-1-git-send-email-tdas@codeaurora.org>
Message-ID: <154146009460.88331.6359450184767946173@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] arm64: dts: sdm845: Add videocc node
Date:   Mon, 05 Nov 2018 15:21:34 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-11-05 02:35:17)
> This adds the video clock controller node to sdm845 based on the examples
> in the bindings.
> =

> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Did you mean to send "To:" Andy? Clk tree doesn't take these sorts of
dts patches.

