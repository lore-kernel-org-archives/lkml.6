Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752107AbeBDTKz (ORCPT <rfc822;w@1wt.eu>);
        Sun, 4 Feb 2018 14:10:55 -0500
Received: from mail-io0-f172.google.com ([209.85.223.172]:37572 "EHLO
        mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751767AbeBDTKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Feb 2018 14:10:47 -0500
X-Google-Smtp-Source: AH8x2250DoD/9n1Wgvpy+zj1p7vjX2Eq65EN7+XScXRj8ZoCPMoQmfn/2OCS2hJJcjvB1kL6CGt52+f1p1ZPqR+SfoQ=
MIME-Version: 1.0
In-Reply-To: <20180203223020.s6iph2oe7uphoz3q@ninjato>
References: <20180203223020.s6iph2oe7uphoz3q@ninjato>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 4 Feb 2018 11:10:45 -0800
X-Google-Sender-Auth: tA2-OexbV8Em33J_ggMd3-AbiaM
Message-ID: <CA+55aFznKWoq3bbGMqKLSCj1Kv_aPQ7G+ojYajhiH+vxYH4BJA@mail.gmail.com>
Subject: Re: [PULL REQUEST] i2c for 4.16
To: Wolfram Sang <wsa@the-dreams.de>
Cc: linux-i2c@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Rosin <peda@axentia.se>, Bartosz Golaszewski <brgl@bgdev.pl>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 3, 2018 at 2:30 PM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
> There was a small merge conflict in MAINTAINERS in linux-next, but that
> should be easy to fix.

Well, that one wouldn't have happened at all if the i2c people knew
how to sort things..

It also grew a few other conflicts since linux-next, but hopefully I
got those right too.

              Linus
