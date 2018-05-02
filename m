Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751138AbeEBLqW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 07:46:22 -0400
Received: from mail-io0-f173.google.com ([209.85.223.173]:35384 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750897AbeEBLqU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 07:46:20 -0400
X-Google-Smtp-Source: AB8JxZqsTGKnAiKCz6JE73LLgoidjFnkS2NYV1hLMFz+lBbH2eLm5R9qEwYGIQfaGcIGs6k2PZM1TRavhfcwhWHfrjs=
MIME-Version: 1.0
In-Reply-To: <20180430130434.1361-1-colin.king@canonical.com>
References: <20180430130434.1361-1-colin.king@canonical.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 May 2018 13:46:19 +0200
Message-ID: <CACRpkdac_qa6-pZ3+OjrWw-w3O8ihj_yQBM3XJQxtiOUpryFRQ@mail.gmail.com>
Subject: Re: [PATCH][next] pinctrl: actions: make s900_functions, s900_padinfo
 and s900_pads static
To: Colin King <colin.king@canonical.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 3:04 PM, Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> s900_functions, s900_padinfo and s900_pads are local to the source and do
> not need to be in global scope, so make them static.
>
> Cleans up sparse warnings:
> drivers/pinctrl/actions/pinctrl-s900.c:1445:30: warning: symbol
> 's900_functions' was not declared. Should it be static?
> drivers/pinctrl/actions/pinctrl-s900.c:1664:20: warning: symbol
> 's900_padinfo' was not declared. Should it be static?
> drivers/pinctrl/actions/pinctrl-s900.c:207:31: warning: symbol
> 's900_pads' was not declared. Should it be static?
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied with Manivannan's ACK, I got the same patch from
the 0day build robot, but I prefer human contributors to I pick
this one.

Yours,
Linus Walleij
