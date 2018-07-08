Return-Path: <SRS0=ZPnh=JY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CF41C3279B
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 23:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 10110208CA
	for <linux-kernel@archiver.kernel.org>; Sun,  8 Jul 2018 23:49:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="E/AYdbGI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 10110208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933286AbeGHXtm (ORCPT <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 8 Jul 2018 19:49:42 -0400
Received: from mail.kernel.org ([198.145.29.99]:58096 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933040AbeGHXtl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jul 2018 19:49:41 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5ED25208CA;
        Sun,  8 Jul 2018 23:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1531093780;
        bh=vSj6Ssir6tnRjcUW8Dtr2A9eac0woOxUtRQfxTMzE5A=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=E/AYdbGIV2v9itTFoD4wjr3JH5lvdMHZTNd6qqpAgSepsQQxlfCJ6hI9oUHQBaRnr
         SjxmV5ZB+onmt3cfzKKQsdIOoggdXGp/P66ayqmI+RtxW/gX0vpGbfU+BiheZzcGSK
         x/2qGnI97p/B4kvKS8mf20dFokSB9dMqxzliWNVM=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Michael Turquette <mturquette@baylibre.com>,
        Taniya Das <tdas@codeaurora.org>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1529763567-13131-2-git-send-email-tdas@codeaurora.org>
Cc:     Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Amit Nischal <anischal@codeaurora.org>,
        linux-arm-msm@vger.kernel.org, linux-soc@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Taniya Das <tdas@codeaurora.org>
References: <1529763567-13131-1-git-send-email-tdas@codeaurora.org>
 <1529763567-13131-2-git-send-email-tdas@codeaurora.org>
Message-ID: <153109377967.143105.13957823345139041590@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v3 1/3] clk: qcom: Move frequency table macro to common file
Date:   Sun, 08 Jul 2018 16:49:39 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Taniya Das (2018-06-23 07:19:25)
> Frequency table macro is used by multiple clock drivers, move frequency
> table macro to common header file.
> =

> Signed-off-by: Taniya Das <tdas@codeaurora.org>
> ---

Applied to clk-next

