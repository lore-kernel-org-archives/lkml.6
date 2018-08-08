Return-Path: <SRS0=X6pY=KX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_PASS,T_DKIMWL_WL_HIGH,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47947C4646D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:40:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F055121762
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Aug 2018 13:40:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mc8tcEba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F055121762
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbeHHQAY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Aug 2018 12:00:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:46264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726971AbeHHQAY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Aug 2018 12:00:24 -0400
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 5516E21762;
        Wed,  8 Aug 2018 13:40:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1533735640;
        bh=vKh+VfISD5QW9kMmVJglPzdb+IDYLjW4/BKmowdth8E=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=Mc8tcEbasYDDk++ov+31c0KHge/3plWiTOavgmbSBljbazGkATEyG3bsdHbQszxaE
         l3H01iGIpA3kcRN6fGonxrImnHwOYPOy+UVFz7yGUpIpfv/ytA6j6x+P8lnl4ZiXiE
         1edSLZub/oxoAymJQf9Jj6SJocTgHd5SxJd0onc0=
Received: by mail-wr1-f43.google.com with SMTP id g1-v6so2083594wru.2;
        Wed, 08 Aug 2018 06:40:40 -0700 (PDT)
X-Gm-Message-State: AOUpUlHlH3aF/hsIP4NBMkKdbpP/zSPYuh9Xv7mhRguncRnwXbURVlA0
        IQVPqoP+Y/uzhSrkMsiT7GtKCOx4jD8hbinudz0=
X-Google-Smtp-Source: AA+uWPzDOrpati+6SbwtT+ayLNNAjgYRhQ0yii4ZL7Qo4vNfVkBRPruPGmGQG1N9D5KDqpQ1jZDO+/1VZnFeRZWoq5M=
X-Received: by 2002:adf:9d81:: with SMTP id p1-v6mr2038117wre.12.1533735638862;
 Wed, 08 Aug 2018 06:40:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:adf:9141:0:0:0:0:0 with HTTP; Wed, 8 Aug 2018 06:40:38 -0700 (PDT)
In-Reply-To: <1533154189-23311-1-git-send-email-snawrocki@kernel.org>
References: <1533154189-23311-1-git-send-email-snawrocki@kernel.org>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 8 Aug 2018 15:40:38 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdW3TBCqZkTmoZ+gbtu+nFeS_RR_0Z92NHa0K450iqtgg@mail.gmail.com>
Message-ID: <CAJKOXPdW3TBCqZkTmoZ+gbtu+nFeS_RR_0Z92NHa0K450iqtgg@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Update my e-mail address
To:     Sylwester Nawrocki <snawrocki@kernel.org>
Cc:     broonie@kernel.org, sboyd@kernel.org, mchehab@kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>,
        bzolnierkie@samsung.com,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1 August 2018 at 22:09,  <snawrocki@kernel.org> wrote:
> From: Sylwester Nawrocki <snawrocki@kernel.org>
>
> I won't have access to my s.nawrocki@samsung.com account for some time
> so replace that address with the kernel.org one.
> Also a related entry to the .mailmap file is added.
>
> Signed-off-by: Sylwester Nawrocki <snawrocki@kernel.org>
> ---
>  .mailmap    |  1 +
>  MAINTAINERS | 14 +++++++-------
>  2 files changed, 8 insertions(+), 7 deletions(-)

Sylwester,

It still did not reach linux-next... do you expect someone to pick it up?

Best regards,
Krzysztof
