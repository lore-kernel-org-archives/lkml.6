Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751813AbeDDJFo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 05:05:44 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:50422 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751264AbeDDJFm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 05:05:42 -0400
X-Google-Smtp-Source: AIpwx4/+zQ6BmUwPAh1tyqIGg744+aECJiwV36rtuoxodwLTn13QL65+bTKQmU4lwebYpTVZ1ChVUi5UveSZVbtQslI=
MIME-Version: 1.0
In-Reply-To: <1521534986-21907-1-git-send-email-zhang.chunyan@linaro.org>
References: <1521534986-21907-1-git-send-email-zhang.chunyan@linaro.org>
From: Chunyan Zhang <zhang.chunyan@linaro.org>
Date: Wed, 4 Apr 2018 17:05:40 +0800
Message-ID: <CAG2=9p8y9bMsZ8u0gaumW9B7t3GEAhJ6ChQcE8qg_to_T7wwXg@mail.gmail.com>
Subject: Re: [PATCH 0/3] mmc: add support for sdhci 4.0
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>
Cc: linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        Billows Wu <billows.wu@spreadtrum.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ulf,

Do you have some comments on this patch-set?

Thanks,
Chunyan

On 20 March 2018 at 16:36, Chunyan Zhang <zhang.chunyan@linaro.org> wrote:
> From the SD host controller version 4.0 on, SDHCI implementation either
> is version 3 compatible or version 4 mode. This patch-set covers those
> changes which are common for SDHCI 4.0 version, regardless of whether
> they are used with SD or eMMC storage devices.
>
> Chunyan Zhang (3):
>   mmc: sdhci: add sd host v4 mode
>   mmc: sdhci: made changes for System Address register of SDMA
>   mmc: sdhci: add ADMA2 64-bit addressing support for V4 mode
>
>  drivers/mmc/host/sdhci.c | 66 +++++++++++++++++++++++++++++++++++++-----------
>  drivers/mmc/host/sdhci.h | 29 +++++++++++++++++----
>  2 files changed, 75 insertions(+), 20 deletions(-)
>
> --
> 2.7.4
>
