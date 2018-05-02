Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751420AbeEBMos (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 08:44:48 -0400
Received: from mail-it0-f67.google.com ([209.85.214.67]:54646 "EHLO
        mail-it0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751121AbeEBMoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 08:44:46 -0400
X-Google-Smtp-Source: AB8JxZo8LvTsHwJma62jFBhCGVjJxfC3Mk/+XmuZ6BPPTow/92+y0HHUNAY1ZzBkXTEfdV0uLIiAbaKdv179FoupVO4=
MIME-Version: 1.0
In-Reply-To: <20180430073819.31827-1-thierry.reding@gmail.com>
References: <20180430073819.31827-1-thierry.reding@gmail.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 May 2018 14:44:45 +0200
Message-ID: <CACRpkda4DCLn40KohpvHFfx49fK7G==xgvH+ESA1-1DH78fwWg@mail.gmail.com>
Subject: Re: [PATCH 01/12] gpio: 74xx-mmio: Use of_device_get_match_data()
To: Thierry Reding <thierry.reding@gmail.com>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 9:38 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:

> From: Thierry Reding <treding@nvidia.com>
>
> Use of_device_get_match_data() instead of open-coding it.
>
> Signed-off-by: Thierry Reding <treding@nvidia.com>

All 12 patches applied!

Thanks for your cleanup efforts, much much appreciated!

Yours,
Linus Walleij
