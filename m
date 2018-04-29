Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754480AbeD2Vwd (ORCPT <rfc822;w@1wt.eu>);
        Sun, 29 Apr 2018 17:52:33 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:45823 "EHLO
        mail-ua0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754367AbeD2Vwb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 Apr 2018 17:52:31 -0400
X-Google-Smtp-Source: AB8JxZqeDLlIpbaqQuFwh2+yWTPORrUJjNT1MhpQ/Fwy+jNHHbIoQAYbbB7bSOdG/rUWEznjSRLyHo3LrGkwmsXQehE=
MIME-Version: 1.0
References: <1524741374-13523-1-git-send-email-Vijendar.Mukunda@amd.com> <1524741374-13523-10-git-send-email-Vijendar.Mukunda@amd.com>
In-Reply-To: <1524741374-13523-10-git-send-email-Vijendar.Mukunda@amd.com>
From: Daniel Kurtz <djkurtz@chromium.org>
Date: Sun, 29 Apr 2018 21:52:20 +0000
Message-ID: <CAGS+omDEcX_FdemOsJjmFON9WBYODBRrJZwDKXcQ_ksTJmzkRA@mail.gmail.com>
Subject: Re: [PATCH 10/11] ASoC: AMD: Add const to snd_soc_ops instances
To: Vijendar.Mukunda@amd.com
Cc: Akshu Agrawal <akshu.agrawal@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        perex@perex.cz, tiwai@suse.com, alexander.deucher@amd.com,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        weiyongjun1@huawei.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 26, 2018 at 5:18 AM Vijendar Mukunda <Vijendar.Mukunda@amd.com>
wrote:

> From: Akshu Agrawal <akshu.agrawal@amd.com>

> Marking snd_soc_ops instances const

> Signed-off-by: Akshu Agrawal <akshu.agrawal@amd.com>
> Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>

Reviewed-by: Daniel Kurtz <djkurtz@chromium.org>

> ---
>   sound/soc/amd/acp-da7219-max98357a.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

> diff --git a/sound/soc/amd/acp-da7219-max98357a.c
b/sound/soc/amd/acp-da7219-max98357a.c
> index fa5ad5b..133139d 100644
> --- a/sound/soc/amd/acp-da7219-max98357a.c
> +++ b/sound/soc/amd/acp-da7219-max98357a.c
> @@ -171,17 +171,17 @@ static void cz_dmic_shutdown(struct
snd_pcm_substream *substream)
>          da7219_clk_disable();
>   }

> -static struct snd_soc_ops cz_da7219_cap_ops = {
> +static const struct snd_soc_ops cz_da7219_cap_ops = {
>          .startup = cz_da7219_startup,
>          .shutdown = cz_da7219_shutdown,
>   };

> -static struct snd_soc_ops cz_max_play_ops = {
> +static const struct snd_soc_ops cz_max_play_ops = {
>          .startup = cz_max_startup,
>          .shutdown = cz_max_shutdown,
>   };

> -static struct snd_soc_ops cz_dmic_cap_ops = {
> +static const struct snd_soc_ops cz_dmic_cap_ops = {
>          .startup = cz_dmic_startup,
>          .shutdown = cz_dmic_shutdown,
>   };
> --
> 2.7.4
