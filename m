Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031496AbeCAOYR (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 09:24:17 -0500
Received: from mail-io0-f196.google.com ([209.85.223.196]:36204 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031279AbeCAOYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 09:24:15 -0500
X-Google-Smtp-Source: AG47ELvYMIoq9Gr+f72A41XewXiPn4trhMiI6f+N5NmmThx48DNxKqBg5PAEUYR83swg1aZMHNU9dcEzn+UR1GHfSTs=
MIME-Version: 1.0
In-Reply-To: <1519910255-6296-1-git-send-email-harish_kandiga@mentor.com>
References: <1519910255-6296-1-git-send-email-harish_kandiga@mentor.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 1 Mar 2018 15:24:14 +0100
Message-ID: <CACRpkda26vE3vfuX3ioJduuTh8fyWOZgsZ-e1BbQiwAf=3ZuAg@mail.gmail.com>
Subject: Re: [PATCH] mmc: Export host capabilities to debugfs.
To: Harish Jenny K N <harish_kandiga@mentor.com>
Cc: Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Avri Altman <avri.altman@wdc.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 1, 2018 at 2:17 PM, Harish Jenny K N
<harish_kandiga@mentor.com> wrote:

Thanks for your patch!

> This patch exports the host capabilities to debugfs
>
> Signed-off-by: Andrew Gabbasov <andrew_gabbasov@mentor.com>
> Signed-off-by: Harish Jenny K N <harish_kandiga@mentor.com>

Is there a corresponding patch to the mmc utils to make use
of the exported information? An opaque u32 seems pretty hard
to interpret.

Yours,
Linus Walleij
