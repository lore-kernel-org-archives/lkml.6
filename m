Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965884AbeEXJQS (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 05:16:18 -0400
Received: from mail-io0-f195.google.com ([209.85.223.195]:35503 "EHLO
        mail-io0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965784AbeEXJQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 05:16:14 -0400
X-Google-Smtp-Source: AB8JxZr2kVfmZW4+OSNBu5GcXdRtc7RB39oGbi2dwcYNV4l0NieSNuxyqu99JmFo9lQKvleMSR47Da37nktAthPp+/c=
MIME-Version: 1.0
In-Reply-To: <1523531671-27491-1-git-send-email-ulf.hansson@linaro.org>
References: <1523531671-27491-1-git-send-email-ulf.hansson@linaro.org>
From: Ulf Hansson <ulf.hansson@linaro.org>
Date: Thu, 24 May 2018 11:16:13 +0200
Message-ID: <CAPDyKFoZ16vhVvriLjyUSKwfym7HxHwn6Y92Q2ukXu9BG5GykA@mail.gmail.com>
Subject: Re: [PATCH v7 00/26] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
To: Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Lina Iyer <ilina@codeaurora.org>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sudeep, Lorenzo, Mark

On 12 April 2018 at 13:14, Ulf Hansson <ulf.hansson@linaro.org> wrote:
> Changes in v7:
>  - Addressed comments concerning the PSCI changes from Mark Rutland, which moves
>    the psci firmware driver to a new firmware subdir and change to force PSCI PC
>    mode during boot to cope with kexec'ed booted kernels.

Are you guys happy in general with the PSCI specific parts from this
series? It would be nice if you could provide me with acks or
reviewed-by tags for the rest of them in such case.

I intend to re-post a new version very soon.

[...]

Kind regards
Uffe
