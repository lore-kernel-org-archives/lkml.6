Return-Path: <SRS0=S+WB=KJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C572BC67790
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7777F20882
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Jul 2018 20:43:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="JTQyjou4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7777F20882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731465AbeGYV4u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Jul 2018 17:56:50 -0400
Received: from mail.kernel.org ([198.145.29.99]:48384 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730623AbeGYV4u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jul 2018 17:56:50 -0400
Received: from localhost (unknown [104.132.1.75])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5E44E20671;
        Wed, 25 Jul 2018 20:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1532551408;
        bh=ykW4iKDhsdseMCp0OmX6S+yQ0DTUvaWrEFXereDQeTI=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=JTQyjou4L1jX5w6gmEJB9Nkhubx5biqf7tyXPQN9JmgYyXRlmcjNAjhuj7E9fFchi
         LtX/Ux+bYokMDkon34keKEXqY3aZ+hqNkXvzTv4t0dL9tL7zhheNobW5J6TUbU2N9R
         FQKiBX8B2qvj+FfPhKP8xRXEATBTZLcmRK5jbmp8=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Aapo Vienamo <avienamo@nvidia.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <1531396382-5579-2-git-send-email-avienamo@nvidia.com>
Cc:     Prashant Gaikwad <pgaikwad@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-tegra@vger.kernel.org, Aapo Vienamo <avienamo@nvidia.com>
References: <1531396382-5579-1-git-send-email-avienamo@nvidia.com>
 <1531396382-5579-2-git-send-email-avienamo@nvidia.com>
Message-ID: <153255140774.48062.4242502150376707649@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v6 1/4] clk: tegra: Fix includes required by fence_udelay()
Date:   Wed, 25 Jul 2018 13:43:27 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Aapo Vienamo (2018-07-12 04:52:59)
> Add the missing linux/delay.h include statement for udelay() used by
> fence_udelay() macro.
> =

> Signed-off-by: Aapo Vienamo <avienamo@nvidia.com>
> Acked-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> Acked-by: Jon Hunter <jonathanh@nvidia.com>
> ---

Applied to clk-next

