Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519745630; cv=none;
        d=google.com; s=arc-20160816;
        b=jRA+Bdr2ZAPUQZ8umbgbWePcIWGpvkFIQZTVgMuMutga+sjHSKKXxLD8lrhjQU7cfi
         +Dt3kleHdUh2WwcJENDX3znnZPyp1/xfJlrtv3GBzxFY60fpBdEqBvSETcLkNZ6Wd2iU
         QSX/vnk3f/sCF5bxP4k+KSWI1to1Y7x4uaSECuCSGBqRmeQsJu6a6RqccbKb/UL7wASD
         qZmdnjeNoOXYSxqylJy+Kp2VS0Ft+bGOlimjfB13fJwjVqvcYVq9wazwu4wlrklr0jYn
         2A9Nt8rhiQz+oCXFMhvV7euJR4gStnmQY7DiJBV7cSiB1qAto6RzU3USSQBib9E06fkL
         yPnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=WQvp5vHEZ4byAB/kcZojOyzd16D8AJmViH3UQqXL/7o=;
        b=r66Y25acJY/PagsENd07J2w5ulHjmpqb2pbW680cpqGhkURoSPJqTpEEiu6LI2CvLx
         wwlWXFX0W9iFyLqdxN+wnVymMeWPbhtqAPWjHOEddZwv7KvK6+xhYzsC8lLsNrY/PnL8
         Rgh2V12cauVLBunZQgXCVOtrXf82gkuThtN5BcrOAue9Cfu2on9cjLArjbtNiKiNyWm2
         f5XVFBofchblsvM8x5sshMmB1Rd74MiuOlH2Tcw39AlhPP8AwCtHUNlwLM5UUx4J5Gpd
         JglHYHjqisRbuWqRS8CVmkMXhUBcHbn8TDqVtUxz1xk9cvJ+zL7OttIwvDdk79tRutKD
         V9XA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=a26FIqZa;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=a26FIqZa;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuIl5ODrvmHqnG6b27etIaYa6jwiuIc4c6oSD9SUEH9NxPZt6eTve2LsYWCEOlQv0LsgZN8TPJarvRBw17wXm0=
MIME-Version: 1.0
In-Reply-To: <20180227133726.frfk2lymnyvrs4th@linux.suse.de>
References: <20180227133018.7732-1-jthumshirn@suse.de> <20180227133018.7732-3-jthumshirn@suse.de>
 <20180227133726.frfk2lymnyvrs4th@linux.suse.de>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Tue, 27 Feb 2018 17:33:49 +0200
Message-ID: <CAHp75VdwKR-SAV1wewksaNOoiaSJGut+e8CoA_Dp=mchOgE3cA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mcb: add Altera PCI ID to mcb-pci
To: Michael Moese <mmoese@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>, =?UTF-8?Q?Andreas_Gei=C3=9Fler?= <andreas.geissler@men.de>,
	Greg KH <gregkh@linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593561031162206643?=
X-GMAIL-MSGID: =?utf-8?q?1593568794098364816?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 27, 2018 at 3:37 PM, Michael Moese <mmoese@suse.de> wrote:
> Looks good.

Do we need redundant header inclusions?

> Reviewed-by: Michael Moese <mmoese@suse.de>

> On Tue, Feb 27, 2018 at 02:30:18PM +0100, Johannes Thumshirn wrote:
>> Some older PCI attached MEN FPGAs use an Altera PCI Vendor ID instead
>> of the MEN one. Add it to the PCI ID table so the driver automatically
>> attaches to it.

>>  #include <linux/pci.h>
>> +#include <linux/pci_ids.h>

Same question.

-- 
With Best Regards,
Andy Shevchenko
