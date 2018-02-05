Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753305AbeBEPRZ (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Feb 2018 10:17:25 -0500
Received: from mail.kernel.org ([198.145.29.99]:55448 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753134AbeBEPRS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Feb 2018 10:17:18 -0500
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F1A4217B2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=krzk@kernel.org
X-Google-Smtp-Source: AH8x225rrYNfCLszRFG14weVy0RNwYsMQ1KJA9i6KKJCHmH3vVU5azDF4KJbIfVWhhXwBeoHR+w7TIgmq+0kdrQ4aQg=
MIME-Version: 1.0
In-Reply-To: <20180205144158.10500-1-s.nawrocki@samsung.com>
References: <CGME20180205144215epcas1p4f7da6d58948bac6f4f313108596a0fb4@epcas1p4.samsung.com>
 <20180205144158.10500-1-s.nawrocki@samsung.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Mon, 5 Feb 2018 16:17:15 +0100
X-Gmail-Original-Message-ID: <CAJKOXPe5ndc6CMG+5Sr6JjLJiF2xztH5rzWm1Xnr77sL8osrmQ@mail.gmail.com>
Message-ID: <CAJKOXPe5ndc6CMG+5Sr6JjLJiF2xztH5rzWm1Xnr77sL8osrmQ@mail.gmail.com>
Subject: Re: [PATCH] clk: samsung: Add git tree entry to MAINTAINERS
To: Sylwester Nawrocki <s.nawrocki@samsung.com>
Cc: linux-clk@vger.kernel.org, sboyd@codeaurora.org,
        mturquette@baylibre.com, linux-samsung-soc@vger.kernel.org,
        Chanwoo Choi <cw00.choi@samsung.com>, linux-kernel@vger.kernel.org,
        Tomasz Figa <tomasz.figa@gmail.com>,
        =?UTF-8?B?QmFydMWCb21pZWogxbtvxYJuaWVya2lld2ljeg==?=
        <b.zolnierkie@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 5, 2018 at 3:41 PM, Sylwester Nawrocki
<s.nawrocki@samsung.com> wrote:
> Add a missing git tree entry for drivers/clk/samsung.
>
> Signed-off-by: Sylwester Nawrocki <s.nawrocki@samsung.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
