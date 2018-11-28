Return-Path: <SRS0=rk9P=OH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14A3FC43610
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF4BC20989
	for <linux-kernel@archiver.kernel.org>; Wed, 28 Nov 2018 22:08:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="pHS1033b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF4BC20989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbeK2JLq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 29 Nov 2018 04:11:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:55896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726614AbeK2JLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Nov 2018 04:11:46 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2D47A208E7;
        Wed, 28 Nov 2018 22:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1543442920;
        bh=cRRSH4E9ln7VIaHKxCb2TMXHigJoHecFR7+Oy3ciWmo=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=pHS1033bAA49X1e7KFoT8tVniTJVd8QnE+OZZ+esfBrKRzLnA0SIlwt/WWbpIuRcv
         4Qo6XBTl2RZG/By8i6dyppRKxlmtLWgxtEdOOXHtN0eZCtKQrobT2gLmRCnp9BjJXg
         OJr3+9v1LPQMzOM08h/gDf4Fq+EpvIY5bnKbCqLY=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Yangtao Li <tiny.windzz@gmail.com>, jonathanh@nvidia.com,
        mturquette@baylibre.com, pdeschrijver@nvidia.com,
        pgaikwad@nvidia.com, thierry.reding@gmail.com
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20181123150104.27336-1-tiny.windzz@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Yangtao Li <tiny.windzz@gmail.com>
References: <20181123150104.27336-1-tiny.windzz@gmail.com>
Message-ID: <154344291962.88331.4622895798810822939@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: tegra: Change to use DEFINE_SHOW_ATTRIBUTE macro
Date:   Wed, 28 Nov 2018 14:08:39 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Yangtao Li (2018-11-23 07:01:04)
> Use macro to simplify the code.
> =

> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---

Applied to clk-next

