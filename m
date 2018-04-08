Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752678AbeDHJD7 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 05:03:59 -0400
Received: from smtp09.smtpout.orange.fr ([80.12.242.131]:23939 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752588AbeDHJD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 05:03:57 -0400
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Sun, 08 Apr 2018 11:03:54 +0200
X-ME-IP: 86.201.130.131
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH] ARM: pxa: stargate2: use device properties for at24 eeprom
References: <20180404114706.15856-1-brgl@bgdev.pl>
        <878ta24uyy.fsf@belgarion.home>
        <CAMRc=MfD659sqbwRJs2tti-VcSShLWU-yB8=SR7zhv8Pz6XQcA@mail.gmail.com>
X-URL: http://belgarath.falguerolles.org/
Date: Sun, 08 Apr 2018 11:03:48 +0200
In-Reply-To: <CAMRc=MfD659sqbwRJs2tti-VcSShLWU-yB8=SR7zhv8Pz6XQcA@mail.gmail.com>
        (Bartosz Golaszewski's message of "Thu, 5 Apr 2018 10:32:38 +0200")
Message-ID: <87sh862hor.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bartosz Golaszewski <brgl@bgdev.pl> writes:

> 2018-04-04 21:44 GMT+02:00 Robert Jarzmik <robert.jarzmik@free.fr>:
>> Bartosz Golaszewski <brgl@bgdev.pl> writes:
> Yes, it does use the type field from i2c_board_info implicitly over
> i2c-core. The type field is copied over to client->name and then is
> matched against the i2c ID table from which we get the associated chip
> data (unless the type is "at24") containing the size and flags.

Ah yes, the "struct i2c_device_id at24_ids" part, I see.

Applied to pxa/for-next, thanks.

-- 
Robert
