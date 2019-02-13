Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7AF1C282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 760A5222B5
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 08:08:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550045300;
	bh=6S+5mnRis12Y+C1ojZwpznJKbw9tWg7yPEESphAxFFw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=xM1lBOlEijOjqLSdsEDOpkVIbccRZ0lxAYQgV0wm2hq5de5TlX5RWmnV2laRXLj5B
	 6dcV5pEEP5Smo8Yzo5J/EUGVxyuZnJIn6FhtVqBt6OY1T/CjolKETD/HxTjMxrTuDi
	 P2ZBTTKKYomsLSaMdXvRi7TNotR1renRx0xrecek=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390498AbfBMIIT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 03:08:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:47390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731261AbfBMIIS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 03:08:18 -0500
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A52D6222C7;
        Wed, 13 Feb 2019 08:08:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550045298;
        bh=6S+5mnRis12Y+C1ojZwpznJKbw9tWg7yPEESphAxFFw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=X1dOOLefmeDzq+txCHN0pMF+6yw+uY3eA5VNlXPxQO4U7Gv2MbZrQh/kGb4R8KJn3
         yk1NzRMTK06Wz0ZIC/WBRGLphFmSXdOZ6ymofazyusoROGo22224WQzHPOb60RcVX4
         meKXm2rQm27Z5SLlb95aHqQPVGhFW8uHfBJjjmsM=
Received: by mail-lj1-f177.google.com with SMTP id g80so1193543ljg.6;
        Wed, 13 Feb 2019 00:08:17 -0800 (PST)
X-Gm-Message-State: AHQUAuY3OFANO9yHoQmOoWHI2IC/KYC6sEfPR+MRzTcjUpYFeGZLBCYK
        mFPF6liRkhGRyUbN8Vs9V1McwX42YDRWvbcnUto=
X-Google-Smtp-Source: AHgI3IbqZaFsZ34VxqCcOeyMO6dTxels++y0ttUuagjs81yE/wu/uMIepbm3rLeP7TJluPX/E6pFZtlTCiFT/Mpfxts=
X-Received: by 2002:a2e:4a19:: with SMTP id x25-v6mr4214156lja.19.1550045295826;
 Wed, 13 Feb 2019 00:08:15 -0800 (PST)
MIME-Version: 1.0
References: <CGME20190212180546epcas1p1df261edb23d09dd0b33697f4a279cbd0@epcas1p1.samsung.com>
 <20190212180342.32040-1-s.nawrocki@samsung.com> <20190212180342.32040-20-s.nawrocki@samsung.com>
In-Reply-To: <20190212180342.32040-20-s.nawrocki@samsung.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Wed, 13 Feb 2019 09:08:04 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcXmp6uvs9YhxQ6c1CmCxtrwrbeNWzCtA6mybzxSscsUg@mail.gmail.com>
Message-ID: <CAJKOXPcXmp6uvs9YhxQ6c1CmCxtrwrbeNWzCtA6mybzxSscsUg@mail.gmail.com>
Subject: Re: [PATCH v2 19/21] ASoC: samsung: i2s: Convert to SPDX License Indentifier
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
> Replace GPL v2.0 license statements with SPDX license identifier.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  sound/soc/samsung/i2s.c | 16 ++++++----------
>  1 file changed, 6 insertions(+), 10 deletions(-)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
