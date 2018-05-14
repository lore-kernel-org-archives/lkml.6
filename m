Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932916AbeENQ7k (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 12:59:40 -0400
Received: from mail-qt0-f176.google.com ([209.85.216.176]:46853 "EHLO
        mail-qt0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932387AbeENQ7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 12:59:38 -0400
X-Google-Smtp-Source: AB8JxZoLcOki7+3MsjMyvoGzh/r+1PYp7KCB1XYt3Iqk3ScZBATQlCO7p+XWp6nsLhixmlr69oxyvG3na3/DFIYJz/U=
MIME-Version: 1.0
In-Reply-To: <20180514145330.4857-4-peda@axentia.se>
References: <20180514145330.4857-1-peda@axentia.se> <20180514145330.4857-4-peda@axentia.se>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Mon, 14 May 2018 19:59:37 +0300
Message-ID: <CAHp75Vcz72q1Oi9hCf1vp32h3GrrYSoR0BR7qacnka9eKB8XAQ@mail.gmail.com>
Subject: Re: [PATCH 03/21] i2c: algo: pcf: make use of i2c_8bit_addr_from_msg
To: Peter Rosin <peda@axentia.se>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Wolfram Sang <wsa+renesas@sang-engineering.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 14, 2018 at 5:53 PM, Peter Rosin <peda@axentia.se> wrote:
> Because it looks neater.

>  drivers/i2c/algos/i2c-algo-pcf.c | 5 +----

I guess for such trivial no functional change patches you may do them
one per folder, and not one-per driver.

-- 
With Best Regards,
Andy Shevchenko
