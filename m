Return-Path: <brgl@bgdev.pl>
ARC-Seal: i=1; a=rsa-sha256; t=1521821192; cv=none;
        d=google.com; s=arc-20160816;
        b=kDykkgzgKbicPVkyUns/CAPK1PZ5H+R0P5xTiCb6SBNOxYtnjYyg6Y76OIX3m3ntnh
         oe7wmoiXxw9fgItr6xR3mvuZ705SXTrZgYRNvNPY8+TKyf2EuQGtRcFoucA3msPLBsND
         zDURb+bQFxAugSdQst2mY8/88NRPBqKVCSinVNL0UEV/ba8j+RaxLWyZ0UxEXxalB+WS
         /0FuQn1dJXI7KREWX1DqaZhpbFcYBQunUcEIiyPCkXmBv3OL0Lbk0AQ0zAm/79VSgrks
         ixOH1G9e0ts74zYZEJhPK8d0UeRDw6mcakeTcoGWspqWsIchjDXEbJUIk5sJqdNHNOHD
         QgHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:dkim-signature:arc-authentication-results;
        bh=iDxjOPGZbH4e0kz1eWsCZcFAi7pnhkCkmRFGeoud7Eg=;
        b=u2n2VXgJa6/Wg2nUKMrEDWQDRxm6aiOub2+2p3wQ/1+mtp5+EVUucQpNheBrjPt+fm
         oYnS6SpQEi1bLGEvbtlnyRRbD/dEhjjk70guIaFcgMGj4ryUnie9OaG/sQgE21nsSkfK
         NG1UV/bmdIytlF0cMKjQWQ0/OYRTytnZKcuiP2lPK/78zVn42LghoR50U+deqD8HQ3JZ
         Ftl5vGO4UiPIwwv3OqCSRAgMuQs4fkJF6GIKs687cMz1Pa8Fv1ZGNMuWiHiTe0A27CH1
         pZA4nYIMmzBPIDgFEM8gbblghaNH0VUYj/lIP1arHAkLHDN+cXlqvew2DqPtFsnafcwx
         xDBg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=KNHc2RYU;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
Authentication-Results: mx.google.com;
       dkim=pass header.i=@bgdev-pl.20150623.gappssmtp.com header.s=20150623 header.b=KNHc2RYU;
       spf=neutral (google.com: 209.85.220.41 is neither permitted nor denied by best guess record for domain of brgl@bgdev.pl) smtp.mailfrom=brgl@bgdev.pl
X-Google-Smtp-Source: AG47ELsBdwnWYyMJP+P0iOX5f1XxnSOKXM5M6GiOCfnpPt4jJrTuFY7yW/TGv6+83OgbedeqIfV/gdCG54HGmb8VQXo=
MIME-Version: 1.0
In-Reply-To: <20180323152157.GA6934@kroah.com>
References: <20180319091721.18193-1-brgl@bgdev.pl> <20180319091721.18193-4-brgl@bgdev.pl>
 <20180323152157.GA6934@kroah.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 23 Mar 2018 17:06:30 +0100
Message-ID: <CAMRc=Mce2SV+JHqFvm66H-FnuGvH6PSg=cgrtxzoR+xZgkzg+A@mail.gmail.com>
Subject: Re: [PATCH 03/21] eeprom: at24: arrange local variables
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-i2c <linux-i2c@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595357055264032124?=
X-GMAIL-MSGID: =?utf-8?q?1595745178054277686?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-03-23 16:21 GMT+01:00 Greg Kroah-Hartman <gregkh@linuxfoundation.org>:
> On Mon, Mar 19, 2018 at 10:17:03AM +0100, Bartosz Golaszewski wrote:
>> Arrange declarations of local variables by line length as visually
>> it's easier to read.
>
> That's the craziest thing I've seen in a while...
>
> ok, if it makes it easier for you :)
>
> greg k-h

Hi Greg,

this isn't something unusual, see for example:

bef6b1b7a6ff ("nfp: reorder variables in nfp_net_tx()")
5318c53d5b4b ("crypto: s5p-sss - Use consistent indentation for
variables and members")

Thanks,
Bart
