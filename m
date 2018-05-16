Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752597AbeEPL4V (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 07:56:21 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:51211 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752154AbeEPL4S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 07:56:18 -0400
X-Google-Smtp-Source: AB8JxZpQ2gY5hgrRXWsAO4Wu/5RMIIdF4l6EMFjJuq07bJK5viQRYJj85gRIvfvSvJLpBJ928OG798UGHNaBdcmecKs=
MIME-Version: 1.0
In-Reply-To: <23c048310088d42c99c3c20a83795c97d1b8f1cc.1524933096.git.hns@goldelico.com>
References: <cover.1524933096.git.hns@goldelico.com> <23c048310088d42c99c3c20a83795c97d1b8f1cc.1524933096.git.hns@goldelico.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 May 2018 13:56:16 +0200
Message-ID: <CACRpkdbmLD2=Ghp=zxrgDuY9GeEqQCsHW8ycO3+mK1Bd8gLHsA@mail.gmail.com>
Subject: Re: [PATCH v5 7/7] DTS: Bindings: pca953x: add example how to use
 interrupt-controller and gpio-controller
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

> It is not completely obvious that these are required and
> how to use them. So we provide a tested example.
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Patch applied.

Yours,
Linus Walleij
