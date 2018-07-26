Return-Path: <SRS0=7Z+k=KK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A2CEC6778F
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:23:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23DE620846
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Jul 2018 17:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="EqGpAyrn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 23DE620846
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388932AbeGZSlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Jul 2018 14:41:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:40474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387912AbeGZSlK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jul 2018 14:41:10 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 16BD820647;
        Thu, 26 Jul 2018 17:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532625804;
        bh=9g0UobAG5Lfa/JvT/fzPLeHm6oVehdF3TT6QrmXls8c=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=EqGpAyrnMfnmBn/Gh0qs8fV5MuWA7yyOt2YWyYErh/dJhXPKcSMPy82Q1z3yYbKfD
         7ztv+OWuccFjYrv9Sp/jc4dPOQvzcT+SfPBbvoySnVzlc7zIxjLyKl8zauQKqWw1kt
         L4BkibBKRh+EJQjtxedb+2c6d6MqbVeuePCCBoK4=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Amit Nischal <anischal@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1532345193-18108-2-git-send-email-anischal@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>
References: <1532345193-18108-1-git-send-email-anischal@codeaurora.org>
 <1532345193-18108-2-git-send-email-anischal@codeaurora.org>
Message-ID: <153262580346.48062.1344515869379719444@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH 1/2] dt-bindings: clock: Introduce QCOM Camera clock bindings
Date:   Thu, 26 Jul 2018 10:23:23 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Nischal (2018-07-23 04:26:32)
> Add device tree bindings for camera clock controller for
> Qualcomm Technology Inc's SDM845 SoCs.
> =

> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
> ---

Applied to clk-next

