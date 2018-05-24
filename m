Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965268AbeEXIMi (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:12:38 -0400
Received: from mail-io0-f193.google.com ([209.85.223.193]:34930 "EHLO
        mail-io0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965203AbeEXIMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:12:33 -0400
X-Google-Smtp-Source: AB8JxZqV401eTPREQ087h3RIUAvqP17aq8Jm0Y8cvGd+TuGEtJMlb4dsRlwF5m83KXHBIGlVx4laTvJT+Yttsp8CwCQ=
MIME-Version: 1.0
In-Reply-To: <1526897190-28714-1-git-send-email-Anson.Huang@nxp.com>
References: <1526897190-28714-1-git-send-email-Anson.Huang@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 24 May 2018 10:12:31 +0200
Message-ID: <CACRpkdbYDqnroi-X7ECdcoeuALEgwB0afZZszap97D_AF725Hg@mail.gmail.com>
Subject: Re: [PATCH] gpio: mxc: add clock operation
To: Anson Huang <Anson.Huang@nxp.com>
Cc: NXP Linux Team <Linux-imx@nxp.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 21, 2018 at 12:06 PM, Anson Huang <Anson.Huang@nxp.com> wrote:

> i.MX6SLL has GPIO clock gates in CCM CCGR, need
> to enable them before accessing registers, add
> optional clock operation for GPIO driver.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>

Some warnings from the build robot, seem like a missing
#include <linux/clk.h> or something.

Yours,
Linus Walleij
