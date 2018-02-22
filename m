Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932612AbeBVNCs (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 08:02:48 -0500
Received: from mail-it0-f65.google.com ([209.85.214.65]:40742 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932597AbeBVNCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 08:02:44 -0500
X-Google-Smtp-Source: AG47ELsyBF3zxKIJpjONQHV9/tNh/hbKbW2vQFjC4XC04zbiKElJnMa+/SCnB6YfItcljKNS5RRh7SdVinGotnHVDl8=
MIME-Version: 1.0
In-Reply-To: <20180208142437.11217-1-colin.king@canonical.com>
References: <20180208142437.11217-1-colin.king@canonical.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 14:02:43 +0100
Message-ID: <CACRpkdYf58BsULzazia1R7iXicuZjuThh_+sAx5x4=EHZW1zZg@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: ocelot: make function ocelot_pinctrl_probe static
To: Colin King <colin.king@canonical.com>
Cc: linux-gpio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 8, 2018 at 3:24 PM, Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> The function ocelot_pinctrl_probe is local to the source and does not
> need to be in global scope, so make it static.
>
> Cleans up sparse warning:
> drivers/pinctrl/pinctrl-ocelot.c:465:5: warning: symbol
> 'ocelot_pinctrl_probe' was not declared. Should it be static?
>
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

Patch applied.

Yours,
Linus Walleij
