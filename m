Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752516AbeEPLwV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 07:52:21 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:52364 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbeEPLwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 07:52:19 -0400
X-Google-Smtp-Source: AB8JxZr16wNMcKbCgquxxJ45P+hFp6JmpvID2rEGh2FMyFwxe9gA6TGcuzOsIdA/YQ7FXfEMKVnmjJSkqm2XOkkcVcI=
MIME-Version: 1.0
In-Reply-To: <3cb7c78f496ec9933288b7aac7b4ee9c55d9037d.1524933096.git.hns@goldelico.com>
References: <cover.1524933096.git.hns@goldelico.com> <3cb7c78f496ec9933288b7aac7b4ee9c55d9037d.1524933096.git.hns@goldelico.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 May 2018 13:52:17 +0200
Message-ID: <CACRpkdbyu2v5w=y+xQdnBUgwTyQx9Wbwndaz26DmiOi1kaY-Xw@mail.gmail.com>
Subject: Re: [PATCH v5 3/7] gpio: pca953x: add more register definitions for pcal6524
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Kumar Gala <galak@codeaurora.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Alexandre Courbot <gnurou@gmail.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Discussions about the Letux Kernel
        <letux-kernel@openphoenux.org>,
        kernel@pyra-handheld.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 28, 2018 at 6:31 PM, H. Nikolaus Schaller <hns@goldelico.com> wrote:

> The pcal6524 has another set of registers to fine control
> the interrupt handling.
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Patch applied with Andy's ACK.

Yours,
Linus Walleij
