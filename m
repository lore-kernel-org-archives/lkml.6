Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753258AbeC1NE7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 09:04:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:49582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753039AbeC1NE5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 09:04:57 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A1521217A8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AIpwx48vwS8kUjX4e937YL058KTkFOR2Cp7Ya5KzY5oHezQA0dX0gfQWtg6I4LfqFZFZuIKYLbYl0rs1ET916UeU9N4=
MIME-Version: 1.0
In-Reply-To: <20180328083213.by4sjrk3nx5s4rbk@fm.suse.cz>
References: <20180328083213.by4sjrk3nx5s4rbk@fm.suse.cz>
From: Rob Herring <robh@kernel.org>
Date: Wed, 28 Mar 2018 08:04:34 -0500
X-Gmail-Original-Message-ID: <CABGGiswL9Mw_viewE9v0OFrnvxOZyaYRyMW5GNEP_R0JEiWDhQ@mail.gmail.com>
Message-ID: <CABGGiswL9Mw_viewE9v0OFrnvxOZyaYRyMW5GNEP_R0JEiWDhQ@mail.gmail.com>
Subject: Re: [PATCH] devicetree: Remove dangling symlinks
To: Libor Pechacek <lpechacek@suse.com>, Arnd Bergmann <arnd@arndb.de>
Cc: devicetree@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Olof Johansson <olof@lixom.net>, Heiko Stuebner <heiko@sntech.de>,
        trivial@kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Arnd

On Wed, Mar 28, 2018 at 3:32 AM, Libor Pechacek <lpechacek@suse.com> wrote:
> Support for CRIS and Meta was dropped.
>
> Signed-off-by: Libor Pechacek <lpechacek@suse.com>
> Fixes: bb6fb6dfcc17 ("metag: Remove arch/metag/")
> Fixes: c690eddc2f3b ("CRIS: Drop support for the CRIS port")
> Cc: James Hogan <jhogan@kernel.org>
> Cc: Jesper Nilsson <jesper.nilsson@axis.com>
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Heiko Stuebner <heiko@sntech.de>
> Cc: devicetree@vger.kernel.org
> Cc: trivial@kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  scripts/dtc/include-prefixes/cris  | 1 -
>  scripts/dtc/include-prefixes/metag | 1 -
>  2 files changed, 2 deletions(-)
>  delete mode 120000 scripts/dtc/include-prefixes/cris
>  delete mode 120000 scripts/dtc/include-prefixes/metag

I'm assuming Arnd will take this.

Acked-by: Rob Herring <robh@kernel.org>
