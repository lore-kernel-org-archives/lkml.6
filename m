Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C900C282CA
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:32:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA658222B2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 14:32:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392299AbfBMOcG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 09:32:06 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42550 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392265AbfBMOcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 09:32:05 -0500
Received: by mail-qt1-f195.google.com with SMTP id b8so2716520qtr.9;
        Wed, 13 Feb 2019 06:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yQjmZowm/ZKBxge9W+Z0hhgJKB8GgrmSu4tCCYAjf2o=;
        b=G+ll3lPNdsc7lOi4NDn0Q/7Th9et1Sawna5wv3mxz0RdewlsFCnh1m15Hy8g9+jLVn
         P3acBmmo+I9mnMW8fxOQ19giEVEuLpBGsL8IdB+0tF5z/tMzE3sDYkShLgRSkhjrxVgY
         F5qTQyHPieTK7zYgtrJqFTfhV+15BJ4/sINM82022b/825ia3/PINKEwqGO4zb2s0IoK
         STjSgZmKM0cVu9juovXmHqxJum0R3of4zQ8QROYgPGcBFoin3JrPyrlI8en4nzZi/NFa
         Gg5uw/5p9GkXT6kIUjKeADbJIeo6rqLf6q71arTe9DjviEzSBzkziLeWL7TGPv7FzycH
         lqhg==
X-Gm-Message-State: AHQUAuZjLhbbtOpO1zS7MBCK9VX263i+JPlZBZkWouvUnx7bxwhnZ7OJ
        sD/9tCQ5N+dE8pRtR1/LyAmTh9wqkJvsyH6x8iY=
X-Google-Smtp-Source: AHgI3IbBDEPON02dOFX651H6FLMPKtV3GSRs3pPWsKyjo0nsyKsTGsVP1M9c7PuPbLx6Ic4qJnXnSiMwE1XB+F7pj2w=
X-Received: by 2002:a0c:81ee:: with SMTP id 43mr594004qve.180.1550068324570;
 Wed, 13 Feb 2019 06:32:04 -0800 (PST)
MIME-Version: 1.0
References: <cover.1550060543.git.baolin.wang@linaro.org> <f34970a034946bacda19202e2ce9973ca732c925.1550060544.git.baolin.wang@linaro.org>
In-Reply-To: <f34970a034946bacda19202e2ce9973ca732c925.1550060544.git.baolin.wang@linaro.org>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 13 Feb 2019 15:31:47 +0100
Message-ID: <CAK8P3a38=4JZvqPi8f8Mpup2P70c+_xsM48-b35BVRYWGeHp9w@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] arm64: dts: sprd: Remove wildcard compatible string
To:     Baolin Wang <baolin.wang@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Olof Johansson <olof@lixom.net>,
        Orson Zhai <orsonzhai@gmail.com>,
        Lyra Zhang <zhang.lyra@gmail.com>,
        DTML <devicetree@vger.kernel.org>, arm-soc <arm@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 13, 2019 at 1:34 PM Baolin Wang <baolin.wang@linaro.org> wrote:
>
> Remove wildcard compatible string.
>
> Signed-off-by: Baolin Wang <baolin.wang@linaro.org>


Looks good to me. It does break using the new dtb file on older kernels,
but I suppose this is not a case we care much about yet on your
platform, given that both the dts file sand the drivers in the
kernel are still  work in progress.

I had started the other reply I just sent before I saw this new mail.

    Arnd
