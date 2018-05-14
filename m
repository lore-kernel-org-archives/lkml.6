Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752393AbeENU63 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 16:58:29 -0400
Received: from mail-lf0-f41.google.com ([209.85.215.41]:41405 "EHLO
        mail-lf0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752253AbeENU6R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 16:58:17 -0400
X-Google-Smtp-Source: AB8JxZrfVkswIkAL4wzFwQ3+wlJhxkuuTA3KoxPq5/cGH/nik8rLVPSlajHElSAqzFBDenLobmRd1w==
Date: Mon, 14 May 2018 13:55:02 -0700
From: Olof Johansson <olof@lixom.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 0/5] ARM: samsung/exynos: Stuff for v4.18
Message-ID: <20180514205502.u25kugxkym4tz34e@localhost>
References: <20180513154238.22508-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180513154238.22508-1-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 05:42:33PM +0200, Krzysztof Kozlowski wrote:
> Hi,
> 
> Changes for v4.18. No dependencies, no specific order of pulls.
> 
> Support for Exynos5440 is removed step by step through different trees.

5440 was always a bit of a weird fit, it clearly was never an exynos5-family
platform. I take it there are no substantial users left that would need
mainline kernel support for it?

Also, I noticed your PGP key has expired, so you should probably start
collecting signatures on a fresh subkey.


-Olof
