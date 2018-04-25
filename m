Return-Path: <linux@roeck-us.net>
X-Google-Smtp-Source: AB8JxZrG5cstlSVvj49LPGB/q2VxVrDbelYYYdGHcjMHFT0Wuz1AVv3ckC1j8U6LoOVPec9GHszS
ARC-Seal: i=1; a=rsa-sha256; t=1524670486; cv=none;
        d=google.com; s=arc-20160816;
        b=id4HO2o2nIpfIr1W2AYN3XKkPFMjJxOdd2wyJ5yVikvp1CPttuMKY4Bf+B6kMDb09Z
         0417FBE26MhIll/6PoPAtzop3UzVMbn8O9y2UejCv4/KrZOgFVbYPE74ZpVaixNsNviF
         0LOEQZpkqJdCY5WWYd1NG4Q+xsOhxH3JIe++K8VVQ8JDSDcIlQ/3apbXXMuD52TSPBLq
         fp+jlHusvH65iyfOGeRGe1wzB392YewUtZBaymBSQMy5FwPEdWnNB0SO9WM0UfbNk6H6
         RP+2pOcVGsXx0G43B+o8S/TGLDhwllU6Bk8+Ff7B0mFVsAY4+nvaHwlOQdrpymMmgCC8
         eDsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=0vWO9mxj55oWy2BkeWW8OjZAi2HiaulnDHuNqBXkV0I=;
        b=CCLGTlPsC4KDbiu8Ei4tvD2MuI5Amh/+t373UvmVIhvAmqHoxx6OEJyVGe8pGnpGvU
         Ee7Wwr7uD2UeKNU7QanS8v1rGlr1/bR/wTuwKwsEW+dcX9NRfGf5/I+4qcrUAszf/YFG
         SQowXKpYUAvF0BiteK488yGIUcVB9SuEoUX1p9Kj6XA/T3VNaY/PRCpHdELoT1qDKvJ7
         qQz7lmGF+/4XOpwB/nDYPq6bnxKYq4FjaXT7/Nw9iLnzOOs2Hct57GMBqMfhE5cYF9AB
         WDL7sjgwg6c2g2UM7D078kvcI/3AqVSOy6tYwKHoDVgszjsnae3b6CANQ16I3BAyyd30
         MaTQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@roeck-us.net header.s=default header.b=a9m+L0ye;
       spf=pass (google.com: domain of linux@roeck-us.net designates 208.91.199.152 as permitted sender) smtp.mailfrom=linux@roeck-us.net
Authentication-Results: mx.google.com;
       dkim=pass header.i=@roeck-us.net header.s=default header.b=a9m+L0ye;
       spf=pass (google.com: domain of linux@roeck-us.net designates 208.91.199.152 as permitted sender) smtp.mailfrom=linux@roeck-us.net
Date: Wed, 25 Apr 2018 08:34:43 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4.16 00/26] 4.16.5-stable review
Message-ID: <20180425153443.GA8850@roeck-us.net>
References: <20180425103314.842517924@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180425103314.842517924@linuxfoundation.org>
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
X-GMAIL-THRID: =?utf-8?q?1598713939951113780?=
X-GMAIL-MSGID: =?utf-8?q?1598732879172162560?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Wed, Apr 25, 2018 at 12:33:09PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.16.5 release.
> There are 26 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri Apr 27 10:33:04 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.16.4-28-gb04d14a:

Build results:
	total: 143 pass: 143 fail: 0
Qemu test results:
	total: 139 pass: 139 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
