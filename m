Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751864AbeDMVLM (ORCPT <rfc822;w@1wt.eu>);
        Fri, 13 Apr 2018 17:11:12 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:33063 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751630AbeDMVLK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Apr 2018 17:11:10 -0400
X-Google-Smtp-Source: AIpwx4/Ip4QVcQw/lFed1THp5MZiThgqXUA56Sc3D7R3ppvg/KokcS3P4xDk/7uo3ERdOSEk7JUGnw==
Date: Fri, 13 Apr 2018 16:11:09 -0500
From: Rob Herring <robh@kernel.org>
To: Javier Martinez Canillas <javierm@redhat.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Nick Dyer <nick@shmanahar.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] Input: atmel_mxt_ts - add missing compatible strings to
 OF device table
Message-ID: <20180413211109.scyuwx7gptutvon4@rob-hp-laptop>
References: <20180410095340.24074-1-javierm@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180410095340.24074-1-javierm@redhat.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 10, 2018 at 11:53:40AM +0200, Javier Martinez Canillas wrote:
> Commit af503716ac14 ("i2c: core: report OF style module alias for devices
> registered via OF") fixed how the I2C core reports the module alias when
> devices are registered via OF.
> 
> But the atmel_mxt_ts driver only has an "atmel,maxtouch" compatible in its
> OF device ID table, so if a Device Tree is using a different one, autoload
> won't be working for the module (the matching works because the I2C device
> ID table is used as a fallback).
> 
> So add compatible strings for each of the entries in the I2C device table.
> 
> Fixes: af503716ac14 ("i2c: core: report OF style module alias for devices registered via OF")
> Reported-by: Enric Balletbo i Serra <enric.balletbo@collabora.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> ---
> 
>  Documentation/devicetree/bindings/input/atmel,maxtouch.txt | 6 +++++-
>  drivers/input/touchscreen/atmel_mxt_ts.c                   | 4 ++++
>  2 files changed, 9 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
