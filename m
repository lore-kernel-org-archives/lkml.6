Return-Path: <SRS0=4HPh=P2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95CD0C43387
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 00:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E62420873
	for <linux-kernel@archiver.kernel.org>; Fri, 18 Jan 2019 00:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbfARAoA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 17 Jan 2019 19:44:00 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:48150 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfARAoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Jan 2019 19:44:00 -0500
Received: from p4fea4364.dip0.t-ipconnect.de ([79.234.67.100] helo=nanos)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gkIGH-0002Wx-Kf; Fri, 18 Jan 2019 01:43:53 +0100
Date:   Fri, 18 Jan 2019 01:43:52 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     Eddie James <eajames@linux.vnet.ibm.com>
cc:     LKML <linux-kernel@vger.kernel.org>, linux-hwmon@vger.kernel.org,
        devicetree@vger.kernel.org, linux-doc@vger.kernel.org,
        Greg KH <gregkh@linuxfoundation.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        linux@roeck-us.net, jdelvare@suse.com,
        Mark Rutland <mark.rutland@arm.com>, openbmc@lists.ozlabs.org,
        robh+dt@kernel.org, joel@jms.id.au,
        Kate Stewart <kstewart@linuxfoundation.org>
Subject: Re: [PATCH v4 9/9] hwmon (occ): Add sysfs attributes for additional
 OCC data
In-Reply-To: <1531342898-15790-10-git-send-email-eajames@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.21.1901180140150.1647@nanos.tec.linutronix.de>
References: <1531342898-15790-1-git-send-email-eajames@linux.vnet.ibm.com> <1531342898-15790-10-git-send-email-eajames@linux.vnet.ibm.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Eddie,

On Wed, 11 Jul 2018, Eddie James wrote:

> --- /dev/null
> +++ b/drivers/hwmon/occ/sysfs.c
> @@ -0,0 +1,188 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * OCC hwmon driver sysfs interface
> + *
> + * Copyright (C) IBM Corporation 2018
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License as published by
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> + */

The above license information is inconsistent.

The SPDX license identifier says GPL v2 only, but the license notice says
GPL v2 or later. This is just wrong.

Please decide which one to use and please also remove the boiler plate
text. It is redundant.

See Documentation/process/license-rules.rst

Please fix ASAP.

Thanks,

	tglx
