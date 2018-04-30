Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751923AbeD3Isz (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 04:48:55 -0400
Received: from mail-it0-f54.google.com ([209.85.214.54]:35474 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750962AbeD3Isx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 04:48:53 -0400
X-Google-Smtp-Source: AB8JxZqhSbid4AkYHtnqx26IdX/7hxUfm9TnV4MxiqWjFC1uGyhqqTlDI+R6041ccqC1WCkrVoMiC4/Fh2P8SJay6+I=
MIME-Version: 1.0
In-Reply-To: <20180420135020.23423-1-vilhelm.gray@gmail.com>
References: <20180420135020.23423-1-vilhelm.gray@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 30 Apr 2018 10:48:52 +0200
Message-ID: <CACRpkdZo6wDP7fcA_x1=4mY2TtespprJ=pkTpLL2QUF7Mcv==w@mail.gmail.com>
Subject: Re: [PATCH] gpio: pcie-idio-24: Fix off-by-one error in get_multiple loop
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 20, 2018 at 3:50 PM, William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:

> The PCIe-IDIO-24 features 8 bits of TTL GPIO which may be configured for
> output or input. This patch fixes an off-by-one error in the loop
> conditional for the get_multiple callback so that the TTL GPIO are
> handled.
>
> Fixes: ca37081595a2 ("gpio: pcie-idio-24: Implement get_multiple/set_multiple callbacks")
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Patch applied for fixes.

Yours,
Linus Walleij
