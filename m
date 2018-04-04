Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751561AbeDDTpC (ORCPT <rfc822;w@1wt.eu>);
        Wed, 4 Apr 2018 15:45:02 -0400
Received: from smtp05.smtpout.orange.fr ([80.12.242.127]:57718 "EHLO
        smtp.smtpout.orange.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751339AbeDDTpB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Apr 2018 15:45:01 -0400
X-ME-Helo: belgarion
X-ME-Auth: amFyem1pay5yb2JlcnRAb3JhbmdlLmZy
X-ME-Date: Wed, 04 Apr 2018 21:44:59 +0200
X-ME-IP: 86.201.130.131
From: Robert Jarzmik <robert.jarzmik@free.fr>
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH] ARM: pxa: stargate2: use device properties for at24 eeprom
References: <20180404114706.15856-1-brgl@bgdev.pl>
X-URL: http://belgarath.falguerolles.org/
Date: Wed, 04 Apr 2018 21:44:53 +0200
In-Reply-To: <20180404114706.15856-1-brgl@bgdev.pl> (Bartosz Golaszewski's
        message of "Wed, 4 Apr 2018 13:47:06 +0200")
Message-ID: <878ta24uyy.fsf@belgarion.home>
User-Agent: Gnus/5.130008 (Ma Gnus v0.8) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Bartosz Golaszewski <brgl@bgdev.pl> writes:

> We want to work towards phasing out the at24_platform_data structure.
> There are few users and its contents can be represented using generic
> device properties. Using device properties only will allow us to
> significantly simplify the at24 configuration code.
>
> Remove the at24_platform_data structure and replace it with an array
> of property entries. Drop the byte_len/size property, as the model name
> already implies the EEPROM's size.
Hi Bartosz,

I'd like a little explanation for the last sentence. Are you implying that
ac24.c is using the "type" field, and if so could you point me to the correct
line, because I was under the impression a property called "size" is used for
byte_len value ... ?

Cheers.

--
Robert
