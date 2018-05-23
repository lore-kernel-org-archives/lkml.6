Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753787AbeEWEEG (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 00:04:06 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:35211 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750725AbeEWEEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 00:04:04 -0400
X-Google-Smtp-Source: AB8JxZpFPYHIOE8Y2aFd1yUID4bxONdpcMtyjOz+ZTUC4ypZrxUqfzG/7IpdHdsa0JW+2/0EspCwcLjz3nMRst4mtkA=
MIME-Version: 1.0
References: <20180522083342.5722-1-colin.king@canonical.com>
In-Reply-To: <20180522083342.5722-1-colin.king@canonical.com>
From: Vaibhav Agarwal <vaibhav.sr@gmail.com>
Date: Wed, 23 May 2018 09:33:51 +0530
Message-ID: <CAAs364-Yp6d=VNiaykvGNgsGFMb20SfjvgALFXnTKAYTLSY6-w@mail.gmail.com>
Subject: Re: [PATCH] staging: greybus: fix spelling mistake: "Inavlid" -> "Invalid"
To: Colin King <colin.king@canonical.com>
Cc: Mark Greer <mgreer@animalcreek.com>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, devel@driverdev.osuosl.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 2:03 PM Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>

> Trivial fix to spelling mistake in dev_err error message

> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>   drivers/staging/greybus/audio_topology.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

> diff --git a/drivers/staging/greybus/audio_topology.c
b/drivers/staging/greybus/audio_topology.c
> index de4b1b2b12f3..15e57f701630 100644
> --- a/drivers/staging/greybus/audio_topology.c
> +++ b/drivers/staging/greybus/audio_topology.c
> @@ -996,7 +996,7 @@ static int gbaudio_tplg_create_widget(struct
gbaudio_module_info *module,

>          ret = gbaudio_validate_kcontrol_count(w);
>          if (ret) {
> -               dev_err(module->dev, "Inavlid kcontrol count=%d for %s\n",
> +               dev_err(module->dev, "Invalid kcontrol count=%d for %s\n",
>                          w->ncontrols, w->name);
>                  return ret;
>          }
> --
> 2.17.0


Acked-by: Vaibhav Agarwal <vaibhav.sr@gmail.com>
