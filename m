Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753884AbeBGM1B (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Feb 2018 07:27:01 -0500
Received: from mail-it0-f54.google.com ([209.85.214.54]:51665 "EHLO
        mail-it0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753735AbeBGM06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Feb 2018 07:26:58 -0500
X-Google-Smtp-Source: AH8x2252uLQoreEcE+1re06Aoin5bAHOb9bPp58fJA0kkBnmXyRf/KaUoZMeIZZ4/mdBEq1Vi39lEXJZQyYEd0Lzs8A=
MIME-Version: 1.0
In-Reply-To: <20180122050411.32460-5-j.neuschaefer@gmx.net>
References: <20180122050411.32460-1-j.neuschaefer@gmx.net> <20180122050411.32460-5-j.neuschaefer@gmx.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 7 Feb 2018 13:26:57 +0100
Message-ID: <CACRpkdYNJhEFJiYbt72StHFD2udCH=6F7M2XYQHrBTKzAVCnxA@mail.gmail.com>
Subject: Re: [PATCH v2 4/6] dt-bindings: gpio: Add binding for Wii GPIO controller
To: =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
        linux-gpio@vger.kernel.org,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w17CR6ot027218

On Mon, Jan 22, 2018 at 6:04 AM, Jonathan Neuschäfer
<j.neuschaefer@gmx.net> wrote:

> The Nintendo Wii game console has a GPIO controller, which is used for
> the optical disk slot LED, buttons, poweroff, etc. This patch adds a
> binding for this GPIO controller.
>
> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>
> v2:

Patch applied for 4.17.

Yours,
Linus Walleij
