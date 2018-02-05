Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753726AbeBETIB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 14:08:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:44788 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753769AbeBETHY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 14:07:24 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99CB7217B5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AH8x226moKuOKpbWQEvx/GfphrAXvtGz08BQjXEEYyv4rXSGhc6Hguwcg9eKFN03t2IEOnTGCA2ZEOmZ/ndVq2JNkOA=
MIME-Version: 1.0
In-Reply-To: <20180205170500.8992-1-s.nawrocki@samsung.com>
References: <CGME20180205170523epcas1p31ebef69e5d5db0a1ef2f1c3b5ac544ae@epcas1p3.samsung.com>
 <20180205170500.8992-1-s.nawrocki@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 5 Feb 2018 20:07:21 +0100
X-Gmail-Original-Message-ID: <CAJKOXPep2iuCcoxZACoH3U=N2=tiXpZa=Ok3D+b8ZzprcTrtrg@mail.gmail.com>
Message-ID: <CAJKOXPep2iuCcoxZACoH3U=N2=tiXpZa=Ok3D+b8ZzprcTrtrg@mail.gmail.com>
Subject: Re: [PATCH] ASoC: samsung: Add the DT binding files entry to MAINTAINERS
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: broonie@kernel.org, lgirdwood@gmail.com, alsa-devel@alsa-project.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, jcsing.lee@samsung.com,
        sbkim73@samsung.com, linux-kernel@vger.kernel.org,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?=
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 6:05 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> This patch adds missing DT binding files to the Samsung ASoC
> drivers entry.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
