Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753734AbeB0Pom (ORCPT <rfc822;w@1wt.eu>);
        Tue, 27 Feb 2018 10:44:42 -0500
Received: from mail-qk0-f196.google.com ([209.85.220.196]:39054 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753385AbeB0Pok (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Feb 2018 10:44:40 -0500
X-Google-Smtp-Source: AG47ELt1I3ieQdf+Ft63kbBNhocgdXkNPTzzUqwv4LEyvhCnf8zL48Ky8w2UJ2PUeFiQOCl6DmxFSHNj20xdHIxg5M4=
MIME-Version: 1.0
In-Reply-To: <1519726020-24442-1-git-send-email-sebastian@resin.io>
References: <CAHp75VfEc0a_Fff1znWVos3rPzCGsvGLGX7NgH_bH96egree7A@mail.gmail.com>
 <1519726020-24442-1-git-send-email-sebastian@resin.io>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 27 Feb 2018 17:44:38 +0200
Message-ID: <CAHp75Vfdqky9HK9ddUk8+3OuU5pSDhg+9_ychW2ysb+bzAR4Yw@mail.gmail.com>
Subject: Re: [PATCH 1/1] x86: Fix Intel Edison module stuck reboot
To: Sebastian Panceac <sebastian@resin.io>
Cc: x86@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 27, 2018 at 12:07 PM, Sebastian Panceac <sebastian@resin.io> wrote:
> Hi Andy,

Thanks for an update! My comments below.

> I fixed the commit description according to your suggestions and used git send-email.
>
> Regards!

Changelog, which is effectively above paragraph, should go after --- line below.

Version of the patch should be increased (this one is v2 so far).

You should include all maintainers and designated reviewers of the
code in question.
get_maintainer.pl script (in scripts/) will help you.

So, please resend taking into consideration all above.

> When powering Intel Edison module with 3.3V,
> the "reboot" command makes the module stuck.
> If the module is powered at a greater voltage,
> like 4.4V(as the Edison Mini Breakout board does), reboot works OK.

This looks a bit shorter than we have room for. I mean, 72 characters
per line is pretty much OK.

Also, don't miss a space before (.

> This patch copies the behaviour from the official Intel Edison BSP,
> where "IPCMSG_COLD_RESET" message
> was sent to SCU by default at reboot time.
>
> In the official BSP, sending the "IPCMSG_COLD_BOOT" message instead
> of "IPCMSG_COLD_RESET" was possible,
> by using a kernel command line parameter.
>
> Signed-off-by: Sebastian Panceac <sebastian@resin.io>
> ---

...changelog goes here...

>  arch/x86/platform/intel-mid/intel-mid.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)


-- 
With Best Regards,
Andy Shevchenko
