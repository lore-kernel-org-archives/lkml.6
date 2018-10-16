Return-Path: <SRS0=e/xi=M4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0FC9C5ACCD
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:29:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 650B121470
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Oct 2018 22:29:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZRbVO449"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 650B121470
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbeJQGVl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 02:21:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:39258 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727088AbeJQGVl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 02:21:41 -0400
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 97F2321470;
        Tue, 16 Oct 2018 22:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1539728950;
        bh=6r2/D0/w8UbMIHJR+ug7DqShJjc6KDGfBJA6lfPq/10=;
        h=To:From:In-Reply-To:Cc:References:Subject:Date:From;
        b=ZRbVO449klmYC5wuGjslDsV0uszqs+w7lx4nQ4d0415mZDY9WTRqbzqJEJ6EqepmU
         F5IEbyEfvPIJTv8fo1F1oajRECeWQVf6YyR16LxfHOR6oRLMYRGeHdntiMIAyqnN0I
         JF0RqK3Aj6JbzOR221nNZA3E1dQmu1jnwafhkMdc=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Dmitry Osipenko <digetx@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Peter De Schrijver <pdeschrijver@nvidia.com>,
        Prashant Gaikwad <pgaikwad@nvidia.com>,
        Thierry Reding <thierry.reding@gmail.com>
From:   Stephen Boyd <sboyd@kernel.org>
In-Reply-To: <20180830192045.11017-1-digetx@gmail.com>
Cc:     linux-clk@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20180830192045.11017-1-digetx@gmail.com>
Message-ID: <153972894990.5275.3681567642363374941@swboyd.mtv.corp.google.com>
User-Agent: alot/0.7
Subject: Re: [PATCH v1 0/3] CPU clock changes for Tegra20/30
Date:   Tue, 16 Oct 2018 15:29:09 -0700
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Dmitry Osipenko (2018-08-30 12:20:42)
> Hello,
> =

> This series is a prerequisite for the CPUFREQ driver patches, it can be
> applied separately. CPUFREQ will be supported on Tegra30 once this and
> the CPUFREQ patch-series will be applied.
> =


Will anyone from Nvidia or Tegra review these patches? I'd rather not
apply something that has had zero review.
