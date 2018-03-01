Return-Path: <andy.shevchenko@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519906624; cv=none;
        d=google.com; s=arc-20160816;
        b=ta4KN9XgtIH0bcNN88fyqoTMudPiv9pryrTUNbMBVNA0RagqWq8oLbE060CeTo7OUl
         5vtS3wYj77Dp1QpcfceTtnpINA0ePOq9KZL0j4Py47FZAyz3Q/Fdgb/+PuWAeb3gwtxL
         bKbLDSSwMT9NbER3J5l08iw6YQh0/pf0IIGyAHrV0Gp0gTNHFgawXiUcvgRoqNx4gPK7
         8hx6kapv0Ps7bQyZVQcG3ouB1ezbmzvNDnm2DWl0OoJmRDohgTint080laoNAJduxGIU
         GxTafKGVKArnt5YfbE533eeJIbLL8IHUqnMfDRpQoqZpxn07ZawPGKG2BcaZ0SXOIVUH
         CGrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=V07bD/hkKA5NykGNqV8x2fPckw7oG9O2UR+kafRmBd0=;
        b=ifEbC2WHR1zgK3pI6YL1C8aLvDJ0toC3j3nuumFSCGXh4/Se6x2p8fScEgYMzJle99
         y1ODvZ5IhIUhRYGyfctIEEFHeDQCkG1ckwETEWONsPnfzQlsBzwbZsQtMc2e4CRFPqA7
         zn3VXLlQh1CWjdssn5ZiEKh6d99hrS6jFiVdhsY78ZOgzHao2FKNCmd3ay5sS3FwKP1X
         kaOhK2QJn1wY1/t95fxusfhjgJcjQ2YtiqRxdJCvkMHHXML1UPFt5GaYc4Bslp/JlhUF
         iEIQw+hm0tkdGmUgYyZ759pGjCXbbadbby5bWmeS5Xt1wElbLxuQNM1RmOeakSMYTSf9
         KUJg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ckuAd5k8;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ckuAd5k8;
       spf=pass (google.com: domain of andy.shevchenko@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=andy.shevchenko@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuSiGJCphxs4j3ICg5MhgnPDyOKprvml0HjFaP3f+Cxsgl2Gf3cVHy2uaSwaTjyR3rlGFhGSQPWVUiTYgOKL2A=
MIME-Version: 1.0
In-Reply-To: <20180301120609.GA31656@kroah.com>
References: <1518032879-5844-1-git-send-email-sudipm.mukherjee@gmail.com>
 <CAHp75VdAEEjycTvxb=KLOsBESRfSjio1uDXfY=gR91TxCCOkVg@mail.gmail.com> <20180301120609.GA31656@kroah.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Thu, 1 Mar 2018 14:17:03 +0200
Message-ID: <CAHp75VfL2geqBTX+h5yS-Ji9skLznC7iyc8Nit44=xGOpoGcjQ@mail.gmail.com>
Subject: Re: [PATCH 01/12] parport: ax88796: Delete an error message for a
 failed memory allocation in parport_ax88796_probe()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591772848657448336?=
X-GMAIL-MSGID: =?utf-8?q?1593737608744651321?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Mar 1, 2018 at 2:06 PM, Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> On Thu, Mar 01, 2018 at 12:46:07PM +0200, Andy Shevchenko wrote:
>> On Wed, Feb 7, 2018 at 9:47 PM, Sudip Mukherjee
>> <sudipm.mukherjee@gmail.com> wrote:
>> > From: Markus Elfring <elfring@users.sourceforge.net>
>> >
>> > Omit an extra message for a memory allocation failure in this function.
>> >
>> > This issue was detected by using the Coccinelle software.
>> >
>>
>> Greg, just to be sure this series is under your scope.
>> IIRC it had been sent during merge window, though it looks like your
>> tty tree doesn't include it yet, while even older patches, which were
>> sent as well during merge window, made it
>
> It's in my large "to-review" queue...

Ah, sorry to bother then!

> Personally, stuff like this, from this specific developer, ends up at
> the bottom of that list as well...

Thanks for clarification.

-- 
With Best Regards,
Andy Shevchenko
