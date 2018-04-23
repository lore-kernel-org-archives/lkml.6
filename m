Return-Path: <linux@roeck-us.net>
X-Google-Smtp-Source: AIpwx4+ixA/XcL00+l+45LgvySOAMoT/ttk7pTBlRgeJPnR/IaDUc+OIw+/CVqr2abTrtcttezFg
ARC-Seal: i=1; a=rsa-sha256; t=1524502428; cv=none;
        d=google.com; s=arc-20160816;
        b=qBTiiXHAaNLXEfQd/EAEWxHFR0p04y5UC9U7ES5d61q8FrqAXqWVTHzsa5saynzvVD
         NVplF1zEA5O6oKQYR/lp1CBPxfKkGleHqNpCJv0skqnNZ3HB9CVcHWUqClWUeDfDsp/w
         vrOgBjS11tIAWvfAigrSRAK33c4v1dqv9It04NozfeToOZNsQF9VGwbSgDFdMEkdnFxp
         BZ5AshOREi7Y9t09e22wQV0kbNvSUcmRxbtzEeswCshWEewbi13Lu5DaM2nL+9ZHuUdQ
         qj0GdFdLKKa4O+bhWa9Hm8ZsbYMLIrkIcumhl3ZJJXlxaIIxLy+aAuLc8uMXIHzZAyvW
         qSBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=1d5dznWd54Vra+ZAEbiXdSwY/LgIuTi/DY1///xNTtE=;
        b=bXhWuaoF6bDK3D0+vKbGipd0VwUcqo4DIhlMQtmpQMGIfo6uTc+V6elXcaO/orNjIJ
         bAEQldDVHtxRXYVjPoTTMp2q8aFzjp8rpiaCI66bVbblnwr3Y5+ExmsyU9rnMdZaxWD0
         i/vuHInMLjMZLaKudFqt1w/mjJnxcfFU4IDdCQLegyzmvu0ftWmgbPKsBwMJjFejgKZB
         M1dWPYC8Dhr9g4lmKOWSeGpDpwZLMkZR2dunEUTtOqR6MAOneLOX99EaGySVD7JiGdyE
         GxT++RLn4r613HY9/K/NGxYDkbn2puJ7tEh4tSLlGZ/wNGloGZ2KbFc/zLajnyD5Mez3
         I1Bw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@roeck-us.net header.s=default header.b=hLS+VArW;
       spf=pass (google.com: domain of linux@roeck-us.net designates 208.91.199.152 as permitted sender) smtp.mailfrom=linux@roeck-us.net
Authentication-Results: mx.google.com;
       dkim=pass header.i=@roeck-us.net header.s=default header.b=hLS+VArW;
       spf=pass (google.com: domain of linux@roeck-us.net designates 208.91.199.152 as permitted sender) smtp.mailfrom=linux@roeck-us.net
Date: Mon, 23 Apr 2018 09:53:46 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/95] 4.9.96-stable review
Message-ID: <20180423165346.GC12958@roeck-us.net>
References: <20180422135210.432103639@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180422135210.432103639@linuxfoundation.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linuxfoundation.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598455883527705799?=
X-GMAIL-MSGID: =?utf-8?q?1598556658514329740?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 22, 2018 at 03:52:29PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.96 release.
> There are 95 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Apr 24 13:51:53 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.9.95-96-g54c571b:

Build results:
	total: 146 pass: 146 fail: 0
Qemu test results:
	total: 137 pass: 137 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
