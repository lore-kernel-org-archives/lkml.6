Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932583AbeE3VtO (ORCPT <rfc822;w@1wt.eu>);
        Wed, 30 May 2018 17:49:14 -0400
Received: from mail-ua0-f194.google.com ([209.85.217.194]:37765 "EHLO
        mail-ua0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932313AbeE3VtL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 May 2018 17:49:11 -0400
X-Google-Smtp-Source: ADUXVKJH2nsvaOTbwBMoEE+Pp6xh+msBdoW02z+Wprj1i3BDhKtozI6OojLSIyDDtxqtQGSsAcDbm6Ljd0xE2Jlmj2M=
MIME-Version: 1.0
In-Reply-To: <1527158731-17685-2-git-send-email-rplsssn@codeaurora.org>
References: <1527158731-17685-1-git-send-email-rplsssn@codeaurora.org> <1527158731-17685-2-git-send-email-rplsssn@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 30 May 2018 14:49:09 -0700
X-Google-Sender-Auth: rGntjKgFvlgbvMgavVw9J6pk1Kc
Message-ID: <CAD=FV=VG-wDqone04dFZHVPUgxvdPQED0eeT90ZobKqtVKJ-hQ@mail.gmail.com>
Subject: Re: [PATCH v9 01/10] drivers: qcom: rpmh-rsc: add RPMH controller for
 QCOM SoCs
To: Raju P L S S S N <rplsssn@codeaurora.org>
Cc: Andy Gross <andy.gross@linaro.org>,
        David Brown <david.brown@linaro.org>, linux-arm-msm@vger.kernel.org,
        "open list:ARM/QUALCOMM SUPPORT" <linux-soc@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Evan Green <evgreen@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>, Lina Iyer <ilina@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 24, 2018 at 3:45 AM, Raju P L S S S N
<rplsssn@codeaurora.org> wrote:
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> new file mode 100644
> index 0000000..99b23b7
> --- /dev/null
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -0,0 +1,482 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2016-2018, The Linux Foundation. All rights reserved.
> + */
> +
> +#define pr_fmt(fmt) "%s " fmt, KBUILD_MODNAME
> +
> +#include <linux/atomic.h>
> +#include <linux/delay.h>
> +#include <linux/export.h>

Now that you're not exporting any symbols in here, presumably you no
longer need "export.h" right?

-Doug
