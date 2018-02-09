Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518183638; cv=none;
        d=google.com; s=arc-20160816;
        b=Q+a3YOtKwiwD1Ib9WvMKXZpwFWO9puo/5U9+MxGMk0iqObTrDDD5TA1CuDVLm85Gzg
         2AxRpoRTEPnu1RH+D/DsU/P159TxJQ1CpduXNpMyJ8GpKEB5YTAb1YQaC4hsh2aaSp13
         n1L8yfxD3c8fM7ADYykvzCC02Wed+IocK42SbuAHwpKxnqZ22x0zSFZ22TpI+snbJDq8
         Pf8iUVWc/hN63wFro24wSPEy6+qYjuWfHMpYC/JHLIE7WSrzhcv2IUHe2NO1OO+8VmHJ
         AwzUO2CwpMR7lefkDsbRYIr0TujXKuUefKZfUu3WgzaXIq/kkvnpTD+NKPjuhk7m+JrC
         QPcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=BgncKTKIehp+GgPDS51TegDT+1pH2/St7KOBWCkLMdY=;
        b=cH0e658FjRy9Nu3WQ8CXv166m1rZqYq6Y8h25qojfKwPQkIl3vNCXXmBbnjFZyI6k5
         KEMqAQv8mkHeRsCdXjdZ6JSc5sbq4V9knFtJ3OdBO7DJ/rCCKtKzrSpTsB1ew0uxO+EE
         wy9Ml2p+vtpOQGxZAmFp844HBCfaxSXm17k8WzLUv5Y2JqeWgMovI32K1FaYyjcFDPHn
         vIqVfJorQZvdAEKpJ5Ko90/1JJgs2ZDGbR73UNbJ5W0vwB8QyxVprWLy2RezzxtiQvWL
         NTF9RpaeQX1rMWDhP9xnhcxLfVnxwg65aGgPsMNnJhAax8z7vd6V/n7RbQfBlCbqbSI0
         JR2g==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cJRHXzUk;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cJRHXzUk;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AH8x224+EI76OS/tnHWxas972KUa8VyC6jGk03X+E8fUnwbfsR95fGENmRzX50fJMreloccUWNst76vqdsd27skx+ds=
MIME-Version: 1.0
In-Reply-To: <20180209022239.GB25898@fury>
References: <1517561148-38587-1-git-send-email-vadimp@mellanox.com> <20180209022239.GB25898@fury>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 9 Feb 2018 15:40:38 +0200
Message-ID: <CAHp75VdQgUjrkWDxTOd67qAn29gyQg2d6BoU5ODxS-bJ7SwPEw@mail.gmail.com>
Subject: Re: [patch v1 0/4] mlx-platform: Add support for new Mellanox
 systems, code improvement, fixes for msn21xx system
To: Darren Hart <dvhart@infradead.org>
Cc: Vadim Pasternak <vadimp@mellanox.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Platform Driver <platform-driver-x86@vger.kernel.org>, =?UTF-8?B?SmnFmcOtIFDDrXJrbw==?= <jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591270875340200693?=
X-GMAIL-MSGID: =?utf-8?q?1591930927404991804?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Feb 9, 2018 at 4:22 AM, Darren Hart <dvhart@infradead.org> wrote:
> On Fri, Feb 02, 2018 at 08:45:44AM +0000, Vadim Pasternak wrote:

>>   platform/x86: mlx-platform: Use defines for bus assignment
>>   platform/x86: mlx-platform: Add define for the negative bus
>>   platform/x86: mlx-platform: Fix power cable setting for systems from
>>     msn21xx family
>
> I've queued 1,2,3 and will try to include these in one final PR to Linus during
> the Merge Window. (Andy, FYI)

Noted.

-- 
With Best Regards,
Andy Shevchenko
