Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752348AbeENU6Q (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 16:58:16 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:42093 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752280AbeENU6K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 16:58:10 -0400
X-Google-Smtp-Source: AB8JxZoAMN3IFCWQ0CSDvB/G59D2u92JlE9wlQKBzXz2ue0ab7nI1x/G6J/uicLkgotf8ZCtlt3Sgg==
Date: Mon, 14 May 2018 13:51:24 -0700
From: Olof Johansson <olof@lixom.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 3/5] ARM: dts: exynos: Stuff for v4.18
Message-ID: <20180514205124.gwvj2ccokl53a3qx@localhost>
References: <20180513154238.22508-1-krzk@kernel.org>
 <20180513154238.22508-4-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180513154238.22508-4-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 05:42:36PM +0200, Krzysztof Kozlowski wrote:
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-4.18
> 
> for you to fetch changes up to 83cb529b2ef4f3446e60e75522d76fdaaea4724c:
> 
>   ARM: dts: exynos: Update x and y properties for mms114 touchscreen (2018-05-13 15:15:49 +0200)
> 
> ----------------------------------------------------------------
> Samsung DTS ARM changes for v4.18
> 
> 1. Add support for USB OTG port on Origen board.
> 2. Allow earlycon on Rinato board.
> 3. Cleanup from obsolete properties.
> 4. Fix DTC warnings.
> 5. Remove Exynos5440 entirely.
> 6. Add mem-2-mem Scaler devices.

Merged, thanks.


-Olof
