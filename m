Return-Path: <kstewart@linuxfoundation.org>
ARC-Seal: i=1; a=rsa-sha256; t=1524753010; cv=none;
        d=google.com; s=arc-20160816;
        b=K/KkP9EW77jZeBds+vaO8BMkegUUG0zlcjGMS4MIK1cXT3B2x5fxxAarwUjzLsbjCr
         Y16N6kysTy0kIjRUKS3KdA2UcMhblzoVU6Rl1pxci5f7H7mH1aJk0a0ugKXQ6r7AwUf6
         ADXb4evT+xAc4cuZJ1+DRcq4rb7Eet55/sy3efK8qX1KB5MrHzuKlMx8uBgGMc0/Cu2K
         Hv/vJF/aoZD+NdjDN/E9t8+1ANINNgzL/+4b1EA75UlRNgzbp/xy8rzouIK86HhUfb5l
         5/94me5izHkvNjVTCvUqSm+lGOSPxj2ESz/lqp/srMKF7oqJ00lWfsOhofAnkzKPp+Cn
         de7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=29MQ5/FNfDimsmWlBY6KNSVBcUgPbQ/Plyje8+rxKzg=;
        b=E+ysvDB2EBztvxViCMQqDOCFa/B9Izql2lF07BQxrVkG+kExNWRwWtrZTpjdUk4HAH
         omkGwbXKBtDczrBDDdvYnXT/ohOMD273iieBBPjFdlUdeoiUXFqMdM9g+On6t9GVgyfz
         R0Y3T3EJETqt51A6LlJrPapzdrULQqP8GvAYd8I8IVliYNrZfhfw6Tub3StQGUbnrvVB
         jevS6C4TSfW3FEU3s26pTBfqrFL70GroNi1HWLYKclgte57r7i24whySJNWNGohepxWw
         pbXRmffE0RaeZsDW8xXRPNGJNTcI0zFzSBGpL+Nu8a4nr1lRw9kMV7gmF6eOi6pvP5Yq
         Uw1w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SFchXWmH;
       spf=pass (google.com: domain of kstewart@linuxfoundation.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=kstewart@linuxfoundation.org
Authentication-Results: mx.google.com;
       dkim=pass header.i=@linuxfoundation.org header.s=google header.b=SFchXWmH;
       spf=pass (google.com: domain of kstewart@linuxfoundation.org designates 209.85.220.65 as permitted sender) smtp.mailfrom=kstewart@linuxfoundation.org
X-Google-Smtp-Source: AB8JxZoB6OteEq7EPrLzjarwdmvEKsUzI91587EL5db3YRR1hbT8F0MjrSMlvCxZKe7oqtbV4ZmpyEnIHPYa0Guycno=
MIME-Version: 1.0
In-Reply-To: <20180426070057.GH14025@kroah.com>
References: <20180425203020.594959448@linutronix.de> <20180425203703.322071447@linutronix.de>
 <20180426070057.GH14025@kroah.com>
From: Kate Stewart <kstewart@linuxfoundation.org>
Date: Thu, 26 Apr 2018 09:30:09 -0500
Message-ID: <CAG_66ZQnw97A2Lb+owAj1D9HcnST88b0fwZxxU6yh-o_RwQvVQ@mail.gmail.com>
Subject: Re: [patch V2 3/7] LICENSES: Add Apache 2.0 license text
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
	Philippe Ombredanne <pombredanne@nexb.com>, Jonathan Corbet <corbet@lwn.net>,
	Hans Verkuil <hans.verkuil@cisco.com>, Mauro Carvalho Chehab <mchehab@s-opensource.com>,
	Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598752949560100288?=
X-GMAIL-MSGID: =?utf-8?q?1598819412481268452?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 26, 2018 at 2:00 AM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Wed, Apr 25, 2018 at 10:30:23PM +0200, Thomas Gleixner wrote:
>> Add the full text of the Apache License version 2 to the kernel tree.  It
>> was copied directly from:
>>
>>    https://spdx.org/licenses/Apache-2.0.html#licenseText
>>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Kate Stewart <kstewart@linuxfoundation.org>
