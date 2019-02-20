Return-Path: <SRS0=sczE=Q3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14FEEC43381
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:28:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D77F221907
	for <linux-kernel@archiver.kernel.org>; Wed, 20 Feb 2019 12:28:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbfBTM2I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 Feb 2019 07:28:08 -0500
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34585 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726317AbfBTM2H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Feb 2019 07:28:07 -0500
Received: by mail-qt1-f196.google.com with SMTP id w4so26954365qtc.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Feb 2019 04:28:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qpVtmXWnUR6+AzKQ5x7/2Jxa2crHJLHdoYgYHT/Hz/k=;
        b=Pa3Oxz2ER9dEtKvuifSDnL5BSYtYVkE2EVOXtuGdUPzfnWzcdwfJ0Riz0bzNRqoibH
         /Nq4wB5C9PqNupN4vkFFrykHy0YR6sfbwhprs7fyBBTndnvfqPt29OKpT/sNw7Nbj0b9
         liznenDfuKopaU6XijumKlYZo1AZZpylqg0jeclf2YYvnTIDbN3yzy8k2nJ82538wu0d
         1ds99/RTae82l/6NlmW33IJ3q2vbAMoHiEOn84/K5b+XmEMk5ZhyiPbHGtynK6fMbhz9
         J/5cQIUTG8MJyHlH8kKVM+pTP8c/lGQPe1HfIhGIrRy8jqF9yVmJSteCettSgxt5tm4N
         GVsA==
X-Gm-Message-State: AHQUAuZ1Nn8ykRR+voq22vNNRomWLnS9My0KBwcFMcFOI6o9t0hxSykx
        j6wgWPdFE3hPBwbFKMfbUffkG1ycom915FE9jd0=
X-Google-Smtp-Source: AHgI3IYs016lvGTbEhlkEfyu7S9JKmMCX/KgexhWw8eFmTxdMR7VJK63GYBzSVpKga9havmq9Q6/17Tflzj/lvlekcw=
X-Received: by 2002:ac8:33f1:: with SMTP id d46mr26370180qtb.319.1550665686080;
 Wed, 20 Feb 2019 04:28:06 -0800 (PST)
MIME-Version: 1.0
References: <1550648704-11545-1-git-send-email-sugaya.taichi@socionext.com>
 <CAK8P3a0rwi=uDFYiF50e5HkYoDQUA6_VSWDMiAVeTMaRzeE6oQ@mail.gmail.com> <dbe814ed-3cf2-f72e-b7fa-23cf41e9e42b@socionext.com>
In-Reply-To: <dbe814ed-3cf2-f72e-b7fa-23cf41e9e42b@socionext.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 20 Feb 2019 13:27:48 +0100
Message-ID: <CAK8P3a38qgw8LeX=Y_nG53HzjnXjHESekgnJ6jtW_xvd7Zvq-Q@mail.gmail.com>
Subject: Re: [PATCH v3 9/9] ARM: configs: Add Milbeaut M10V defconfig
To:     "Sugaya, Taichi" <sugaya.taichi@socionext.com>
Cc:     Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>, soc@kernel.org,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 20, 2019 at 12:27 PM Sugaya, Taichi
<sugaya.taichi@socionext.com> wrote:
>
> Hi
>
> On 2019/02/20 18:28, Arnd Bergmann wrote:
> > On Wed, Feb 20, 2019 at 8:44 AM Sugaya Taichi
> > <sugaya.taichi@socionext.com> wrote:
> >
> >> diff --git a/arch/arm/configs/milbeaut_m10v_defconfig b/arch/arm/configs/milbeaut_m10v_defconfig
> >> new file mode 100644
> >> index 0000000..a263211
> >> --- /dev/null
> >> +++ b/arch/arm/configs/milbeaut_m10v_defconfig
> >> @@ -0,0 +1,175 @@
> >
> > I no longer see anything here that should be turned off, but you
> > might want to run 'make savedefconfig' and use the output of that,
> > to make it easier to keep it up to date.
> >
>
> I got it, I use the output of 'make savedefconfig'.
> One question, is that OK to add some options on it?
>   -Because "CONFIG_ARCH_MILBEAUT" was not listed.

What I'd do here is to apply all the patches you want to get merged in
the next few releases before running 'savedefconfig' and use the output
of that.

If you already know that you will need the options, including
them now means you don't have to update the defconfig file
as much in the future.

> >> diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
> >> index 5bee34a..6753805 100644
> >> --- a/arch/arm/configs/multi_v7_defconfig
> >> +++ b/arch/arm/configs/multi_v7_defconfig
> >> @@ -54,6 +54,8 @@ CONFIG_SOC_VF610=y
> >>   CONFIG_ARCH_KEYSTONE=y
> >>   CONFIG_ARCH_MEDIATEK=y
> >>   CONFIG_ARCH_MESON=y
> >> +CONFIG_ARCH_MILBEAUT=y
> >> +CONFIG_ARCH_MILBEAUT_M10V=y
> >>   CONFIG_ARCH_MVEBU=y
> >>   CONFIG_MACH_ARMADA_370=y
> >>   CONFIG_MACH_ARMADA_375=y
> >
> > I'm surprised that you don't need to enable any drivers. Does this actually
> > boot on your hardware?
> >
>
> Yes, but not exactly.
> The series has not serial driver, so I add the driver temporarily and
> confirm the boot log through earlycon.
> The timer driver is selected by "CONFIG_ARCH_MILBEAUT_M10V", no need to
> add the the"CONFIG_MILBEAUT_TIMER".
>
> Here one more question.
> Is this OK to submit a core support patch without any serial drivers?

Yes, we are fairly flexible here. Greg also mentioned in the past that he's
fine with having us merge the serial driver through the arm-soc tree after
it has been reviewed, to keep it together with the platform support, same
thing for the clk, pinctrl, clocksource and irqchip drivers.

However, once the platform support is merged, we prefer that you do
any other driver changes (including newly added drivers) through the
subsystem trees.

      Arnd
