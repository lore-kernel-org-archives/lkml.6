Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753268AbeBFNB1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 6 Feb 2018 08:01:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:59550 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753118AbeBFM7u (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Feb 2018 07:59:50 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 79B0B208FE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AH8x224HFKFsL72IrgeMsU+43/I1x/Sm7Hw7dlnMtniynBRSXKpcQFV3VawA76nI4P8GB63LeWSjHPaf8rra4Ny5joE=
MIME-Version: 1.0
In-Reply-To: <CAJKOXPcT-C8t-1i0n5JE23udfKfdURRbyvaCbA1KGKxdZ1+Y=A@mail.gmail.com>
References: <CGME20180205154529epcas2p3478546ef61294ac06cd9d8ed3d7e12c9@epcas2p3.samsung.com>
 <20180205154403.13520-1-s.nawrocki@samsung.com> <20180205154403.13520-7-s.nawrocki@samsung.com>
 <CAJKOXPcT-C8t-1i0n5JE23udfKfdURRbyvaCbA1KGKxdZ1+Y=A@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 6 Feb 2018 13:59:47 +0100
X-Gmail-Original-Message-ID: <CAJKOXPcXLwiB_bxQtBp-1PhM7yrA5fGM7t6kZtASXdFCgEHC=g@mail.gmail.com>
Message-ID: <CAJKOXPcXLwiB_bxQtBp-1PhM7yrA5fGM7t6kZtASXdFCgEHC=g@mail.gmail.com>
Subject: Re: [PATCH 6/8] ASoC: samsung: i2s: Update clock-output-names
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

On Tue, Feb 6, 2018 at 1:59 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> On Mon, Feb 5, 2018 at 4:44 PM, Sylwester Nawrocki
> <s.nawrocki@samsung.com> wrote:
>> The clock-output-names property is marked as deprecated. While at it,
>> #clock-cells property's value is corrected in the example snippet
>> and few typos are fixed.
>>
>> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
>> ---
>>  .../devicetree/bindings/sound/samsung-i2s.txt          | 18 +++++++++---------
>>  1 file changed, 9 insertions(+), 9 deletions(-)
>
> As with all bindings, this should go before changing the driver.

Ah, too fast in pressing return. I missed:
Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
