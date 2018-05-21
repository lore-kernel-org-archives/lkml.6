Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751074AbeEUTbW (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 15:31:22 -0400
Received: from mail-vk0-f65.google.com ([209.85.213.65]:39518 "EHLO
        mail-vk0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750859AbeEUTbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 15:31:19 -0400
X-Google-Smtp-Source: AB8JxZoQcSLbJDP1OK1/TID+FYtmauyZPNrmefAABnMSFvhU1PBdJ7vXX8asolEvUKLZgimmOhItIXaBo1Vwggh7Kzc=
MIME-Version: 1.0
In-Reply-To: <20180518224750.232742-1-swboyd@chromium.org>
References: <20180518224750.232742-1-swboyd@chromium.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 21 May 2018 12:31:17 -0700
X-Google-Sender-Auth: dNuoTbEHuHdaUBvVupM7ZRs_ug0
Message-ID: <CAD=FV=VkNqrosH+ktqe_TT2MEeYcV36J6+yVpuc=hp0oKJcX=Q@mail.gmail.com>
Subject: Re: [PATCH] soc: qcom: geni: Make version macros simpler
To: Stephen Boyd <swboyd@chromium.org>
Cc: Andy Gross <andy.gross@linaro.org>, linux-arm-msm@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Karthikeyan Ramasubramanian <kramasub@codeaurora.org>,
        Sagar Dharia <sdharia@codeaurora.org>,
        Girish Mahadevan <girishm@codeaurora.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, May 18, 2018 at 3:47 PM, Stephen Boyd <swboyd@chromium.org> wrote:
> This macro doesn't work, because it hides a local variable inside of the
> macro to hold the version and that variable name is called 'ver' and
> 'version' sometimes.
>
> Let's change this to be more explicit. Introduce three macros for the
> major, minor, and step of the version, and require callers to pass the
> version in to get the part of the version out. This way we don't hide
> local variables inside macros and things are less evil overall.
>
> Cc: Karthikeyan Ramasubramanian <kramasub@codeaurora.org>
> Cc: Sagar Dharia <sdharia@codeaurora.org>
> Cc: Girish Mahadevan <girishm@codeaurora.org>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  include/linux/qcom-geni-se.h | 13 ++++---------
>  1 file changed, 4 insertions(+), 9 deletions(-)

FWIW I agree that Stephen's patch makes things more readable.

Reviewed-by: Douglas Anderson <dianders@chromium.org>
