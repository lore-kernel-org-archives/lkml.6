Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756833AbeDXLKD (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 07:10:03 -0400
Received: from mail-ot0-f178.google.com ([74.125.82.178]:42620 "EHLO
        mail-ot0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756835AbeDXLKB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 07:10:01 -0400
X-Google-Smtp-Source: AIpwx4/mfSNRLHCoGMfdxymBNgoRRs8cPHWqDrsX46rkbTalXXWCkX3CW+wa4XlC3EZG4aaUCP4v4DmejWzClTC/JI4=
MIME-Version: 1.0
In-Reply-To: <20180424103303.rrgv2d33stnll2cx@valkosipuli.retiisi.org.uk>
References: <1522335300-13467-1-git-send-email-manivannan.sadhasivam@linaro.org>
 <1522335300-13467-2-git-send-email-manivannan.sadhasivam@linaro.org>
 <CAMZdPi-VCsct6S4cYCvN_XniFB9=pJqC8hnTdQnvL5H_CU2a8Q@mail.gmail.com> <20180424103303.rrgv2d33stnll2cx@valkosipuli.retiisi.org.uk>
From: Loic Poulain <loic.poulain@linaro.org>
Date: Tue, 24 Apr 2018 13:09:20 +0200
Message-ID: <CAMZdPi_kaMp_gqoKOiRvkB2kmk0hDtLBZP66DvjOXKU_Xnuk6w@mail.gmail.com>
Subject: Re: [RESEND PATCH] media: i2c: ov5640: Add pixel clock support
To: Sakari Ailus <sakari.ailus@iki.fi>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        slongerbeam@gmail.com, mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, Todor Tomov <todor.tomov@linaro.org>,
        Nicolas Dechesne <nicolas.dechesne@linaro.org>,
        dragonboard@lists.96boards.org,
        Daniel Thompson <daniel.thompson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sakari,

>> Any comments on this change?
>
> <URL:https://patchwork.linuxtv.org/project/linux-media/list/?submitter=Maxime+Ripard&state=*&q=ov5640>
>
> There's also another set that adds PIXEL_CLOCK (as well as LINK_FREQ)
> support to the driver, that seems more complete than this patch but
> requires a rebase on Maxime's patches:
>
> <URL:https://patchwork.linuxtv.org/project/linux-media/list/?submitter=7218&state=*&q=ov5640>

Thanks, I've just see this patch series. Indeed, patch will need a
rework/rebase.

Regards,
Loic
