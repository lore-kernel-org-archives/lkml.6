Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754368AbeEUVx0 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 21 May 2018 17:53:26 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:43938 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751413AbeEUVxU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 May 2018 17:53:20 -0400
X-Google-Smtp-Source: AB8JxZqOmYYUKE+6JgFHMbThirAnq2j0IbZKt4huwQRTQMiI4ncPG+gUOmnyA7eID7+f7GwWdywJdLcWHPXLn4vFIM4=
MIME-Version: 1.0
In-Reply-To: <1526903890-35761-15-git-send-email-xieyisheng1@huawei.com>
References: <1526903890-35761-1-git-send-email-xieyisheng1@huawei.com> <1526903890-35761-15-git-send-email-xieyisheng1@huawei.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 22 May 2018 00:53:19 +0300
Message-ID: <CAHp75VfjSOFdw+kt=wRheSHwjdSaencSjLDQ3+WKz=pQYaoZPw@mail.gmail.com>
Subject: Re: [PATCH 14/33] clk: use match_string() helper
To: Yisheng Xie <xieyisheng1@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 2:57 PM, Yisheng Xie <xieyisheng1@huawei.com> wrote:
> match_string() returns the index of an array for a matching string,
> which can be used intead of open coded variant.

> +       return match_string(core->parent_names,
> +                           core->num_parents, parent_core->name) >= 0;

More logical split is to leave second parameter on the first line.

P.S. I would rather to put everything to one line even if takes ~83 characters.

-- 
With Best Regards,
Andy Shevchenko
