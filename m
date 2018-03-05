Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752741AbeCESaB (ORCPT <rfc822;w@1wt.eu>);
        Mon, 5 Mar 2018 13:30:01 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:46071 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751311AbeCESaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Mar 2018 13:30:00 -0500
X-Google-Smtp-Source: AG47ELve3lkVqFqY4AMZh+o6hiElRjDicVBJ4WNhkwCBPJNrpSm/gF69iqYiqciVkNpkBd39yDtYg9lB2F0UdfXtR/I=
MIME-Version: 1.0
In-Reply-To: <20180305161739.GN8588@sirena.org.uk>
References: <1520017960-5120-1-git-send-email-festevam@gmail.com> <20180305161739.GN8588@sirena.org.uk>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 5 Mar 2018 15:29:58 -0300
Message-ID: <CAOMZO5DjxO8FZubTgUyhm=PQbqTKZ7LKV30D1jzw6Qx6SdsiKA@mail.gmail.com>
Subject: Re: [PATCH] regmap: debugfs: Do not print warning when no device is associated
To: Mark Brown <broonie@kernel.org>
Cc: David Lechner <david@lechnology.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Mon, Mar 5, 2018 at 1:17 PM, Mark Brown <broonie@kernel.org> wrote:

> This then means that we will just randomly not create a debugfs for
> anything except the first device that tries to do so with no device
> which doesn't seem right.  We should try harder to create a name here,
> for example we could try printing the pointer to the map.  Or keep a
> counter and use dummy0 and so on.

Tried your second suggestion of creating dummy0, dummy1, dummy2, etc
and it worked here.

Will send a v2 shortly.

Thanks
