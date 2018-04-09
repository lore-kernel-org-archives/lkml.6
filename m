Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757345AbeDIBb5 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 21:31:57 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:44290 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752838AbeDIBbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 21:31:55 -0400
X-Google-Smtp-Source: AIpwx48od0uw8+rPDXy29g2ZiKBlyY4TrYc+o1chIVE3VEQRvbwM1RM+0NL7WY3wgwpI2IEelwJuCK4hMpEnA2CWtCY=
MIME-Version: 1.0
In-Reply-To: <1523234034-33018-1-git-send-email-nicoleotsuka@gmail.com>
References: <1523234034-33018-1-git-send-email-nicoleotsuka@gmail.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Sun, 8 Apr 2018 22:31:54 -0300
Message-ID: <CAOMZO5D-HNjLyLHft4OiTt806ePJvMbuhKZ4yzO07pD2-w4kqA@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_esai: Add freq check in set_dai_sysclk()
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Takashi Iwai <tiwai@suse.com>, Liam Girdwood <lgirdwood@gmail.com>,
        Fabio Estevam <fabio.estevam@nxp.com>, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 8, 2018 at 9:33 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:
> The freq parameter indicates the physical frequency of an actual
> input clock or a desired frequency of an output clock for HCKT/R.
> It should never be passed 0. This might cause Division-by-zero.
>
> So this patch adds a check to fix it.
>
> Signed-off-by: Nicolin Chen <nicoleotsuka@gmail.com>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
