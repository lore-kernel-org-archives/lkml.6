Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754361AbeEaJzW (ORCPT <rfc822;w@1wt.eu>);
        Thu, 31 May 2018 05:55:22 -0400
Received: from mail-vk0-f68.google.com ([209.85.213.68]:39284 "EHLO
        mail-vk0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754325AbeEaJzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 May 2018 05:55:20 -0400
X-Google-Smtp-Source: ADUXVKIYA57jyB8XA8LqnuBTeHIAjDvTXa2pHhhMlrmSWGLD8uCr9P9/kZu+wWvFGqyQD6aTaWa01g==
MIME-Version: 1.0
References: <20180515075859.17217-1-stanimir.varbanov@linaro.org>
In-Reply-To: <20180515075859.17217-1-stanimir.varbanov@linaro.org>
From: Tomasz Figa <tfiga@chromium.org>
Date: Thu, 31 May 2018 18:55:06 +0900
X-Gmail-Original-Message-ID: <CAAFQd5C7zB5r3S85vbUWyaUHinMREmk2=2osWpU9AQihYMPhRw@mail.gmail.com>
Message-ID: <CAAFQd5C7zB5r3S85vbUWyaUHinMREmk2=2osWpU9AQihYMPhRw@mail.gmail.com>
Subject: Re: [PATCH v2 00/29] Venus updates
To: Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>, vgarodia@codeaurora.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanimir,

On Tue, May 15, 2018 at 5:14 PM Stanimir Varbanov
<stanimir.varbanov@linaro.org> wrote:
>
> Hello,
>
> Here is v2 with following comments addressed:
>
> * reworked venus suspend 3xx and reuse it for 4xx.
> * drop 10/28 patch from v1, i.e. call of session_continue when
>   buffer requirements are not sufficient.
> * fixed kbuild test robot warning in 11/28 by allocating instance
>   variable from heap.
> * spelling typo in 15/28.
> * added Reviewed-by for DT changes.
> * extended 28/28 HEVC support for encoder, now the profile and
>   level are selected properly.
>
> Comments are welcome!

Thanks a lot for the series. I finally managed to finish reviewing it.
Sorry for taking so long.

For the patches I didn't send any comments for, please feel free to
add my Reviewed-by.

Best regards,
Tomasz
