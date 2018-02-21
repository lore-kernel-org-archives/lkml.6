Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752153AbeBUVBy (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Feb 2018 16:01:54 -0500
Received: from mail-wr0-f196.google.com ([209.85.128.196]:35693 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751362AbeBUVBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Feb 2018 16:01:52 -0500
X-Google-Smtp-Source: AH8x227/1vA8nPP5ep0a/aNcYdNFnYaGrBY5caMyC+E5isyr61t1v2+6qvIqJ1yIglia8izA498Bp/23TrFNxqSSVEM=
MIME-Version: 1.0
In-Reply-To: <20180221192807.qfyhp7z27f6r6p47@smtp.gmail.com>
References: <20180221192807.qfyhp7z27f6r6p47@smtp.gmail.com>
From: Daniel Baluta <daniel.baluta@gmail.com>
Date: Wed, 21 Feb 2018 23:01:50 +0200
Message-ID: <CAEnQRZBq3G+RPq66ObW+CM2A9BOE_tBn-fC++Ksy+O_nEFfz9Q@mail.gmail.com>
Subject: Re: [PATCH v2] iio:dummy: Replace S_IWUSR by 0200
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

On Wed, Feb 21, 2018 at 9:28 PM, Rodrigo Siqueira
<rodrigosiqueiramelo@gmail.com> wrote:
> This patch fixes the checkpatch.pl warning:
>
> drivers/iio/dummy/iio_dummy_evgen.c:151: WARNING: Symbolic permissions
> 'S_IWUSR' are not preferred. Consider using octal permissions '0200'.

> ... Why this "..." :)?

Commit subject could be done better. It is pretty obvious from the code that
we change S_IWUSR with 0200.

Better message:

iio:dummy: Fix poke_evN file permissions
