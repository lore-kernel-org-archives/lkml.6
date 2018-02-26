Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752082AbeBZCz7 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 25 Feb 2018 21:55:59 -0500
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35075 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751958AbeBZCz5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Feb 2018 21:55:57 -0500
X-Google-Smtp-Source: AG47ELsHkGMXfhf+Un8CYk2i89CSWf1QcDCiVCmMUy6gHavvV+L8KK/Qwi+voEAReVbGDI/d6w8tFg==
MIME-Version: 1.0
In-Reply-To: <1519613032-10244-1-git-send-email-yong.deng@magewell.com>
References: <1519613032-10244-1-git-send-email-yong.deng@magewell.com>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 26 Feb 2018 10:55:35 +0800
X-Gmail-Original-Message-ID: <CAGb2v65-Gz8jarHMpKS+S7rNRkknBPF5qV5VCSpeDYQG7woVDw@mail.gmail.com>
Message-ID: <CAGb2v65-Gz8jarHMpKS+S7rNRkknBPF5qV5VCSpeDYQG7woVDw@mail.gmail.com>
Subject: Re: [PATCH] ASoC: sun4i-i2s: Fix RX slot number of SUN8I
To: Yong Deng <yong.deng@magewell.com>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Marcus Cooper <codekipper@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linux-ALSA <alsa-devel@alsa-project.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-sunxi <linux-sunxi@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 26, 2018 at 10:43 AM, Yong Deng <yong.deng@magewell.com> wrote:
> I2S's RX slot number of SUN8I should be shifted 4 bit to left.
>
> Fixes: 7d2993811a1e ("ASoC: sun4i-i2s: Add support for H3")
>
> Signed-off-by: Yong Deng <yong.deng@magewell.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
