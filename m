Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752749AbeCOPJ5 (ORCPT <rfc822;w@1wt.eu>);
        Thu, 15 Mar 2018 11:09:57 -0400
Received: from mail-it0-f66.google.com ([209.85.214.66]:38291 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751502AbeCOPJ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Mar 2018 11:09:56 -0400
X-Google-Smtp-Source: AG47ELvXp9PQB2LAJIIWr0N9L7GPrx4ZpFe8bcnPmHSfwiBZKXUPABfkRit1Sr6qjGrB6z/244fbbJCQxtLloAp0pLY=
MIME-Version: 1.0
In-Reply-To: <1521016544-16562-1-git-send-email-narmstrong@baylibre.com>
References: <1521016544-16562-1-git-send-email-narmstrong@baylibre.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 15 Mar 2018 16:09:55 +0100
X-Google-Sender-Auth: vn78wqggr91UJL1EWexJgB4kw20
Message-ID: <CAK8P3a2+PdZUHq5sQhwpOiXxPJQDENWBWWTA8y+vYZSO_tsZkQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: configs: add OXNAS v6 defconfig
To: Neil Armstrong <narmstrong@baylibre.com>
Cc: arm-soc <arm@kernel.org>,
        "moderated list:ARM/OXNAS platform support"
        <linux-oxnas@lists.tuxfamily.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 9:35 AM, Neil Armstrong <narmstrong@baylibre.com> wrote:
> This patchs adds the minimal defconfig for the OXNAS ARMv6 SoCs
> including the OX820 SoC and needed minimal configurations.
>
> Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
> ---
>
> Hi Arnds,
>
> Can you take this directly ? It will avoid send a pull request for a single patch..
> This defconfig will help adding the ox820 to a kernelci lab for testing.

Sure, no problem. Applied to next/soc now.

       Arnd
