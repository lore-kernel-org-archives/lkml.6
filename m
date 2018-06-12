Return-Path: <SRS0=cKeY=I6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,T_DKIMWL_WL_HIGH autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (pdx-korg-mail-1.web.codeaurora.org [172.30.200.123])
	by aws-us-west-2-korg-lkml-1.web.codeaurora.org (Postfix) with ESMTP id AF984C433EF
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:57:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 67593208B1
	for <linux-kernel@archiver.kernel.org>; Tue, 12 Jun 2018 07:57:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="jU3VGN4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67593208B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933833AbeFLH5W (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 Jun 2018 03:57:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:58066 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933800AbeFLH5S (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jun 2018 03:57:18 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6B589208AE;
        Tue, 12 Jun 2018 07:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1528790237;
        bh=9OM1OjZd76ZUSI/9MvqDex5SYFKMH3ipLiGGN0BqT/Y=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=jU3VGN4zXCtlOZZx8bx4y6o5TuiQxiCtL0A2D5hc+UFKqAhaUyDgZ3KE8nkgR5AG9
         LC4H+lV7a9RLHA2H9zbqPVvCvhHJTsHtXDxBiZAQrtJySZD5Qu4DB/goIwip9+vbrD
         bCYF6vrHQR/X7ReYfGP8j/31QOwNXfnMDbz4AVVs=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>, robh@kernel.org
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1528098985-3676-2-git-send-email-tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Taniya Das <tdas@codeaurora.org>
References: <1528098985-3676-1-git-send-email-tdas@codeaurora.org>
 <1528098985-3676-2-git-send-email-tdas@codeaurora.org>
Message-ID: <152879023681.16708.17246986117560256860@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/2] dt-bindings: clock: Introduce QCOM Display clock bindings
Date:   Tue, 12 Jun 2018 00:57:16 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-06-04 00:56:24)
> Add device tree bindings for display clock controller for Qualcomm
> Technology Inc's SoCs.

SDM845 SoCs?

