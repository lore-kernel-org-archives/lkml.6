Return-Path: <cascardo@canonical.com>
X-Google-Smtp-Source: AG47ELuc06rEatJSVCDCLaPzMIxs+2Pr+Fpl9CcKBhntAqnf8bcObl8Xv06fUAap5cg4EaqIGEpM
ARC-Seal: i=1; a=rsa-sha256; t=1521548679; cv=none;
        d=google.com; s=arc-20160816;
        b=NIxrdRPfcCfeTGTBmZoZg4ZUxIBihBbS/X3LnH0GBGa1svJ8Uyv76eKJQ282fnEFRN
         +Thlqak33VtrVfPAgQxAxNClUqSKohhtbWNK/vl+y1EMXayvctHaVWBfJ0JJyDmtshI1
         B/ClrhztA4QPjTP31EyPqcCX6CWqemsYihHfpM5pUx5XScGgzJNgK3GKKagjjAx/j0aj
         lyUQ2FRthgYT0vahIUaYj+KKDu7uRKDZ7oTlsCq9L0LdyuBpdFyUznoi9ySJgMlBEyQw
         L4TmVsI0bqW3vSJD+JUZ5SR18lEWHvltK1gz/GnGwmkyUgkTkTaD+Fai3CUAkhZlmrfx
         8ZBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:arc-authentication-results;
        bh=f8NXM3j9BBKUUtLabhRYhF8wHllSY4PIf8eml0Tz2Y4=;
        b=BuB4uTRulVebZu9yt9Fo1ZUZUw24EbMBjN+u/uCmcfFUCKhB/FBwy9nz7PGEUiChcd
         km566/drtd4tyKL8e7bP9a/R2vbUzILL61QSrauenKXYpqDiFwF8Bv0+siFGekQuBhqg
         cs7BePjRVJMMqyrpmBn/owQBEylQOIcrI0F53n+lbgev4RtXWwqyH3SP9FZNvuNvmFVf
         AsC23l2pxId7LV1gjwGhzxHFcL2l8wGDaHIWiIDXO4ZxvBb5hcml5VZ9AT5R96e5qPjD
         n0SYAMUY+6qW0DAgebKyOPLg3mSBD069xZkpL0PYrPx6sySr5NB4EbQOggY1JRimPv8G
         tU2Q==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of cascardo@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=cascardo@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of cascardo@canonical.com designates 91.189.89.112 as permitted sender) smtp.mailfrom=cascardo@canonical.com;
       dmarc=fail (p=NONE sp=NONE dis=NONE) header.from=canonical.com
Date: Tue, 20 Mar 2018 09:24:29 -0300
From: Thadeu Lima de Souza Cascardo <cascardo@canonical.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net,
	shuahkh@osg.samsung.com, patches@kernelci.org,
	ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4.15 00/52] 4.15.12-stable review
Message-ID: <20180320122428.GA3632@calabresa>
References: <20180319180734.976730813@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180319180734.976730813@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595391957310699281?=
X-GMAIL-MSGID: =?utf-8?q?1595459428567071725?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Mar 19, 2018 at 07:07:58PM +0100, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.15.12 release.
> There are 52 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed Mar 21 18:07:15 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.15.12-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Merged with Ubuntu bionic changes, build successfully on amd64, i386, ppc64el,
arm64, armhf and s390x.

Boot tested on ppc64el virtual machine and amd64 Thinkpad X200.

Cascardo.
