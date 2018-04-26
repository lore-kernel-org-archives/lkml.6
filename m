Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757082AbeDZWzr (ORCPT <rfc822;w@1wt.eu>);
        Thu, 26 Apr 2018 18:55:47 -0400
Received: from mail-it0-f42.google.com ([209.85.214.42]:40659 "EHLO
        mail-it0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754728AbeDZWzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Apr 2018 18:55:45 -0400
X-Google-Smtp-Source: AB8JxZp37bwIpMFDShnIdr7K4WtTXqW50PwqclNe+PZ7OWm0Ce3hVHj2UUDompUC/sQIw4kYYO1vaGyUZjDNvGIuhKk=
MIME-Version: 1.0
In-Reply-To: <8d1e6c1c2b04815928fab78e1e2984b18ae516f4.1524000042.git.vilhelm.gray@gmail.com>
References: <cover.1524000042.git.vilhelm.gray@gmail.com> <8d1e6c1c2b04815928fab78e1e2984b18ae516f4.1524000042.git.vilhelm.gray@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 27 Apr 2018 00:55:44 +0200
Message-ID: <CACRpkdbExtqVRXd2VAhMbBj=VK5V9F-igNyYZuLQkBvGuwsaPQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] gpio: pci-idio-16: Fix port memory offset for
 get_multiple callback
To: William Breathitt Gray <vilhelm.gray@gmail.com>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 18, 2018 at 2:53 PM, William Breathitt Gray
<vilhelm.gray@gmail.com> wrote:

> The ioread8 function expects a memory offset argument. This patch fixes
> the ports array to provide the memory addresses of the respective device
> I/O registers.
>
> Fixes: 810ebfc5efca ("gpio: pci-idio-16: Implement get_multiple callback")
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>

Patch applied for fixes.

Yours,
Linus Walleij
