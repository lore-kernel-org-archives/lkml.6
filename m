Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752515AbeBZKYk (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Feb 2018 05:24:40 -0500
Received: from mail-it0-f53.google.com ([209.85.214.53]:50756 "EHLO
        mail-it0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752063AbeBZKYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Feb 2018 05:24:36 -0500
X-Google-Smtp-Source: AG47ELt+Zgimvlm4wp2i19BhBnfBZ+XvnQcg9l/MVOzrz7Uc822YOsoB9Dh1+oc1SBLt8uuQbKbvZSNjpRoL6W/5at0=
MIME-Version: 1.0
In-Reply-To: <20180221091623.4accxa2qglmo3scl@flea.lan>
References: <20180221081100.17662-1-maxime.ripard@bootlin.com>
 <CACRpkdYkT7TJrhyQoJr=ZK7w8+KY=_fgjrJeaZCsLHA_6WbZbg@mail.gmail.com> <20180221091623.4accxa2qglmo3scl@flea.lan>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 26 Feb 2018 11:24:35 +0100
Message-ID: <CACRpkdb1=H-KqZyB50k9gUSUJXtGqeYA8w05Q_P8Jod-2wmWpg@mail.gmail.com>
Subject: Re: [PATCH] gpiolib: Keep returning EPROBE_DEFER when we should
To: Maxime Ripard <maxime.ripard@bootlin.com>
Cc: Chen-Yu Tsai <wens@csie.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 21, 2018 at 10:16 AM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> On Wed, Feb 21, 2018 at 09:17:15AM +0100, Linus Walleij wrote:
>> On Wed, Feb 21, 2018 at 9:11 AM, Maxime Ripard
>> <maxime.ripard@bootlin.com> wrote:
>>
> This is slightly embarrassing, but that patch doesn't actually fix
> anything. I tried to be smart and rework it to look nicer, and
> obviously failed.
>
> Can you squash
> http://code.bulix.org/z1vkt1-286673
>
> in the commit?

This site is down. Can you send a new version of the patch or
just reply with the change inline here?

Yours,
Linus Walleij
