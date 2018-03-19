Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754928AbeCSCR3 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 22:17:29 -0400
Received: from mail-wm0-f43.google.com ([74.125.82.43]:40279 "EHLO
        mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754383AbeCSCR1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 22:17:27 -0400
X-Google-Smtp-Source: AG47ELtalrNTcbcfScsvOFUjH9YhWsB3k71T+xvqEhrO72u0swc6gCuYiCa8XKQJ3ROLJrVzfhhdmw==
MIME-Version: 1.0
In-Reply-To: <cover.1521413031.git.christophe.jaillet@wanadoo.fr>
References: <cover.1521413031.git.christophe.jaillet@wanadoo.fr>
From: Chen-Yu Tsai <wens@csie.org>
Date: Mon, 19 Mar 2018 10:17:04 +0800
X-Gmail-Original-Message-ID: <CAGb2v67bxV4kseYRnN1kkVBFtLyscEqHNtu970VH-nRWkYfiuQ@mail.gmail.com>
Message-ID: <CAGb2v67bxV4kseYRnN1kkVBFtLyscEqHNtu970VH-nRWkYfiuQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] drm/sun4i: Fix some error handling paths in 'sun4i_hdmi_bind()'
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Maxime Ripard <maxime.ripard@free-electrons.com>,
        David Airlie <airlied@linux.ie>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 19, 2018 at 6:48 AM, Christophe JAILLET
<christophe.jaillet@wanadoo.fr> wrote:
> I've splitted these fixes into 2 patches becasue they do not fixe the same
> commit.
>
> Christophe JAILLET (2):
>   drm/sun4i: hdmi: Fix an error handling path in 'sun4i_hdmi_bind()'
>   drm/sun4i: hdmi: Fix another error handling path in
>     'sun4i_hdmi_bind()'

Reviewed-by: Chen-Yu Tsai <wens@csie.org>

for both patches.
