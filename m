Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757133AbeDZW4n (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:56:43 -0400
Received: from mail-it0-f49.google.com ([209.85.214.49]:32798 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754231AbeDZW4l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:56:41 -0400
X-Google-Smtp-Source: AB8JxZoYSaq4pWVaCnO/ztbCMSQqkFjwOV6tce2uU/I1b56hwzNx2knrOZZXiypg/9pLPKyOAGJH3+p8T3ckMxtqguM=
MIME-Version: 1.0
In-Reply-To: <00c65eb82280318e6d50f0c54fab4efd708beafa.1524000042.git.vilhelm.gray@gmail.com>
References: <cover.1524000042.git.vilhelm.gray@gmail.com> <00c65eb82280318e6d50f0c54fab4efd708beafa.1524000042.git.vilhelm.gray@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 27 Apr 2018 00:56:40 +0200
Message-ID: <CACRpkdb-K1M4MEx8oj9jkkQt27JxkEn=BLB-NAy-HH2XCUyETA@mail.gmail.com>
Subject: Re: [PATCH 2/2] gpio: pcie-idio-24: Fix port memory offset for
 get_multiple/set_multiple callbacks
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 2:53 PM, William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:

> The ioread8/iowrite8 functions expect a memory offset argument. This
> patch fixes the ports array to provide the memory addresses of the
> respective device I/O registers.
>
> Fixes: ca37081595a2 ("gpio: pcie-idio-24: Implement get_multiple/set_multiple callbacks")
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Patch applied for fixes.

Yours,
Linus Walleij
