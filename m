Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754701AbeCGPIu (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:08:50 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:37084 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754570AbeCGPIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:08:49 -0500
X-Google-Smtp-Source: AG47ELumMzHejb34qybavWMffvf/n/GL/TwnhDBcN/GpmPbGmX8OScXA2JIlKxPmtru6aPn1zxrYUruYBdVIjY9EeaY=
MIME-Version: 1.0
In-Reply-To: <1519999487-15474-1-git-send-email-geert+renesas@glider.be>
References: <1519999487-15474-1-git-send-email-geert+renesas@glider.be>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Mar 2018 16:08:48 +0100
X-Google-Sender-Auth: r1_2gnVEdwR30RVMcdwEiq9ALXM
Message-ID: <CAK8P3a3Nc2OPxCqdD9p=UUy_min5y=eRD-yGa1zEKSOHPS2vRg@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: socfpga: PM: Drop useless check for PM_SUSPEND_STANDBY
To: Geert Uytterhoeven <geert+renesas@glider.be>
Cc: Dinh Nguyen <dinguyen@kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 2, 2018 at 3:04 PM, Geert Uytterhoeven
<geert+renesas@glider.be> wrote:
> As SoCFPGA uses the standard suspend_valid_only_mem() for its
> platform_suspend_ops.valid() callback, its platform_suspend_ops.enter()
> callback will never be called with state equal to PM_SUSPEND_STANDBY.
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: Tony Lindgren <tony@atomide.com>
> Acked-by: Dinh Nguyen <dinguyen@kernel.org>

Applied to next/soc, thanks!

       Arnd
