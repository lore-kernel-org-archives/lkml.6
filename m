Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1031505AbeCAObg (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Mar 2018 09:31:36 -0500
Received: from mail-it0-f51.google.com ([209.85.214.51]:51109 "EHLO
        mail-it0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1031046AbeCAObe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Mar 2018 09:31:34 -0500
X-Google-Smtp-Source: AG47ELvNEAI4tiLcxaYx7MxGW4GxH+4SNonqoZxBViJDUeyU3eQKcNl3t+y9TTX2raqATW1O3tM/px+cabESpNftWYg=
MIME-Version: 1.0
In-Reply-To: <20180221233825.10024-11-jhogan@kernel.org>
References: <20180221233825.10024-1-jhogan@kernel.org> <20180221233825.10024-11-jhogan@kernel.org>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 1 Mar 2018 15:31:32 +0100
Message-ID: <CACRpkdZSf3864GtoTBzxZig_=ceWz4QD0KVjZvRpVjnomdejCA@mail.gmail.com>
Subject: Re: [PATCH 10/13] gpio: Drop TZ1090 drivers
To: James Hogan <jhogan@kernel.org>
Cc: linux-metag@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 22, 2018 at 12:38 AM, James Hogan <jhogan@kernel.org> wrote:

> Now that arch/metag/ has been removed, along with TZ1090 SoC support,
> remove the TZ1090 GPIO drivers. They are of no value without the
> architecture and SoC platform code.
>
> Signed-off-by: James Hogan <jhogan@kernel.org>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: linux-gpio@vger.kernel.org
> Cc: linux-metag@vger.kernel.org

Patch applied.

Yours,
Linus Walleij
