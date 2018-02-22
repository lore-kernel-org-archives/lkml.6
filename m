Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932745AbeBVOSf (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:18:35 -0500
Received: from mail-io0-f175.google.com ([209.85.223.175]:42390 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932638AbeBVOSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:18:32 -0500
X-Google-Smtp-Source: AG47ELsQuk6UKDxI6mbaJTzdmlqLfjtpE0eVsz2Akf6QUwR4TI6Rp5yHOBALO3/234FgjLB+fIsf8a+Tv6pVBvgQxPc=
MIME-Version: 1.0
In-Reply-To: <0da1b5a4-ccd6-98f6-3546-e466b3f10524@users.sourceforge.net>
References: <0da1b5a4-ccd6-98f6-3546-e466b3f10524@users.sourceforge.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 15:18:30 +0100
Message-ID: <CACRpkdaf=PCcTrOasn0DOqB0+kLZ-VY7yuY0isiqApLhdF6ktQ@mail.gmail.com>
Subject: Re: [PATCH] gpio-ml-ioh: Delete an error message for a failed memory
 allocation in ioh_gpio_probe()
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-gpio@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 10, 2018 at 10:30 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 10 Feb 2018 22:27:15 +0100
>
> Omit an extra message for a memory allocation failure in this function.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch applied.

Yours,
Linus Walleij
