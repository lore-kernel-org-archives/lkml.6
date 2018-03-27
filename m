Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752593AbeC0MLV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Mar 2018 08:11:21 -0400
Received: from mail-qt0-f174.google.com ([209.85.216.174]:40210 "EHLO
        mail-qt0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752457AbeC0MLU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Mar 2018 08:11:20 -0400
X-Google-Smtp-Source: AG47ELvTymKLjo+kPb9ws/GBTP9w3QyE8aEAgjtp1q+YNMgiTDhlhtAVwE4YRde5MMzrXPsmtlXuxmxnaP0tgOFx69A=
MIME-Version: 1.0
In-Reply-To: <20180318153415.8229-1-krzk@kernel.org>
References: <20180318153415.8229-1-krzk@kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Date: Tue, 27 Mar 2018 14:11:18 +0200
X-Google-Sender-Auth: LdjI32CQ4saN-rXz_46unTS0AQE
Message-ID: <CAK8P3a06_oYeuNvAQH7KOS8CZW-9XbLpV6vmv0GcqqwcXEE1ZQ@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: dts: exynos: Second pull for v4.17
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Olof Johansson <olof@lixom.net>, arm-soc <arm@kernel.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kukjin Kim <kgene@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES"
        <linux-samsung-soc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 18, 2018 at 4:34 PM, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> Samsung DTS ARM changes for v4.17, part two
>
> 1. Fix audio on Exynos5250 Chromebook Snow.
> 2. Enable HDMI audio Chromebook Snow, Peach Pit and Peach Pi.
> 3. Fix debounce of "OK" key on Midas (Trats2, Galaxy S3) boards.

Pulled into next/dt, thanks!

       Arnd
