Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751141AbeEBLsA (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 07:48:00 -0400
Received: from mail-io0-f171.google.com ([209.85.223.171]:46863 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751133AbeEBLrz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 07:47:55 -0400
X-Google-Smtp-Source: AB8JxZq6ypcOpgkVWHS1PNtay5RDBnFi9/yUjUuUIZPp+Uf0ii3lGQ5cpEgm9ET17trJnJBtMWaqMob6jxBXcgMqYnU=
MIME-Version: 1.0
In-Reply-To: <20180430132259.9938-1-colin.king@canonical.com>
References: <20180430132259.9938-1-colin.king@canonical.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Wed, 2 May 2018 13:47:54 +0200
Message-ID: <CACRpkdZry-jbh=qOP5u+MAWnwqQx5Ek+WDhsNpLq37LQqRXsrw@mail.gmail.com>
Subject: Re: [PATCH][next][V2] pinctrl: actions: fix missing break in
 PIN_CONFIG_DRIVE_STRENGTH case.
To: Colin King <colin.king@canonical.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 30, 2018 at 3:22 PM, Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
>
> There is a missing break in case PIN_CONFIG_DRIVE_STRENGTH leading to
> a fall-through to the PIN_CONFIG_SLEW_RATE case that performs different
> checks against *arg. This looks like an unintentional missing break so
> add in the break.
>
> Detected by CoverityScan, CID#1468456, 1468459 ("Missing break in switch")
>
> Fixes: 513d7a2f7e0f ("pinctrl: actions: Add Actions S900 pinctrl driver")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>

This v2 applied with Manivannan's ACK.

Yours,
Linus Walleij
