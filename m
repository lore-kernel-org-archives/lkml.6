Return-Path: <natechancellor@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1525132499; cv=none;
        d=google.com; s=arc-20160816;
        b=RaYOdrzFUs3NSrdQbSvMivDX2NX/Uqt7pYUQy6YMpIufvUXywED0b+Huk+5QyDcOuC
         2/LxyUQPx/jKrg6v/9eXEo+Y0rA/PM7VeIz2wH37GDNQpXmQZ8xnaO3o+QxbgLbEOAG2
         mBD/t1PcJbbHN7suJEXv7j6JFdbJjI5V42fRQGxiL9JavfB5ipg8KWYyEGJ+gPdI2u9C
         nXE/MToRnXyARxr81hr2+Bc1ku18YxxeeBhKm2eUenFBylwLsUItK6+LyK+sm3SyObLc
         TK63lyzklAV+Cvc4DzG5BoBVcQDoDH6EYhFJifrPuAY+AUTjRrwtZ5BTK6P+xtrSk1cc
         sMmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=7E9AmwgoEOfukYORF7abIYqy53zpXse7eGnieEso1Oc=;
        b=lmI8jNxhcyJjIEHP314oNv10SxvJi76M5aoRJSFc5sa+poVFig49jTiOKMu+6Vh7rs
         KD3cfDnnKxzS+zmo9/Tc1jfMktXvQI7RJBrN1bkhjlTcVVC/62+EySmswhxKNXkjrrrb
         yGfhC5uk9YJtcBysDkTNG8vLy/L6hvMujgoASu1qxIwk2skYab9WHKjek2GtDMz/wfFh
         ga9zA2+Wyt8YmpE0Xr9OCb1EwrBfCT7Mvy4cK8hUy7xnb98eV7OYKZ/4n1b8/IaXqjp8
         NCH05Nq19Kr96vwS9tbA6O+q/N2AmjalWl281r1qi7pB6YEzpMQKJEToOo3oyEaNFUTg
         mMkg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=LmYwj+yF;
       spf=pass (google.com: domain of natechancellor@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=natechancellor@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=LmYwj+yF;
       spf=pass (google.com: domain of natechancellor@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=natechancellor@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZpEP2Jnbn5YcQSGUNsnrERVMHWdcjdKdcQxdPpp3w/NdiCOeT2FRIfTFg3kkw+XHo/yLC+ALA==
Date: Mon, 30 Apr 2018 16:55:04 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net, shuah@kernel.org,
	patches@kernelci.org, ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/44] 4.4.131-stable review
Message-ID: <20180430235504.GA4711@flashbox>
References: <20180430190946.093694747@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180430190946.093694747@linuxfoundation.org>
User-Agent: Mutt/1.9.5 (2018-04-13)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1599200407080581115?=
X-GMAIL-MSGID: =?utf-8?q?1599217335291507835?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 30, 2018 at 12:24:11PM -0700, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.131 release.
> There are 44 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed May  2 19:09:34 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.131-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
> 

Merged, compiled, and installed onto my Pixel 2 XL and OnePlus 5.

No build warnings from GCC 4.9.4, GCC 7.3.0, and Clang 5 through 7.

No initial issues in dmesg or general usage.

Thanks!
Nathan
