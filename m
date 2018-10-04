Return-Path: <SRS0=SFDS=MQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E279C64EBC
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:10:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFDDD20652
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Oct 2018 15:10:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DFDDD20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727631AbeJDWES (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Oct 2018 18:04:18 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]:36821 "EHLO
        mail-qt1-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727354AbeJDWES (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Oct 2018 18:04:18 -0400
Received: by mail-qt1-f175.google.com with SMTP id u34-v6so10244572qth.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Oct 2018 08:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zULJSZwvFbZiKsUbKFSCdtIcZosdoZmHrmVGnr+B/jY=;
        b=Hu5IC7snWhVHVyGfT52GqkTzj4NEOQQXSwpjgH6ph/qLlgswO5cBSFVbIaw8ZowXxM
         BS8499qsRwE4n5eJqt2j1iGv9TqFz0BE1rU7oY8bP1rfYgH5v9zRi7F5Ns5QYxyce9/l
         0XV0qydDOGZmbVf+bRj9sVOWco3UOWfEYeq6R9KArzLyKv0nloaCNZIAK2fu53KgiU72
         j3yBnHaOaBgxyot1hTWr9LXB743cklSCSCGlZlUNMYS0bhLXlRB66ezi+xFFsaj9DDaA
         KlpTGtDlmjcSgpeU7b6x/wH1nx8MloC3mb3YZBLXgL7ylYzUmS7AL8FGTtjpEBw/Jzhn
         TaSA==
X-Gm-Message-State: ABuFfojrxPwPrId7j0x3LKPSbSOazb8TgTb93kzP+HlKKcZ/Pr52a3fd
        J2PdvKqq87vawTAek88yMwXKeK/GhD5CrspCvruPAQ==
X-Google-Smtp-Source: ACcGV61d++E8M97cpTEEVzDHYbsP3Vvm1tUMdy0H6qxZOCaH+qTFOjCmrY8IPcI/v7AFi2XiOCfB3rNUoELTacpEI1k=
X-Received: by 2002:a0c:a8cc:: with SMTP id h12-v6mr5839495qvc.161.1538665836025;
 Thu, 04 Oct 2018 08:10:36 -0700 (PDT)
MIME-Version: 1.0
References: <1538525903-22548-1-git-send-email-yamada.masahiro@socionext.com> <1538525903-22548-2-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1538525903-22548-2-git-send-email-yamada.masahiro@socionext.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 4 Oct 2018 17:10:19 +0200
Message-ID: <CAK8P3a0Sx2BcM9NUSxb7He3sVyWm4JJWnp0fiV24_xQP-4CbEQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: defconfig: enable CONFIG_MMC_UNIPHIER
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
        Will Deacon <will.deacon@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 3, 2018 at 2:19 AM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Enable the UniPhier SD controller driver.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

Applied to next/defconfig, thanks!

     Arnd
