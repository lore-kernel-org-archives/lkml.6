Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AB1C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:59:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D751C222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 07:59:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550044766;
	bh=j6aE3xibwAHXu5zXBZZQ5MIHZuG1ECzmOC/YkcJ3vjY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=RsrEmJDBAlgUNCUvufeQVVcU4p5tybq9CEAnaLi9Il4EG90BSJnQnn86nKbm76Ksg
	 dIJJcZy3dvldxtl36gdbbfLs2MMKsel/hkEeo5sfT3ot/WnZSYEbp9tXCyZFLPO7nf
	 3iSumJ51FcIJGSBRLv06m5mR4JiZHC0x8CPZaHY4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390160AbfBMH7Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 02:59:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:38556 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728101AbfBMH7Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 02:59:25 -0500
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 50D22222C2;
        Wed, 13 Feb 2019 07:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550044764;
        bh=j6aE3xibwAHXu5zXBZZQ5MIHZuG1ECzmOC/YkcJ3vjY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=cfd91XlXqtKixleIqy1UPVpqRJupGlSa78TpJHxh7Itu6pWI2b3aL0uWuvwVvra66
         LDcCI07N9ufYysCqoam12nmpZTaKowRD7nN1eMWPCiiGKMb6AawiZMhMt3VQ3iRl9K
         b9g2j8qQI/yX99JnlAU1nto4YyTg2el6/G+NlHLc=
Received: by mail-lf1-f53.google.com with SMTP id f5so1005936lfc.13;
        Tue, 12 Feb 2019 23:59:24 -0800 (PST)
X-Gm-Message-State: AHQUAubXCsXCXoNe/9+QaQ5b6+Bxmw6iZna0tIFtcr+eJrdvSveykJLq
        AXlVbPEyKqtL8UZauQawHwdhoR7X0jVkX12PrY8=
X-Google-Smtp-Source: AHgI3IbU/vdQjWRAJ6PeqAvB4WxyjJdGHmw6VxsR/uzMUGxVPFx9wfGTlIrohlGfnYYfpl+gR/BMJPA54ht1OIbXkfY=
X-Received: by 2002:a19:f013:: with SMTP id p19mr5026204lfc.154.1550044762500;
 Tue, 12 Feb 2019 23:59:22 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190212180539epcas1p457a5c91f2c2cef0d1b92ff8bf804beee@epcas1p4.samsung.com>
 <20190212180342.32040-1-s.nawrocki@samsung.com> <20190212180342.32040-18-s.nawrocki@samsung.com>
In-Reply-To: <20190212180342.32040-18-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 13 Feb 2019 08:59:11 +0100
X-Gmail-Original-Message-ID: <CAJKOXPeJBXmCWZnitRSHmzjVNqnz-LAgLiAXG_4nES1fa4KcqQ@mail.gmail.com>
Message-ID: <CAJKOXPeJBXmCWZnitRSHmzjVNqnz-LAgLiAXG_4nES1fa4KcqQ@mail.gmail.com>
Subject: Re: [PATCH v2 17/21] ASoC: samsung: i2s: Change indentation in
 SAMSUNG_I2S_FMTS definition
To:     Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc:     broonie@kernel.org, lgirdwood@gmail.com, sbkim73@samsung.com,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?= 
        <b.zolnierkie@samsung.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org,
        "linux-samsung-soc@vger.kernel.org" 
        <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 12 Feb 2019 at 19:05, Sylwester Nawrocki <s.nawrocki@samsung.com> wrote:
>
> Change indentation so this macro definition spans 2 rows and looks
> more consistent with surrounding code.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/i2s.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
