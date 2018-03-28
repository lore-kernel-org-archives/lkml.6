Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752777AbeC1KGM (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 06:06:12 -0400
Received: from mail-wm0-f67.google.com ([74.125.82.67]:39996 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752560AbeC1KGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 06:06:10 -0400
X-Google-Smtp-Source: AIpwx4+PJ4yO7VdDlw8KRS56yUovOA69qYbBgDYHk066iNpsge65tXbCPUxaZfXTq97ddT1EdRBU9g==
Date: Wed, 28 Mar 2018 11:06:06 +0100
From: Lee Jones <lee.jones@linaro.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: Andrey Gusakov <andrey.gusakov@cogentembedded.com>, jdelvare@suse.com,
        cphealy@gmail.com, andrew.smirnov@gmail.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] hwmon: MC13783: add uid and die temperature sensor
 inputs
Message-ID: <20180328100606.huvblelpdsbzx3w7@dell>
References: <1522160389-18822-1-git-send-email-andrey.gusakov@cogentembedded.com>
 <ecb9f724-de98-5435-135c-2ca2661f5ee6@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ecb9f724-de98-5435-135c-2ca2661f5ee6@roeck-us.net>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Mar 2018, Guenter Roeck wrote:

> On 03/27/2018 07:19 AM, Andrey Gusakov wrote:
> > The uid and die temperature can be read out on the ADIN7 using
> > input mux. Map uid and die temperature sensor to channels 16
> > and 17.
> > 
> > Signed-off-by: Andrey Gusakov <andrey.gusakov@cogentembedded.com>
> 
> Applied to hwmon-next.

You've applied changes to a subsystem without an appropriate
Maintainer Ack?

> > ---
> > Changes in v3:
> > - comment style fixes
> > Changes in v2:
> > - suport both mc13783 and mc13892
> > - uid_input renamed to in16_input
> > - style fixes
> > ---
> >   drivers/hwmon/mc13783-adc.c | 60 +++++++++++++++++++++++++++++++++++++++++++++
> >   drivers/mfd/mc13xxx-core.c  | 15 +++++++++++-
> >   include/linux/mfd/mc13xxx.h |  2 ++
> >   3 files changed, 76 insertions(+), 1 deletion(-)

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
