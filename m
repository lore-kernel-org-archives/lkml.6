Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752061AbeEQWbg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 17 May 2018 18:31:36 -0400
Received: from mail-ot0-f193.google.com ([74.125.82.193]:37201 "EHLO
        mail-ot0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751231AbeEQWbe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 May 2018 18:31:34 -0400
X-Google-Smtp-Source: AB8JxZqYASXQ4ne+VVxC/oRXsbUtZLQLGRPISBgQBGq0Pict4XemvZbryWWFeW39ybQ2IDkwJvI3aA==
MIME-Version: 1.0
References: <1526492623-20527-1-git-send-email-rishabhb@codeaurora.org> <1526492623-20527-3-git-send-email-rishabhb@codeaurora.org>
In-Reply-To: <1526492623-20527-3-git-send-email-rishabhb@codeaurora.org>
From: Evan Green <evgreen@chromium.org>
Date: Thu, 17 May 2018 15:30:53 -0700
X-Gmail-Original-Message-ID: <CAE=gft77E+nuRuXxnSFt4bttLVaKiRgH=dvwu=Q9cO4Ga9TN8g@mail.gmail.com>
Message-ID: <CAE=gft77E+nuRuXxnSFt4bttLVaKiRgH=dvwu=Q9cO4Ga9TN8g@mail.gmail.com>
Subject: Re: [PATCH v7 2/2] drivers: soc: Add LLCC driver
To: rishabhb@codeaurora.org
Cc: linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm@lists.infradead.org, tsoni@codeaurora.org,
        ckadabi@codeaurora.org, robh@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 16, 2018 at 10:44 AM Rishabh Bhatnagar <rishabhb@codeaurora.org>
wrote:

> LLCC (Last Level Cache Controller) provides additional cache memory
> in the system. LLCC is partitioned into multiple slices and each
> slice gets its own priority, size, ID and other config parameters.
> LLCC driver programs these parameters for each slice. Clients that
> are assigned to use LLCC need to get information such size & ID of the
> slice they get and activate or deactivate the slice as needed. LLCC driver
> provides API for the clients to perform these operations.

> Signed-off-by: Channagoud Kadabi <ckadabi@codeaurora.org>
> Signed-off-by: Rishabh Bhatnagar <rishabhb@codeaurora.org>
> ---
>   drivers/soc/qcom/Kconfig           |  17 ++
>   drivers/soc/qcom/Makefile          |   2 +
>   drivers/soc/qcom/llcc-sdm845.c     | 106 ++++++++++++
>   drivers/soc/qcom/llcc-slice.c      | 337
+++++++++++++++++++++++++++++++++++++
>   include/linux/soc/qcom/llcc-qcom.h | 180 ++++++++++++++++++++
>   5 files changed, 642 insertions(+)
>   create mode 100644 drivers/soc/qcom/llcc-sdm845.c
>   create mode 100644 drivers/soc/qcom/llcc-slice.c
>   create mode 100644 include/linux/soc/qcom/llcc-qcom.h


Thanks Rishabh.

Reviewed-by: Evan Green <evgreen@chromium.org>
