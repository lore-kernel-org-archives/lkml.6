Return-Path: <SRS0=Grn6=OM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D30BC04EB9
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:43:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1E3B2087F
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Dec 2018 17:43:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="rWVrXtlN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1E3B2087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbeLCRnw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Dec 2018 12:43:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:60638 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725897AbeLCRnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Dec 2018 12:43:52 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EC8592087F;
        Mon,  3 Dec 2018 17:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543859030;
        bh=jrXSFucHLNpSvlSJ2AKg4LxzgZaOjk//2di+w9Rc0dY=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=rWVrXtlN0pTcn85YsHbp6ksXruAeyQY0aufEdqaOxuRQUdjnpqLFe6neznJ+5eS6+
         HawGOM6/beRNc3X6nQcQkEkeVzixO2eKGepfW/jJt1vqAIEuBg6d+CQ4NemwC2baf8
         qdDYPoKwkWCTAvg5+mf54N1j+iC2HDPHpmqQKJEU=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1543602089-21086-2-git-send-email-tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, robh@kernel.org,
        Taniya Das <tdas@codeaurora.org>
References: <1543602089-21086-1-git-send-email-tdas@codeaurora.org>
 <1543602089-21086-2-git-send-email-tdas@codeaurora.org>
Message-ID: <154385902929.88331.6843653112634311896@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v11 1/3] dt-bindings: clock: Update GCC bindings for
 protected-clocks
Date:   Mon, 03 Dec 2018 09:43:49 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-11-30 10:21:27)
> Add protected-clocks list which could used to specify the clocks to be
> bypassed on certain devices.
> =

> Reviewed-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Applied to clk-next

