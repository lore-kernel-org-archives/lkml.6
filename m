Return-Path: <SRS0=PZjb=LN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,T_DKIM_INVALID,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386B3C433F4
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:47:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E3EDD20837
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Aug 2018 21:47:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="omPR9MrH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E3EDD20837
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727722AbeHaBvo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Aug 2018 21:51:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:34830 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726674AbeHaBvn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Aug 2018 21:51:43 -0400
Received: from localhost (unknown [104.132.0.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B169420658;
        Thu, 30 Aug 2018 21:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1535665650;
        bh=lTYk6/ELIeLjRfB4cZgN6HaMhYgsCqkHBfs+QlOIo/I=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=omPR9MrHQPJq6gF23H4fRes3h31bYgbaqZ1RPVVsoZsEptOaWJHMmrMDpP1v0VgYs
         Hx1V9Xw1rhyW9MWwSyXexGfLubz5f+os5V2mfjsUuYveD4amRmjxjqnuMA/cNvq2cw
         m7dQAVsUugdcUAcg23TZBZlZICDO81EXkpRYUfwg=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Akshu Agrawal <akshu.agrawal@amd.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1534834341-18345-1-git-send-email-akshu.agrawal@amd.com>
Cc:     djkurtz@chromium.org, akshu.agrawal@amd.com,
        Alexander.Deucher@amd.com,
        Michael Turquette <mturquette@baylibre.com>,
        Akshu Agrawal <Akshu.Agrawal@amd.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "open list:COMMON CLK FRAMEWORK" <linux-clk@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
References: <1534834341-18345-1-git-send-email-akshu.agrawal@amd.com>
Message-ID: <153566565013.129321.15259859159989036416@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH] clk: x86: Set default parent to 48Mhz
Date:   Thu, 30 Aug 2018 14:47:30 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Akshu Agrawal (2018-08-20 23:51:57)
> System clk provided in ST soc can be set to:
> 48Mhz, non-spread
> 25Mhz, spread
> To get accurate rate, we need it to set it at non-spread
> option which is 48Mhz.
> =

> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> ---

Applied to clk-fixes

