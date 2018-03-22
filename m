Return-Path: <groeck7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521736788; cv=none;
        d=google.com; s=arc-20160816;
        b=Gl0B5g8PNvbqPyOgjL7YGPmzm0GzrUpr2ufpqCLVO2XllluXMPNCCe40dE+CcA3SQ9
         QU5apK2KXqPYZhzsABBv1V/cezQM4L45SpjfZIREgH3J3p02dgpKjxF0VTKGc1vyyGHb
         lU8sXeLN2Pk0x6Rt3cNogSVaB8pX4SEXaNdaqOwVv7u87+XpG8B0VsDFmTNDPutE2yk3
         CB7+nZO95OE3k26GcMdQkeAVzwnDXDHz3WK2RTAchTC7Z5VbuOTIjLO3k7tXE/YlPYIf
         /u269KTxwXl89l5BNcxSlLy+RP5TY1z1anIMnz8CIvtGLBF96tzbX6nmuXlK6HoRsp/5
         jFRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:sender:dkim-signature
         :arc-authentication-results;
        bh=h8z9j5g509ih5cZwFFodPeK0+IagImGllMM0BAZQA+Y=;
        b=SFw8nSUYo8/73Nq5T1NSWgO1fFmwc4yLcq+ZGBiJ1E6gVfKzYeb5rPHW4jAdRvBBpC
         CfIWGWMQrIp5jADUYFG1W6bIYwqs3x0ZM6ZSCe7jSyIeIfdChinrSLqiaqzhJ2cwSYJ/
         ZCueEnvwBSa3UldfQSK4PnloqmS5S3R8S5/EMgTXJ0Bu/cvZWXaFp6XIiqzQczwtKEdE
         Fn1Sbi0aFTpYf5MOqZXnXllPB2ya/Gkkmy+APYVmgaFLHVsPGpjqHNUuabWdfSsuzB1w
         234f/cAEJABp73TvJj1wurkS1HJXkQ7979fPnYTwvaa2O0eKewScyFT1iv4Fjdg/QuCk
         jzyA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cf/hSREa;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=cf/hSREa;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
X-Google-Smtp-Source: AG47ELtLhMghSS0AyGvQKuxk5mugXOBM5VJ4pcfoSgtaPCZ2RwX+qDuPArCNwS1emAeXCuThgXSALw==
Sender: Guenter Roeck <groeck7@gmail.com>
Date: Thu, 22 Mar 2018 09:39:47 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuahkh@osg.samsung.com,
	patches@kernelci.org, ben.hutchings@codethink.co.uk,
	lkft-triage@lists.linaro.org, stable@vger.kernel.org
Subject: Re: [PATCH 3.18 00/68] 3.18.101-stable review
Message-ID: <20180322163947.GB31801@roeck-us.net>
References: <20180319171827.899658615@linuxfoundation.org>
 <20180321110405.GD24810@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180321110405.GD24810@kroah.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595390591416246104?=
X-GMAIL-MSGID: =?utf-8?q?1595656675060985157?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Mar 21, 2018 at 12:04:05PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Mar 19, 2018 at 07:05:38PM +0100, Greg Kroah-Hartman wrote:
> > This is the start of the stable review cycle for the 3.18.101 release.
> > There are 68 patches in this series, all will be posted as a response
> > to this one.  If anyone has any issues with these being applied, please
> > let me know.
> > 
> > Responses should be made by Wed Mar 21 17:17:59 UTC 2018.
> > Anything received after that time might be too late.
> > 
> > The whole patch series can be found in one patch at:
> > 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.101-rc1.gz
> > or in the git tree and branch at:
> > 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> > and the diffstat can be found below.
> 
> -rc2 is out to fix a build problem with -rc1:
>  	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.101-rc2.gz
> 

Final verdict:

Build results:
	total: 136 pass: 136 fail: 0
Qemu test results:
	total: 119 pass: 119 fail: 0

Guenter
