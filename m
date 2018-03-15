Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932315AbeCOPBB (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:01:01 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:34247 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752244AbeCOPBA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:01:00 -0400
X-Google-Smtp-Source: AG47ELvzYzaa7zYa5DNs+U9Y2TR5GQlrosi7KnQGzF60znBVFJ4lt82akgpTfXGLTPLtTu8s24fAXuvxt+bb++xKFcw=
MIME-Version: 1.0
In-Reply-To: <CAK7LNASQ=JHNng80W-k6oxtpSRHzxHeZgNZvWFcU1vM52U7Wmg@mail.gmail.com>
References: <CAK7LNASQ=JHNng80W-k6oxtpSRHzxHeZgNZvWFcU1vM52U7Wmg@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 15 Mar 2018 16:00:59 +0100
X-Google-Sender-Auth: RZ5wUCojF_Ssx71W3ENlR4Aep5A
Message-ID: <CAK8P3a17ONgh=xq2K5e166hVjm7f9Z0PV9pXp7PSzO1c7vR6nA@mail.gmail.com>
Subject: Re: [GIT PULL] ARM: dts: uniphier: UniPhier DT updates for v4.17
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: arm-soc <arm@kernel.org>, Olof Johansson <olof@lixom.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 3:47 PM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Hi Arnd, Olof,
>
> Please pull UniPhier DT updates for v4.17.
>
> Note:
> In this development cycle, I ended up with putting all of arm/arm64 changes
> into a single pull request.
> This is because some DTSI files are shared across arches.
> So, I needed to do this to avoid build errors.

Ok, no problem. We generally prefer split pull requests, but that is
indeed a good reason to keep a single one.

Pulled into next/dt, thanks!

       Arnd
