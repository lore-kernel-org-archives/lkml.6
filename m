Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1426149AbeCBKIY (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 05:08:24 -0500
Received: from mail-it0-f66.google.com ([209.85.214.66]:53576 "EHLO
        mail-it0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1426160AbeCBKH2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 05:07:28 -0500
X-Google-Smtp-Source: AG47ELvt1AGG6hG+M/Ixn42zzGRlqbas9g1577xa3Jal5cwZ8bzn6zZgQSEMgZWYvXKVNK1NuP4WkWhNBlmHbJtMBrg=
MIME-Version: 1.0
In-Reply-To: <20180223134352.32612-1-rf@opensource.cirrus.com>
References: <20180223134352.32612-1-rf@opensource.cirrus.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Fri, 2 Mar 2018 11:07:27 +0100
Message-ID: <CACRpkdaxiUGO42Sk9608LwQ=W6-+_z32TdsRThFeK7ZTtHnzYA@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: core: Add missing EXPORT on pinctrl_register_mappings
To: Richard Fitzgerald <rf@opensource.cirrus.com>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        patches@opensource.cirrus.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 2:43 PM, Richard Fitzgerald
<rf@opensource.cirrus.com> wrote:

> Systems that don't have devicetree need pinctrl_register_mappings.
> It should be EXPORT_SYMBOL_GPL so that it can be called from
> pinctrl drivers built as modules.
>
> Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>

Patch applied.

Yours,
Linus Walleij
