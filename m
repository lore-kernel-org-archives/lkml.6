Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755061AbeEYDbX (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 23:31:23 -0400
Received: from mail-ot0-f194.google.com ([74.125.82.194]:36613 "EHLO
        mail-ot0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754593AbeEYDbV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 23:31:21 -0400
X-Google-Smtp-Source: ADUXVKL5fyVApqR1hAqLR2GnP0uirf0OQLzBE+2VVHNehfdFUT44HF+nyK1W2h7ifuRQGh6wYXjvhQ==
Date: Thu, 24 May 2018 22:31:14 -0500
From: Andy Gross <andy.gross@linaro.org>
To: arm@kernel.org
Cc: Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Kevin Hilman <khilman@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: [GIT PULL] Qualcomm Driver updates for 4.18
Message-ID: <20180525033114.GA6662@hector.attlocal.net>
References: <1527050261-19887-1-git-send-email-andy.gross@linaro.org>
 <1527050261-19887-2-git-send-email-andy.gross@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527050261-19887-2-git-send-email-andy.gross@linaro.org>
User-Agent: Mutt/1.5.23.1 (2014-03-12)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please refrain from applying this pull request.  The following patch
is going to be removed from the pull request and put into a fixes-for-4.17:

firmware: qcom: scm: Fix crash in qcom_scm_call_atomic1()

I'll send an amended pull request minus this patch.

Regards,

Andy

On Tue, May 22, 2018 at 11:37:40PM -0500, Andy Gross wrote:
> The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> 
>   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/agross/linux.git tags/qcom-drivers-for-4.18
> 
> for you to fetch changes up to f378dab2c576ab1ef30ff26d2a96687a5a855271:
> 
>   soc: qcom: smem: introduce qcom_smem_virt_to_phys() (2018-05-14 14:06:49 -0500)
> 
