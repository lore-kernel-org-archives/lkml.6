Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752220AbeCJLut (ORCPT <rfc822;w@1wt.eu>);
        Sat, 10 Mar 2018 06:50:49 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:36704 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752170AbeCJLur (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Mar 2018 06:50:47 -0500
X-Google-Smtp-Source: AG47ELthCQiRMkAchHEQbjseRzxW2uPAfTNNWzXDC8TH/pr7CfuLwDEP2r8cCVen65jbYo6iF4tIbuJtrok7YGIPweM=
MIME-Version: 1.0
In-Reply-To: <20180308234024.24145-1-j.neuschaefer@gmx.net>
References: <20180308234024.24145-1-j.neuschaefer@gmx.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Sat, 10 Mar 2018 12:50:46 +0100
Message-ID: <CACRpkda=5i-j=W8+yosF9WiZRKFF=iRC-djja7MJE+k6b1xtaQ@mail.gmail.com>
Subject: Re: [PATCH 0/8] Move most GPIO documentation to driver-api/gpio/ and ReST
To: =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2ABp3kv022574

On Fri, Mar 9, 2018 at 12:40 AM, Jonathan Neuschäfer
<j.neuschaefer@gmx.net> wrote:

> The aim of this patchset is to move the GPIO subsystem's documentation
> under Documentation/driver-api/gpio/ such that it is picked up by Sphinx
> and compiled into HTML.

Awesome!

> I moved everything except for sysfs.txt, because
> this file describes the legacy sysfs ABI, and doesn't seem to serve much
> (non-historical) purpose anymore.
>
> There are still some rough edges:
>
> * I think the API documentation (kernel-doc) should be moved out of
>   index.rst into more appropriate files.
> * The headings are arguably wrong, because driver.rst, consumer.rst,
>   etc. use the "document title" style, even though they are part of the
>   GPIO chapter. But the resulting TOC tree is consistent, and I did not
>   want to change almost all headings.
> * Some of the files could use more :c:func:`...` references and general
>   ReST polish.
>
> But I don't want to make this patchset too large.

It's fine, we take it one step at a time.

On Fri, Mar 09, 2018 at 10:41:20AM -0700, Jonathan Corbet wrote:

> Anyway, I'm happy to take these through the docs tree or see them go via
> GPIO; Linus, what's your preference?

I might have some doc patches that could collide so I can take them.

I take it there will be a v2?

Yours,
Linus Walleij
