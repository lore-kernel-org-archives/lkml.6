Return-Path: <SRS0=3XDn=JT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 533F5C6778A
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F62123CB9
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Jul 2018 17:11:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="aGKXbFlt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F62123CB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934177AbeGCRLg (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Jul 2018 13:11:36 -0400
Received: from mail.kernel.org ([198.145.29.99]:56722 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933063AbeGCRLd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jul 2018 13:11:33 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 942B823CB9;
        Tue,  3 Jul 2018 17:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1530637892;
        bh=WinYd8MPtX3GUJnYbXl91Z791MYHt/7Qbn8RHYJdBG8=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=aGKXbFlt6ccRhcph4yb0wmfgnxFW+FDboeAAlL32i+7jbGJudWI4ZGs4qK40ef8cD
         HyPA1dnVPeX7bA5OaIyjc4GJx+wtbDzHu3k6ORsZwWv+XlR3LoO/n63kCke/jtE4+3
         XnUpEW76lxWj31Q3MBguZLZpPh+N9q/KMmBV79jQ=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Amit Nischal <anischal@codeaurora.org>,
        Michael Turquette <mturquette@baylibre.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1528699095-17930-1-git-send-email-anischal@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Odelu Kukatla <okukatla@codeaurora.org>,
        Taniya Das <tdas@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Amit Nischal <anischal@codeaurora.org>
References: <1528699095-17930-1-git-send-email-anischal@codeaurora.org>
Message-ID: <153063789182.143105.16360820917715643212@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3] clk: qcom: Enable clocks which needs to be always on for
 SDM845
Date:   Tue, 03 Jul 2018 10:11:31 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Amit Nischal (2018-06-10 23:38:15)
> There are certain clocks which needs to be always enabled for system
> operation. Add support for the same by adding 'CLK_IS_CRITICAL' flag
> for such clocks.
> =

> Signed-off-by: Amit Nischal <anischal@codeaurora.org>
> ---

Applied to clk-next

