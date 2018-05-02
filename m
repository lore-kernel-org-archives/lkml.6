Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751372AbeEBLxx (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 07:53:53 -0400
Received: from mail-io0-f172.google.com ([209.85.223.172]:33923 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751020AbeEBLxu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 07:53:50 -0400
X-Google-Smtp-Source: AB8JxZp9ySrHWwMj9pi3GBXS+h+yd4QLVmaUE0fQV0iv1q1Ub/6BBW6Y4weAhj5i7PjqJCmthz/tgqWEyH5hgBBVh0s=
MIME-Version: 1.0
In-Reply-To: <cover.1524933096.git.hns@goldelico.com>
References: <cover.1524933096.git.hns@goldelico.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 May 2018 13:53:49 +0200
Message-ID: <CACRpkdZPqMMUMbMq5BSD2FpqVojvVKukEh4KR-TW4do_G+DLDg@mail.gmail.com>
Subject: Re: [PATCH v5 0/7] pcal6524 extensions and fixes for pca953x driver
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

> V5:
> * fix wrong split up between patches 1/7and 2/7.

v5 is looking really nice, giving reviewers a chance to ACK
etc before applying, but will probably apply it anyways in a
few days.

Nice work on this series!

Yours,
Linus Walleij
