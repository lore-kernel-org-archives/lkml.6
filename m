Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751776AbeCZIte (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 04:49:34 -0400
Received: from mail-io0-f175.google.com ([209.85.223.175]:35298 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751196AbeCZIta (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 04:49:30 -0400
X-Google-Smtp-Source: AG47ELt4+2A6QdlVtNYQOUuCiPG75rWe+LNcNDqLmkKYZAEtui4rc0BOs1kz5hD6bAeoSBWOSVnhDv9UxDaqxoSS3qg=
MIME-Version: 1.0
In-Reply-To: <1519077427-30165-1-git-send-email-david@lechnology.com>
References: <1519077427-30165-1-git-send-email-david@lechnology.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Mar 2018 10:49:28 +0200
Message-ID: <CACRpkdYNN9zSVTxMQQd=GhH44FtdR476bQdMagS6Y3it5j1FiA@mail.gmail.com>
Subject: Re: [PATCH v2] pinctrl: pinctrl-single: Fix pcs_request_gpio() when
 bits_per_mux != 0
To: David Lechner <david@lechnology.com>
Cc: Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tony Lindgren <tony@atomide.com>,
        Haojian Zhuang <haojian.zhuang@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 19, 2018 at 10:57 PM, David Lechner <david@lechnology.com> wrote:

> This fixes pcs_request_gpio() in the pinctrl-single driver when
> bits_per_mux != 0. It appears this was overlooked when the multiple
> pins per register feature was added.
>
> Fixes: 4e7e8017a80e ("pinctrl: pinctrl-single: enhance to configure multiple pins of different modules")
> Signed-off-by: David Lechner <david@lechnology.com>

Patch applied for v4.17 with Tony's ACK.

Yours,
Linus Walleij
