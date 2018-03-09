Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932252AbeCIRlX convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Fri, 9 Mar 2018 12:41:23 -0500
Received: from ms.lwn.net ([45.79.88.28]:50118 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751255AbeCIRlV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Mar 2018 12:41:21 -0500
Date: Fri, 9 Mar 2018 10:41:20 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Jonathan =?UTF-8?B?TmV1c2Now6RmZXI=?= <j.neuschaefer@gmx.net>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH 0/8] Move most GPIO documentation to driver-api/gpio/
 and ReST
Message-ID: <20180309104120.40244f8a@lwn.net>
In-Reply-To: <20180308234024.24145-1-j.neuschaefer@gmx.net>
References: <20180308234024.24145-1-j.neuschaefer@gmx.net>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri,  9 Mar 2018 00:40:16 +0100
Jonathan Neuschäfer <j.neuschaefer@gmx.net> wrote:

> The aim of this patchset is to move the GPIO subsystem's documentation
> under Documentation/driver-api/gpio/ such that it is picked up by Sphinx
> and compiled into HTML. I moved everything except for sysfs.txt, because
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

[For future reference, if you're going to CC me on most of a patch series,
I'd really rather get the whole thing so I don't have to go looking for
it.]

>From a quick look, it seems like a reasonable RST conversion to me.  I do
wonder if sysfs.txt should just be removed, since it documents something
we don't want people to use at this point?  Historical purposes are well
served by the repository history.

I'd say changing the headings is worthwhile if it produces a better
result.  OTOH I'd be wary of adding too much "polish"; we really want to
retain the readability of the plain-text files.

Anyway, I'm happy to take these through the docs tree or see them go via
GPIO; Linus, what's your preference?

Thanks,

jon
