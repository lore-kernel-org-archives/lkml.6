Return-Path: <natechancellor@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1519690117; cv=none;
        d=google.com; s=arc-20160816;
        b=kyF0rikzESFU5IT7F2G+UN9bJp0JxtC50qK4CcSmhXl7LDFsvyW5AEHU4d/3D99xSl
         wsY+8QAVlowVDxZZt4EkDuMY7Rh+ExsC+zO3gpO+KH4OpVKa/2BNN4KbwhNy6zJGQd1T
         q7reDgBqfNSZvPQYAZ3YdX/0a19h3E0o1HNK8uaaXJr1azA/giEAMLAfX/m8011V8AF7
         UDFRbkTls3o5ACTQ28uMpuXjsIf3LkM+4Xg9HhKbmrgHOoVBsOpUjNBAq0S7mOQwL2Li
         z1nlbr0lWFiiIGH6kfSpqnSi1wWruA/aIj2GcjKeFQEd+wMnNHGJ2sxPh6ATB2T/epYl
         8fBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=zFxKWAGWQ14fRZircO6zjMHPm7SOwCixdv3ewbHQ6Sk=;
        b=hueEhGOo/ifezrKakQg9i2ilDrqthra8ZSr+oV8WAx7gUYYU1GKt7c+JnhRF8dXEO0
         8tgwBgR2/siMSbfezw5lJ9gzQzU695rvcGUBbSyrd+ZwHDbFD+K64b5LnuCnjdm5rl9F
         OH16v0/EGE14DZClpNyTRznCbS1q06qyqafinS9lUZGxltFtR4B3qCK8CtWn7TS80C1R
         H//JNqXMu8kDI0/W324trL9wwEojWRNYm2lDxwvBHN+ENBA+0IqR4UAmTw54Pax42GFo
         90P3qPDXZGnD41fhjPCiGl2Gn4cykkyovsF8yXiMOa6fYV7K8EjJkyYU604s8doQJ5/a
         mBCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FQUArkRv;
       spf=pass (google.com: domain of natechancellor@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=natechancellor@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=FQUArkRv;
       spf=pass (google.com: domain of natechancellor@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=natechancellor@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELuR9AidN4cZW7cweDjbdoHz6keDrZXdn69GhhtnlJVddRkfVqg3estZ5gjuwaHov9fa5aVncw==
Date: Mon, 26 Feb 2018 17:08:34 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net,
	shuahkh@osg.samsung.com, patches@kernelci.org,
	ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/22] 4.4.119-stable review
Message-ID: <20180227000834.GA23542@flashbox>
References: <20180226201558.681421374@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180226201558.681421374@linuxfoundation.org>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593496055106924305?=
X-GMAIL-MSGID: =?utf-8?q?1593510584630369530?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Feb 26, 2018 at 09:16:00PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.119 release.
> There are 22 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Feb 28 20:15:48 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.119-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
>

Merged, compiled, and flashed onto my Pixel 2 XL and OnePlus 5.

No immediate issues noticed in dmesg or general usage.

Thanks!
Nathan
