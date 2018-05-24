Return-Path: <linux@roeck-us.net>
X-Google-Smtp-Source: AB8JxZoTzbvcZj46bge0aCTGZaY7gGR+aGW+jcESTXR2lZ5VfGOhprs5b1e4V4jTcWSwJDxCG4Ac
ARC-Seal: i=1; a=rsa-sha256; t=1527183174; cv=none;
        d=google.com; s=arc-20160816;
        b=GJFSMdqh4SApbmHDqJrJWexAPj37eu5CwCVFDlIHQ0tyJlhbDF1KQeUfUbj6ygE+He
         ObMBEX3mwEVe4kI9RgN0iF1OTesWmyT2I/cL5FHWDSnUM3ZpQO8OsqUXaRJz4QRMvsAe
         QF2EyuNh4MraWSA9c5lSVZPvwKmYWjy21u44du31MN/lCG4O2NkaZjsNEPn+3m778Dig
         0uymeSH96nSpzh4CAK+OLEnIh1bVPMkkHg0tOUdStHD+FpZasjbND/D+7si83W0NzqMo
         664li/YAqHTtxJMNEdgGXehC0sCJkxjgGSdpm5R4pjO0hucwpwzAeWEZk2Ygm34RqWAt
         ILWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=ahPlumn6arWUZo82WNBsHZLfA2pcj9XsxzehCYmlliA=;
        b=Qe5JYD89TpTSqt6eLxj7St7opkpPVbKDFx3Pe7kffeMPrxN8rrWswCtxstKs/3cfHK
         CSsDLHaQEIIsUSxj/KAjkqYtv59hrjH+Wfm54XHUYGaSHvyYcb7ideQV3O2slFMZTd8N
         QMUC7eWArA2juRbuk27RhuZ2YNthhZSFjyM68BUd38a/BU6m/ptwiBAwTiz7pjGg+hXQ
         ord9dywzyQup2BDhVALax7dCwX2ohamHhwv08Tb4ZNMXCsUdBLdmZ5STZoWpz5ctLLWh
         94LgPx3Rmu0pLjjyJ39bYFy7CYxeRchY30ipgQZtmhAclP2+COhxsA56oiW8jLaAg87Z
         q/pg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@roeck-us.net header.s=default header.b=g6vYQtby;
       spf=pass (google.com: domain of linux@roeck-us.net designates 208.91.199.152 as permitted sender) smtp.mailfrom=linux@roeck-us.net
Authentication-Results: mx.google.com;
       dkim=pass header.i=@roeck-us.net header.s=default header.b=g6vYQtby;
       spf=pass (google.com: domain of linux@roeck-us.net designates 208.91.199.152 as permitted sender) smtp.mailfrom=linux@roeck-us.net
Date: Thu, 24 May 2018 10:32:52 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4.9 00/96] 4.9.103-stable review
Message-ID: <20180524173252.GC11172@roeck-us.net>
References: <20180524093605.602125311@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180524093605.602125311@linuxfoundation.org>
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
X-GMAIL-THRID: =?utf-8?q?1601338380744330487?=
X-GMAIL-MSGID: =?utf-8?q?1601367624467298361?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, May 24, 2018 at 11:37:43AM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.9.103 release.
> There are 96 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sat May 26 09:35:42 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 146 pass: 146 fail: 0
Qemu test results:
	total: 137 pass: 137 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
