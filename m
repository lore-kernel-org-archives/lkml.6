Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752005AbeCWDXY (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 23:23:24 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:55181 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751902AbeCWDXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 23:23:22 -0400
X-Google-Smtp-Source: AG47ELtA7CdJ1x5rYULMujuOJLXrt/+nbXdwvIZ3c31qd2jc4xRtSZfBIE8iI0YjWATgXjrw7voW3eUZS2lWE5cafRA=
MIME-Version: 1.0
In-Reply-To: <20180308234024.24145-1-j.neuschaefer@gmx.net>
References: <20180308234024.24145-1-j.neuschaefer@gmx.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 23 Mar 2018 04:23:21 +0100
Message-ID: <CACRpkdaCn2OnOW7GsiqeUffw4ajBo+Tw31KUyRcuLWvxx271sA@mail.gmail.com>
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
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2N3NTSx018593

On Fri, Mar 9, 2018 at 12:40 AM, Jonathan Neuschäfer
<j.neuschaefer@gmx.net> wrote:

> Jonathan Neuschäfer (8):
>   MAINTAINERS: GPIO: Add Documentation/driver-api/gpio/
>   Documentation: driver-api: Move gpio.rst to gpio/index.rst
>   Documentation: gpio: Move introduction to driver-api
>   Documentation: gpio: Move driver documentation to driver-api
>   Documentation: gpio: Move legacy documentation to driver-api
>   Documentation: gpio: Move gpiod_* consumer documentation to driver-api
>   Documentation: gpio: Move GPIO mapping documentation to driver-api
>   Documentation: gpio: Move drivers-on-gpio.txt to driver-api

I applied all 8 patches to devel for v4.17.

Yours,
Linus Walleij
