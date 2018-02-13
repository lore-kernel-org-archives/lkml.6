Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933608AbeBMH1i (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Feb 2018 02:27:38 -0500
Received: from mail.kernel.org ([198.145.29.99]:37876 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933499AbeBMH1g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Feb 2018 02:27:36 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07A6D217C7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AH8x227lAIyKWNj97gZ9dM5XszL49c7Qi3vCCzscqiKKm2w+uDKhQ7SIuktDi26j3oQPaHeR5J/2DdI/muSZ0sxKQUA=
MIME-Version: 1.0
In-Reply-To: <20180212161538.22669-8-s.nawrocki@samsung.com>
References: <CGME20180212161711epcas1p2285c5a778cf12ab00211063b1b4a0fc3@epcas1p2.samsung.com>
 <20180212161538.22669-1-s.nawrocki@samsung.com> <20180212161538.22669-8-s.nawrocki@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 13 Feb 2018 08:27:33 +0100
X-Gmail-Original-Message-ID: <CAJKOXPe8ALV_E=Z0z3=cnNPENot22EQf3DKSLAuGH0QRXogn1w@mail.gmail.com>
Message-ID: <CAJKOXPe8ALV_E=Z0z3=cnNPENot22EQf3DKSLAuGH0QRXogn1w@mail.gmail.com>
Subject: Re: [PATCH v2 7/7] ASoC: samsung: Add missing #sound-dai-cells
 property documentation
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

On Mon, Feb 12, 2018 at 5:15 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> The #sound-dai-cells property might be helpful in selecting primary
> or secondary CPU DAI and it's already present in i2s nodes for some
> exynos SoCs so let's add it to the DT binding documentation.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
> Changes since v1:
>  - the property moved to the "Optional SoC Specific Properties"
>    paragraph.
> ---
>  Documentation/devicetree/bindings/sound/samsung-i2s.txt | 2 ++
>  1 file changed, 2 insertions(+)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
