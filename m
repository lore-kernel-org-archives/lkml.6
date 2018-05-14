Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752461AbeENU7R (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 16:59:17 -0400
Received: from mail-lf0-f68.google.com ([209.85.215.68]:36828 "EHLO
        mail-lf0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752281AbeENU6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 16:58:15 -0400
X-Google-Smtp-Source: AB8JxZon4k1h7PPv9qCJTFSnSLEw67tVFuxU1zXcK3+zdvaOfmRwr24QnISRLRQLT2GiiYVIz5yK1Q==
Date: Mon, 14 May 2018 13:52:41 -0700
From: Olof Johansson <olof@lixom.net>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, arm@kernel.org,
        Kukjin Kim <kgene@kernel.org>, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL 5/5] ARM: exynos: mach/soc for v4.18
Message-ID: <20180514205241.al6v4ejxwy26j4ue@localhost>
References: <20180513154238.22508-1-krzk@kernel.org>
 <20180513154238.22508-6-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180513154238.22508-6-krzk@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 13, 2018 at 05:42:38PM +0200, Krzysztof Kozlowski wrote:
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-soc-4.18
> 
> for you to fetch changes up to 9ad9a2183bf51da7f8840f2e7087816c0fc8c91d:
> 
>   ARM: exynos: Remove unused soc_is_exynos{4,5} (2018-05-13 14:07:03 +0200)
> 
> ----------------------------------------------------------------
> Samsung mach/soc changes for v4.18
> 
> 1. Remove at24_platform_data in S3C2440.
> 2. Fix invalid SPDX identifier.
> 3. Remove Exynos5440 entirely.
> 4. Cleanups.
> 5. Remove static mapping of SCU SFR and rely on DTS.

Merged, thanks!


-Olof
