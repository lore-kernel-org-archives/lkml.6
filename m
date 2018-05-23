Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754211AbeEWIIT (ORCPT <rfc822;w@1wt.eu>);
        Wed, 23 May 2018 04:08:19 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:53671 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754082AbeEWIIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 May 2018 04:08:16 -0400
X-Google-Smtp-Source: AB8JxZpc1dy1cpmBfUosxJBREKzTQBmNHe62huYnIIubyfXQgIB0Yfpo51aeiqPTXrBW1sKV1eMe2Sgz+4rC278in6o=
MIME-Version: 1.0
In-Reply-To: <1526615528-9707-1-git-send-email-djw@t-chip.com.cn>
References: <1526614328-6869-1-git-send-email-djw@t-chip.com.cn> <1526615528-9707-1-git-send-email-djw@t-chip.com.cn>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 23 May 2018 10:08:15 +0200
Message-ID: <CACRpkdYsDiTWL8MkWCP55ZnB8xoxcDFDEuuqA=Ov=opi-kyc1w@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] gpio: syscon: allow fetching syscon from parent node
To: djw@t-chip.com.cn
Cc: "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        Wayne Chou <zxf@t-chip.com.cn>, Heiko Stuebner <heiko@sntech.de>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 5:52 AM,  <djw@t-chip.com.cn> wrote:

> From: Heiko Stuebner <heiko@sntech.de>
>
> Syscon nodes can be a simple-mfd and the syscon-users then be declared
> as children of this node. That way the parent-child structure can be
> better represented for devices that are fully embedded in the syscon.
>
> Therefore allow getting the syscon from the parent if neither
> a special compatible nor a gpio,syscon-dev property is defined.
>
> Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> Signed-off-by: Levin Du <djw@t-chip.com.cn>
> ---
>
> Changes in v2: None
> Changes in v1:
> - New: allow fetching syscon from parent node in gpio-syscon driver

Regardless of what happens with the rest of the patches this
looks sane and generally useful, so patch applied!

Yours,
Linus Walleij
