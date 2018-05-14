Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752039AbeENTys (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 15:54:48 -0400
Received: from mail-it0-f50.google.com ([209.85.214.50]:55414 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751927AbeENTyp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 15:54:45 -0400
X-Google-Smtp-Source: AB8JxZpnsktYm1Hi49LWkUqbA1M2RH63Ya+U8OQpvq+BbkU59RRawwzBCGy+iuO7oAzQjOH8Wll5sSuLOehC2dy2pcc=
MIME-Version: 1.0
In-Reply-To: <20180514145330.4857-21-peda@axentia.se>
References: <20180514145330.4857-1-peda@axentia.se> <20180514145330.4857-21-peda@axentia.se>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 14 May 2018 21:54:44 +0200
Message-ID: <CACRpkdbE+wjocxyg0yx7im=220F7Cb2RhRYsXKEFhUnaaDStCg@mail.gmail.com>
Subject: Re: [PATCH 20/21] i2c: stu300: make use of i2c_8bit_addr_from_msg
To: Peter Rosin <peda@axentia.se>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-i2c@vger.kernel.org,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 4:53 PM, Peter Rosin <peda@axentia.se> wrote:

> Because it looks neater.
>
> Also restructure debug output for resends, since that code as a
> result is only handling debug output.
>
> Signed-off-by: Peter Rosin <peda@axentia.se>

Looks good to me!
Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
