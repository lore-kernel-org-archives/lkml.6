Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932928AbeBVO3m (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Feb 2018 09:29:42 -0500
Received: from mail-it0-f48.google.com ([209.85.214.48]:52524 "EHLO
        mail-it0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932607AbeBVO3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Feb 2018 09:29:39 -0500
X-Google-Smtp-Source: AH8x224k8Uczf/uWk6C5rOtFCJKQ/UVqTYiOxDiYjHbT4jbhNizW7hWvOQegD4jG4P6dTtbPA/7vegXc66LyyiiSi3Q=
MIME-Version: 1.0
In-Reply-To: <0ea6dba4-0c52-4c9c-ae7e-d80c2f3d50f3@users.sourceforge.net>
References: <0ea6dba4-0c52-4c9c-ae7e-d80c2f3d50f3@users.sourceforge.net>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 22 Feb 2018 15:29:38 +0100
Message-ID: <CACRpkdbkhyUurc99iVeSbdoVOcC3be5N__bbzGvgSVJQ9hUfWw@mail.gmail.com>
Subject: Re: [PATCH] gpio-intel-mid: Delete an error message for a failed
 memory allocation in intel_gpio_probe()
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-gpio@vger.kernel.org,
        David Cohen <david.a.cohen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 11, 2018 at 10:04 PM, SF Markus Elfring
<elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 11 Feb 2018 21:56:42 +0100
>
> Omit an extra message for a memory allocation failure in this function.
>
> This issue was detected by using the Coccinelle software.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Patch applied.

Yours,
Linus Walleij
