Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752876AbeAaMv7 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 31 Jan 2018 07:51:59 -0500
Received: from mail-qk0-f177.google.com ([209.85.220.177]:38466 "EHLO
        mail-qk0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751881AbeAaMv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Jan 2018 07:51:58 -0500
X-Google-Smtp-Source: AH8x224FZGU2HNIRme2dk0ShHPhSnRoPVIBprrqjOEiPwJgbzNX5m29GMLqLUXU/njrrXFlFTzqwFHMsG0JjATAKxiw=
MIME-Version: 1.0
In-Reply-To: <20180131001425.22510-1-erik@mansson.xyz>
References: <20180131001425.22510-1-erik@mansson.xyz>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 31 Jan 2018 14:51:56 +0200
Message-ID: <CAHp75VeET69uqYLixZ9Ze5EDnaj9e0A=1y9VMv5fMmUxGea4bg@mail.gmail.com>
Subject: Re: [PATCH] drivers: regulator: fan53555: fixed a coding style issue
To: Erik Mansson <erik@mansson.xyz>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 31, 2018 at 2:14 AM, Erik Mansson <erik@mansson.xyz> wrote:
> Fixed a couple of badly formatted comments.

> +       /*
> +        * Cache the sleep voltage setting.
> +        * Might not be the real voltage which is rounded
> +        */

Isn't a right time to add a period at the end of sentence?


-- 
With Best Regards,
Andy Shevchenko
