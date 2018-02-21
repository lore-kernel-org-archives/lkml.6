Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966232AbeBUQE3 (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 11:04:29 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:37894 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938437AbeBUQE0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 11:04:26 -0500
X-Google-Smtp-Source: AH8x225euUL9xVjQLNXCm1G+zs549LCDRpkaClUGBAwDab+g3b57/KD6YC3wb+q1ARsMk2DY+GJqMWLEyO0bo0UVWHk=
MIME-Version: 1.0
In-Reply-To: <20180221140533.lll6vbwg3gyjrlvi@smtp.gmail.com>
References: <20180221140533.lll6vbwg3gyjrlvi@smtp.gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 21 Feb 2018 18:04:24 +0200
Message-ID: <CAEnQRZAhZ=PR+X3=HYRQKkTHUnczWcsv4945piCrwK31PbuXGg@mail.gmail.com>
Subject: Re: [PATCH] iio:dummy: Fix coding style in simple_dummy and evgen
To: Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Daniel Baluta <daniel.baluta@nxp.com>, linux-iio@vger.kernel.org,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 4:05 PM, Rodrigo Siqueira
<rodrigosiqueiramelo@gmail.com> wrote:
> This patch fixes the following checkpatch.pl warnings:
>
> drivers/iio/dummy/iio_simple_dummy.c:603: WARNING: Block comments should
> align the * on each line
> drivers/iio/dummy/iio_dummy_evgen.c:151: WARNING: Symbolic permissions
> 'S_IWUSR' are not preferred. Consider using octal permissions '0200'...
> drivers/iio/dummy/iio_simple_dummy.c:693: CHECK: Please use a blank line
> after function/struct/union/enum declarations

You are trying to fix 3 things in one patch here. Please don't do that.

One patch per change please.

thanks,
Daniel.
