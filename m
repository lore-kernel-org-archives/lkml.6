Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751608AbeEPEbH (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 00:31:07 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:32785 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750775AbeEPEbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 00:31:05 -0400
X-Google-Smtp-Source: AB8JxZrUxiTG83DjZFSVAWXCA5aFhFfU2Q8vkl+hhpZ9Z+dTjHx2sHLpWCtrh7t4MT6DiVEKLHG3un2f1JBkkt9Ov2E=
MIME-Version: 1.0
In-Reply-To: <1525601658-31989-1-git-send-email-alim.akhtar@samsung.com>
References: <CGME20180506102636epcas2p3432b71e5c867f6cfec16cf2a8c74b0e2@epcas2p3.samsung.com>
 <1525601658-31989-1-git-send-email-alim.akhtar@samsung.com>
From: Alim Akhtar <alim.akhtar@gmail.com>
Date: Wed, 16 May 2018 10:00:23 +0530
Message-ID: <CAGOxZ52VVFcXkO+y842js3WiRA7U2TLi8tZ_kz=71Q4V5t480A@mail.gmail.com>
Subject: Re: [PATCH 0/4] Add required changes to ufshcd to support exynos ufs hci
To: Alim Akhtar <alim.akhtar@samsung.com>
Cc: linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        jejb@linux.vnet.ibm.com, martin.petersen@oracle.com,
        vivek.gautam@codeaurora.org, subhashj@codeaurora.org,
        vinayak holikatti <vinholikatti@gmail.com>,
        Olof Johansson <olof@lixom.net>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

Any thought on this patch set?


On Sun, May 6, 2018 at 3:44 PM, Alim Akhtar <alim.akhtar@samsung.com> wrote:
> Hi All
>
> These patches are part of a larger patch series [1] which attempts upstreaming
> EXYNOS UFS driver support. There was not much activities after v5 of that
> series. In between I saw there were other teams in Samsung tried upstreaming
> the same, but that has not really gone anywhere.
> I have taken this task again and here is another attempt to upstream exynos-ufs
> driver support. I have divided the patches into two series, one which adds
> required infra in the ufshcd core needed by exynos-ufs driver and other part
> will have actual exynos-ufs driver. Splitting this has a advantage of less
> reviewing over head.
>
> I am floating these as a new patch set.
>
> [1] https://www.spinics.net/lists/linux-scsi/msg90292.html
>
> These patches are based on mainline v4.17-rc3.
>
> Alim Akhtar (4):
>   scsi: ufs: add quirk to fix mishandling utrlclr/utmrlclr
>   scsi: ufs: add quirk not to allow reset of interrupt aggregation
>   scsi: ufs: add quirk to enable host controller without hce
>   scsi: ufs: make ufshcd_config_pwr_mode of non-static func
>
>  drivers/scsi/ufs/ufshcd.c | 104 ++++++++++++++++++++++++++++++++++++++++++----
>  drivers/scsi/ufs/ufshcd.h |  18 ++++++++
>  2 files changed, 114 insertions(+), 8 deletions(-)
>
> --
> 2.7.4
>



-- 
Regards,
Alim
