Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752265AbeEOGJ1 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 02:09:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:37640 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752089AbeEOGJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 02:09:26 -0400
X-Google-Smtp-Source: AB8JxZpaTY0pQxsrVFmPTJgtUKhUVV/9d/7fXuU6g0CXgC/fm/yJR+OHLty0nsZnCUu4kDEYBTWDbqC9lXpZi1/a4zg=
MIME-Version: 1.0
In-Reply-To: <20180514205502.u25kugxkym4tz34e@localhost>
References: <20180513154238.22508-1-krzk@kernel.org> <20180514205502.u25kugxkym4tz34e@localhost>
From: Krzysztof Kozlowski <krzk@kernel.org>
Date: Tue, 15 May 2018 08:09:23 +0200
X-Gmail-Original-Message-ID: <CAJKOXPcA-+uXof-as=5MNbHiMPBSypKmDsefDcLYVH=WhOA0ag@mail.gmail.com>
Message-ID: <CAJKOXPcA-+uXof-as=5MNbHiMPBSypKmDsefDcLYVH=WhOA0ag@mail.gmail.com>
Subject: Re: [GIT PULL 0/5] ARM: samsung/exynos: Stuff for v4.18
To: Olof Johansson <olof@lixom.net>
Cc: Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org,
        "linux-samsung-soc@vger.kernel.org"
        <linux-samsung-soc@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 10:55 PM, Olof Johansson <olof@lixom.net> wrote:
> On Sun, May 13, 2018 at 05:42:33PM +0200, Krzysztof Kozlowski wrote:
>> Hi,
>>
>> Changes for v4.18. No dependencies, no specific order of pulls.
>>
>> Support for Exynos5440 is removed step by step through different trees.
>
> 5440 was always a bit of a weird fit, it clearly was never an exynos5-family
> platform. I take it there are no substantial users left that would need
> mainline kernel support for it?

I forgot to mention this in pull request (it is in the commit) - there
are no known users. There are no real products and development boards
are unpopular (probably only Samsung LSI has it).

> Also, I noticed your PGP key has expired, so you should probably start
> collecting signatures on a fresh subkey.

It should be good, I prolonged it some time ago. Can you refresh it in
your keyring?

Best regards,
Krzysztof
