Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932376AbeCKVAy (ORCPT <rfc822;w@1wt.eu>);
        Sun, 11 Mar 2018 17:00:54 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:35813 "EHLO
        mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932232AbeCKVAw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Mar 2018 17:00:52 -0400
X-Google-Smtp-Source: AG47ELsqD06QH7SvE/GBU3k/RuylTxAPh1bndSqlha41opyafHIL1d0RxHej6PPSxTUskQuxE9q5WRf8nTnftKXH5E4=
MIME-Version: 1.0
In-Reply-To: <09cf5537-b2d7-5bf5-0c0b-d0b765e1e75b@infradead.org>
References: <09cf5537-b2d7-5bf5-0c0b-d0b765e1e75b@infradead.org>
From: =?UTF-8?Q?Bj=C3=B8rn_Forsman?= <bjorn.forsman@gmail.com>
Date: Sun, 11 Mar 2018 22:00:51 +0100
Message-ID: <CAEYzJUEr0Wvv9UOV4wBYC6E3bh_0ih5A=ebPaKs06egZAZfPUw@mail.gmail.com>
Subject: Re: [PATCH] kbuild: check for pkg-config on make menu/n/g/xconfig
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kbuild <linux-kbuild@vger.kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from quoted-printable to 8bit by mail.home.local id w2BL0w5M011960

On 11 March 2018 at 21:12, Randy Dunlap <rdunlap@infradead.org> wrote:
> +pkgcfg=`which pkg-config >/dev/null 2>&1`

Please use "command -v" instead of "which". command -v is in POSIX, so
the shell will have it for sure (builtin). which is not a builtin, it
is an external command that may or may not be installed on the system.

Best regards,
Bjørn Forsman
