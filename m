Return-Path: <natechancellor@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521223535; cv=none;
        d=google.com; s=arc-20160816;
        b=RIgYjTBROOOJF2Y5thZyg948I/2ogCMiAD4WQw3R+T6eFBdB9XH7fTwXTXEziJZNfv
         ke2tU/8GGB1ChF1BDcHpS50NQZqW94TD0OCnDoN95IY+hRWsQRpPkaY9OqPMtiQR/Fj4
         tG/F5UK/Ra3a2M5Cj+mwULRnKg+irTwlbq6+ZOSw/kj5WN3FZMK9G3HJb8lSWN2b6P1y
         XYdJAm0zefn3ziF3IZlTplldjqRzgNGWqhHtIzYT6ys18KiqBeR3I8aG6ZVGYPkwU0Fi
         emnZLY2ne+2Tg3S3nrHyaLUefh9znT8GSbh8S8raYpAs5iHAKhBe5R0midb63PsJaP4o
         /cZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=Y5HFtuWd0812GwJu+cpIgv74ODdVdpCRaXTsJa7VAEI=;
        b=Xn4o1tbTYh5AD2XZUC2/6xkKbbTjB2YSY+nb3uU5I91O4WBbtiQ5roVn1Nj/mwbJI6
         MOrFbcJgLdrohqB2OZNjVELtBDibsHZqDkszZTZjA6hLI0TsVTD/StF4Vzv/s2wlg+3r
         T/aBb5DLW6IUftx4UR5A7lq3H3qogN/IWN7Cvru0Ncn9IBEGcPl1ssNy1tMNUQnG6mZx
         7FLsRKItev+dQLRqQC/nMugzpzUM/wzHCg7VaCSzCbEizqGsjVPbcWC/K6Kuixl59cAZ
         h3zoUjn91IDOwUS3b6PgsPB5x7AhfnYQb5gMq9okRd+x/h7hng7N2rIstUD1c/AfsRDM
         664w==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JQRvKm2l;
       spf=pass (google.com: domain of natechancellor@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=natechancellor@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=JQRvKm2l;
       spf=pass (google.com: domain of natechancellor@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=natechancellor@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELv3ZvwXLm1Son93WZsretsmZl7UuLPeNmLE76YlgtVKZSVZTuwrLQNTPYOd/RLk+v6cpl2F2Q==
Date: Fri, 16 Mar 2018 11:05:31 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net,
	shuahkh@osg.samsung.com, patches@kernelci.org,
	ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/63] 4.4.122-stable review
Message-ID: <20180316180531.GA18177@flashbox>
References: <20180316152259.964532775@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180316152259.964532775@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595108525093354259?=
X-GMAIL-MSGID: =?utf-8?q?1595118489744858922?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 16, 2018 at 04:22:32PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.122 release.
> There are 63 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 18 15:22:41 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.122-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
>

Merged, compiled, and flashed onto my OnePlus 5 (unfortunately, my Pixel
2 XL is going in for an RMA).

No initial issues noticed in general usage or dmesg.

Thanks!
Nathan
