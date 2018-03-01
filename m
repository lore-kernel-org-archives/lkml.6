Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161837AbeCAU70 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 15:59:26 -0500
Received: from mail-it0-f44.google.com ([209.85.214.44]:33165 "EHLO
        mail-it0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1161722AbeCAU7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 15:59:24 -0500
X-Google-Smtp-Source: AG47ELtVqjcxMTB+7dswJq4bpVTWoy9n6rax5qiPYFO5XW1azNRzDAoWsILvwyHvSILBSqeVJDLCWG+4sitKGwzWakI=
MIME-Version: 1.0
In-Reply-To: <20180222152247.10554-2-niklas.cassel@axis.com>
References: <20180222152247.10554-1-niklas.cassel@axis.com> <20180222152247.10554-2-niklas.cassel@axis.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 1 Mar 2018 21:59:22 +0100
Message-ID: <CACRpkdY4YpSAL5UZQQgXonqzCy4x1wazhzFN6X5Eop_dsrL-Ow@mail.gmail.com>
Subject: Re: [PATCH 2/2] dt-bindings: pinctrl: artpec6: add smaller groups for uarts
To: Niklas Cassel <niklas.cassel@axis.com>
Cc: Jesper Nilsson <jespern@axis.com>, Lars Persson <larper@axis.com>,
        Niklas Cassel <niklass@axis.com>, Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-arm-kernel@axis.com,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 4:22 PM, Niklas Cassel <niklas.cassel@axis.com> wrote:

> Add group configuration for uarts that are cut down
> variants, the standard being full, i.e. all signals,
> flow control, i.e. rx/tx and cts/rts, and rx/tx only.
>
> This allows us to be more precise in which pins we're
> actually using.
>
> Unfortunately the existing naming scheme leaves things
> to be desired, e.g. uart3grp0 means RX/TX and CTS/RTS,
> yet uart0grp0 means all pins.
> Since the exising suffixes have different meaning for
> different uarts, and the fact that we cannot change
> the name of existing groups, makes it hard to use a
> descriptive name for the newly added groups.
>
> Signed-off-by: Niklas Cassel <niklas.cassel@axis.com>

Patch applied.

Yours,
Linus Walleij
