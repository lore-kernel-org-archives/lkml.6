Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935864AbeEXIKu (ORCPT <rfc822;w@1wt.eu>);
        Thu, 24 May 2018 04:10:50 -0400
Received: from mail-io0-f196.google.com ([209.85.223.196]:34202 "EHLO
        mail-io0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935346AbeEXIKp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 May 2018 04:10:45 -0400
X-Google-Smtp-Source: AB8JxZo+2QTye5RrIXeleBimSSjOCCWYwib0bIHwSK7wlj513WZ1Ibm17kcxGWCpoOENg/an+eADrzAESnhKvsSuIy8=
MIME-Version: 1.0
In-Reply-To: <1526958340-25883-1-git-send-email-Anson.Huang@nxp.com>
References: <1526958340-25883-1-git-send-email-Anson.Huang@nxp.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 24 May 2018 10:10:44 +0200
Message-ID: <CACRpkdZvS39t4s5uaBSB6bA2srQa5QmMRdfzTfyiwOJRn7FOAA@mail.gmail.com>
Subject: Re: [PATCH V3] gpio: mxc: add clock operation
To: Anson Huang <Anson.Huang@nxp.com>
Cc: "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        NXP Linux Team <Linux-imx@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 22, 2018 at 5:05 AM, Anson Huang <Anson.Huang@nxp.com> wrote:

> Some i.MX SoCs have GPIO clock gates in CCM CCGR, such as
> i.MX6SLL, need to enable clocks before accessing GPIO
> registers, add optional clock operation for GPIO driver.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
> changes since V2:

Patch applied with Fabio's review tag and using some
fuzzing, check the result in my git when you have time!

Yours,
Linus Walleij
