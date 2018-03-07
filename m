Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934161AbeCGPwA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 10:52:00 -0500
Received: from mail-qk0-f195.google.com ([209.85.220.195]:43490 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933335AbeCGPvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 10:51:38 -0500
X-Google-Smtp-Source: AG47ELtgZLXzsnPpCyg65iyaCvJyP29oQOpjVsIyFPALnDLelPqb2xUz5iziVQuKf8yBvLNfEsLhch6VyagvzJIPNlc=
MIME-Version: 1.0
In-Reply-To: <CAHUa44HqoQ2yxBzJsQQxb35h=S4suDB7qpoQXwsBhx_OXHyBMw@mail.gmail.com>
References: <CAHUa44HqoQ2yxBzJsQQxb35h=S4suDB7qpoQXwsBhx_OXHyBMw@mail.gmail.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 7 Mar 2018 16:51:36 +0100
X-Google-Sender-Auth: tQkmFZbyRRD9ICDlR1087FpIi6w
Message-ID: <CAK8P3a3aHbXOB+pHRi44D7e=Gc1yX_Dtb_LvYguJhinRa+vG+Q@mail.gmail.com>
Subject: Re: [GIT PULL] tee driver misc for v4.17
To: Jens Wiklander <jens.wiklander@linaro.org>
Cc: arm-soc <arm@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 6, 2018 at 12:22 PM, Jens Wiklander
<jens.wiklander@linaro.org> wrote:
> Small fix and report OP-TEE revision information
>
> * Adds one small fix correct max value of privileged device id allocation,
>   this is only needed if there's more than TEE_NUM_DEVICES / 2 (16) tee
>   drivers registered. One or two is a normal value.
> * Reports OP-TEE revision information (major, minro version and build id
>   if available)

Pulled into next/drivers, thanks!

        Arnd
