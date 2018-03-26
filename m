Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752548AbeCZQa3 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 12:30:29 -0400
Received: from mail-io0-f182.google.com ([209.85.223.182]:42634 "EHLO
        mail-io0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752507AbeCZQa1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 12:30:27 -0400
X-Google-Smtp-Source: AG47ELsFKX1KGD9SC+NDA1+muSFi7aQsgGvwekX1XIzO7LfmadWCoWs+XsIqSZoOCYSmytz4AcIu008t46eu8Q7AmAw=
MIME-Version: 1.0
In-Reply-To: <20180314153603.3127932-26-arnd@arndb.de>
References: <20180314153603.3127932-1-arnd@arndb.de> <20180314153603.3127932-26-arnd@arndb.de>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Mar 2018 18:30:26 +0200
Message-ID: <CACRpkdYMDbHXTJutsx8=tVQc2=gB95mvoxrW1fYvkVSf_twAbw@mail.gmail.com>
Subject: Re: [PATCH 25/47] pinctrl: remove adi2/blackfin drivers
To: Arnd Bergmann <arnd@arndb.de>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 14, 2018 at 4:35 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> The blackfin architecture is getting removed, so these are
> now obsolete.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
