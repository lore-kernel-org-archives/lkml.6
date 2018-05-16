Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752560AbeEPLty (ORCPT <rfc822;w@1wt.eu>);
        Wed, 16 May 2018 07:49:54 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55063 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752417AbeEPLtv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 May 2018 07:49:51 -0400
X-Google-Smtp-Source: AB8JxZqcpJJiMxXxtuNhhzrC8RreSC4/QiufdrA0BxVXPKjhATiY0v6YGi7y8RvJ1hqwj7ITly6opYd9hnv3b9gn9vE=
MIME-Version: 1.0
In-Reply-To: <56bf53debf69534a452538e689dc15f94aea31a4.1524933096.git.hns@goldelico.com>
References: <cover.1524933096.git.hns@goldelico.com> <56bf53debf69534a452538e689dc15f94aea31a4.1524933096.git.hns@goldelico.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 16 May 2018 13:49:50 +0200
Message-ID: <CACRpkdYaHkonAQfVKKfh9dG3i7ZuokNkRdUahn6+CKX3S77RVg@mail.gmail.com>
Subject: Re: [PATCH v5 1/7] gpio: pca953x: convert register constants to hex
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

> which makes it easier to match them with the data sheets.
>
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>

Patch applied with Andy's ACK.

Yours,
Linus Walleij
