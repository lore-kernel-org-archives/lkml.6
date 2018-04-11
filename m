Return-Path: <arndbergmann@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1523436333; cv=none;
        d=google.com; s=arc-20160816;
        b=ljjNcDP+oxrfXuzY9mj8FAx+C9fxWnJTnjotr48/GTteUlFk9zWw3jSUIThv6wNjFl
         8H4UJzvG0/OpV8veYiNdwUI9eGYQFrUJpLN9FkPozdNbb7smrlJFpKyJD2Ja+1y+PpIP
         tuSEUbAE4X21ApPOaVNSYvVydvKNXNn6ttFyoht6zLpTVhmkE3doK5NzbmrjQInKOk+2
         KtarWE18ZFNiIC8NhhepMok84XH6TY1ZSmbY1yBIldgokT6FRGGfAM3m7+hGp01tVV9C
         5KscWrvDEepYIcHX6RE+VF+SVNYFnXAQGDdb8+G5Z2076V4+rB3WxsySrxmYUclelBWT
         v0sQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=Zrr2FWsnh8PvfrSg0quUeP3YfBtO/VniTSMNwcTSj4U=;
        b=MdQ1YUJ9t8oANumn0Qm1yWD/u+U7mL124UEFyCrHDtaZe0+yMw71Zh5CsYXtEjm0qr
         3m6cwLTwSLgUHY5wfg64aR8MW+O5Myw9mh3t5hM/WyyBIyzX+ZqjuCX0DiPVbKjz/P68
         vGLTK3oxAbxMpiMDpYooo2j+j15zp6Phd1CJXQXLiR2974sn/Wx3TyPDM5U467rvacos
         Vwo46kKqzPvnbGAgeJXT/+UVsZL9ub8ke4GWEntT9meUlCrbTyLYCGXO6Gh3Vt+8ZDej
         P4ogH8HPgTaunzoPFuVWolvAoc6fQGSOgY6oXGFo/tILcjFMq8g90EA7M9YFit63rY/L
         xLQA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cWwiVai/;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cWwiVai/;
       spf=pass (google.com: domain of arndbergmann@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=arndbergmann@gmail.com
X-Google-Smtp-Source: AIpwx4/D0oadcNa3EFCD1tNVjxyIvO+wulPm8JmmfGl/W9O2keGX5Kvu00wNNlsEq2kaQrOhWbK0snuZIEosKF2RINI=
MIME-Version: 1.0
Sender: arndbergmann@gmail.com
In-Reply-To: <20180411010412.18006-1-labbott@redhat.com>
References: <20180411010412.18006-1-labbott@redhat.com>
From: Arnd Bergmann <arnd@arndb.de>
Date: Wed, 11 Apr 2018 10:45:32 +0200
X-Google-Sender-Auth: iKUb2qWgow429FFTRrsk6oy-Fyo
Message-ID: <CAK8P3a36rXwCj9Z_m_th62BvvMc7X3rYqbQPr3ti_8=Pn=e5Xw@mail.gmail.com>
Subject: Re: [PATCHv2] misc: tifm: Remove VLA
To: Laura Abbott <labbott@redhat.com>
Cc: Alex Dubov <oakad@yahoo.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Kernel Hardening <kernel-hardening@lists.openwall.com>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597304272703650108?=
X-GMAIL-MSGID: =?utf-8?q?1597438777331076524?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 11, 2018 at 3:04 AM, Laura Abbott <labbott@redhat.com> wrote:
> There's an ongoing effort to remove VLAs[1] from the kernel to eventually
> turn on -Wvla. The single VLA can either take a value of 2 or 4 so switch
> to the upper bound.
>
> [1] https://lkml.org/lkml/2018/3/7/621
>
> Signed-off-by: Laura Abbott <labbott@redhat.com>

Thanks for the new version,

Acked-by: Arnd Bergmann <arnd@arndb.de>
