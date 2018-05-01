Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755933AbeEAA5E (ORCPT <rfc822;w@1wt.eu>);
        Mon, 30 Apr 2018 20:57:04 -0400
Received: from mail-ot0-f176.google.com ([74.125.82.176]:43784 "EHLO
        mail-ot0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751365AbeEAA5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Apr 2018 20:57:03 -0400
X-Google-Smtp-Source: AB8JxZoHbZ2fkA8/9MKOq5liWkya/suNOMdh28T5CpT1xICClYOLqAQpbr/+DUvLB44LJly7JMetODheu/0Ukxsu/Po=
MIME-Version: 1.0
From: Ulf Magnusson <ulfalizer@gmail.com>
Date: Tue, 1 May 2018 02:57:01 +0200
Message-ID: <CAFkk2KRTnRpi5thUGTM2+LZMyitggdJtiOBO7E0pTn93fz6-SQ@mail.gmail.com>
Subject: [ANNOUNCE] Kconfiglib menuconfig implementation
To: Linux Kbuild mailing list <linux-kbuild@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Kconfiglib (https://github.com/ulfalizer/Kconfiglib) now has a
terminal menuconfig implementation, implemented in plain curses
(which is in the Python standard library).

The interface should feel familiar to people used to mconf. It has
some features that mconf lacks:

  - Seamless resizing

  - Unicode support

  - Runs on Windows (via 'pip install windows-curses', which uses
    PDCurses)

  - Improved information displays:

    * All expressions are split into readable chunks

    * Menus and comments have information displays

  - Relatively easy-to-read and easy-to-tweak code.

    Kconfiglib automatically invalidates symbols as needed, and
    values can never get stale, which helps.

Some upcoming features are mouse support and a search feature that
can jump directly to the definition of a symbol. The jump-to feature
will use a "show-all" mode in case the symbol isn't visible.

See the Kconfiglib GitHub page for screenshots. The menuconfig
implementation is at
https://github.com/ulfalizer/Kconfiglib/blob/master/menuconfig.py.
The docstring at the top has some more information.

Cheers,
Ulf
