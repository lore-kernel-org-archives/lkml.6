Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752303AbeDIAD7 (ORCPT <rfc822;w@1wt.eu>);
        Sun, 8 Apr 2018 20:03:59 -0400
Received: from forward104o.mail.yandex.net ([37.140.190.179]:53566 "EHLO
        forward104o.mail.yandex.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751526AbeDIAD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Apr 2018 20:03:57 -0400
Authentication-Results: mxback7g.mail.yandex.net; dkim=pass header.i=@yandex.ru
From: Evgeniy Polyakov <zbr@ioremap.net>
Envelope-From: drustafa@yandex.ru
To: Gergo Huszty <huszty.gergo@digitaltrip.hu>
Cc: Jonathan Corbet <corbet@lwn.net>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
In-Reply-To: <20171220190709.6584-1-huszty.gergo@digitaltrip.hu>
References: <20171220190709.6584-1-huszty.gergo@digitaltrip.hu>
Subject: Re: [PATCH] Fixed typo in onewire generic doc
MIME-Version: 1.0
Message-Id: <6472401523231809@web57o.yandex.ru>
X-Mailer: Yamail [ http://yandex.ru ] 5.0
Date: Mon, 09 Apr 2018 02:56:49 +0300
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone

I'm really sorry for that long delay.

Was this patch accepted or should I push it upstream?

20.12.2017, 22:09, "Gergo Huszty" <huszty.gergo@digitaltrip.hu>:
> Onewire devices has 6 byte long unique serial numbers, 1 byte family
> code and 1 byte CRC. Linux sysfs presents the device folder in the
> form of familyID-deviceID, so CRC is not shown. The consequence is
> that the device serial number is always a 12 long hex-string, but
> doc says 13 in one place. This is corrected by this change.
> Reference: https://en.wikipedia.org/wiki/1-Wire
>
> Signed-off-by: Gergo Huszty <huszty.gergo@digitaltrip.hu>
> ---
>  Documentation/w1/w1.generic | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/Documentation/w1/w1.generic b/Documentation/w1/w1.generic
> index b3ffaf8cfab2..c51b1ab012d0 100644
> --- a/Documentation/w1/w1.generic
> +++ b/Documentation/w1/w1.generic
> @@ -76,7 +76,7 @@ See struct w1_bus_master definition in w1.h for details.
>
>  w1 master sysfs interface
>  ------------------------------------------------------------------
> -<xx-xxxxxxxxxxxxx> - A directory for a found device. The format is family-serial
> +<xx-xxxxxxxxxxxx> - A directory for a found device. The format is family-serial
>  bus - (standard) symlink to the w1 bus
>  driver - (standard) symlink to the w1 driver
>  w1_master_add - (rw) manually register a slave device
> --
> 2.15.1
