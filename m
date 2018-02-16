Return-Path: <rdunlap@infradead.org>
X-Google-Smtp-Source: AH8x227a3eqjJpaffAAA1CDHIpi5bXSXe1Ya/HWr6P5srxV3iUKO1LFFjMcniqzulyw44QS7TcS9
ARC-Seal: i=1; a=rsa-sha256; t=1518806026; cv=none;
        d=google.com; s=arc-20160816;
        b=ry8fAWeBl5r/jripZkYKXtSS3elE6iqxXKBv2zbs8+EBZne0qhyUzqIiwoble4Iyid
         NMZzoBrCMBNWiFHXBlnjZ/ydjhrVTQfDISWWPjmd4LxtyVo+hd/+vgc/X6ypVVsKOkUw
         QoOVSOssnr3l1cOvqLMYZwwjCOvTDVuZJ4iXaLcVMG1330Od/31Nk/AZM9on28Nv9mf6
         rmNOYyzfvmGoVpQPb4g4Zn2IJ2gsnBhplmIHnQW32TheU6/IPRG12bIuhHUFBvasJVxN
         36VpaDFAmCqqHjCK1cuvCqQeRMXoY3/l6UGjP6sjEh2xl+4XX03Z/Q+oAbda63qf7hlD
         XczQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=XhRSBo5xR9m0bEqrCTPl6j2FqSKZ2cuoEF5JN0mHgA4=;
        b=cr/f51dmRdcc1CYHoMZbPVJFhudnt7DL2yo82ee7AwAcMzjkxXfSdy7KmaxiMwtvwo
         LRDq4vNl2FVgA95l8hyhoidfYisd0BoXBXcyH0fKtodUmcXSuSHCcgxJ5OFgntTx660S
         K4MZfRAKMyp7Axj1IXXJRTZ0idw1PFdfTqaAdsbO8g5oFmibAtpQEfAZleAn7apVYTMx
         YPBBBYX0cFAHf7OR5seqK6SYE4wJC/C8v06mK6jtEkA5IiU4VIMRJGWZjIL5dvJ5RvPq
         2NUfUKps2vWYgsHc/SWtGoIFGY66ztPtwdaaxLP/44oG5T3HjAoF2igw8QWEiCBLAgvQ
         AJyw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=j10FmEjP;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@infradead.org header.s=merlin.20170209 header.b=j10FmEjP;
       spf=pass (google.com: best guess record for domain of rdunlap@infradead.org designates 2001:8b0:10b:1231::1 as permitted sender) smtp.mailfrom=rdunlap@infradead.org
Subject: Re: [PATCH 04/12] usb: common: Small class for USB role switches
To: Hans de Goede <hdegoede@redhat.com>, Darren Hart <dvhart@infradead.org>,
 Andy Shevchenko <andy@infradead.org>, MyungJoo Ham
 <myungjoo.ham@samsung.com>, Chanwoo Choi <cw00.choi@samsung.com>,
 Mathias Nyman <mathias.nyman@intel.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-usb@vger.kernel.org
References: <20180216104751.8371-1-hdegoede@redhat.com>
 <20180216104751.8371-5-hdegoede@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <90191d89-0881-3486-87f9-59b355824927@infradead.org>
Date: Fri, 16 Feb 2018 10:33:37 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180216104751.8371-5-hdegoede@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592554245536279183?=
X-GMAIL-MSGID: =?utf-8?q?1592583548462727888?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 02/16/2018 02:47 AM, Hans de Goede wrote:
> From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> 

> diff --git a/drivers/usb/common/roles.c b/drivers/usb/common/roles.c
> new file mode 100644
> index 000000000000..923e3721d183
> --- /dev/null
> +++ b/drivers/usb/common/roles.c
> @@ -0,0 +1,305 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/**

Just use /* since this is not kernel-doc notation.

> + * USB Role Switch Support
> + *
> + * Copyright (C) 2018 Intel Corporation
> + * Author: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> + *         Hans de Goede <hdegoede@redhat.com>
> + */


-- 
~Randy
