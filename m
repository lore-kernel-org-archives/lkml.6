Return-Path: <linux@roeck-us.net>
X-Google-Smtp-Source: AB8JxZrpHDSxo3C22ueX2Tp8sk5LeX1ue+O5cV8auteyF5uThB8QHQZZG6a0aAYqFd+CKXRBVBsi
ARC-Seal: i=1; a=rsa-sha256; t=1524502475; cv=none;
        d=google.com; s=arc-20160816;
        b=mLnsIHzOIz44O/DyBvPIg2Y7ClFnoWoVovZllnkkwgLvTlL6Rk0JVJdwz014UEmRSv
         vPzL1rVb1gwja/vX0S7fZBWhdcyDhrb6M/SPJzxb0a/nRxMgGvc0DUuK0dJBhYvTDN+T
         N9XbOteVkJ3fGYNlEe/6ZgR1fLKMDJD5jM6VhnbJO4XMvbU8GLrqyTKipJggEeB3WrsQ
         /E9rzubr6lV6aNb8zJS+jccYWlp1XD5qk7L3xNkFfBlGGSgSacBG/tE0IXaPeOINWxmp
         iiSFvRIsGJZgDFbF7twetA+5mCQ0+ESGOPc+BBhjU6XQtBgrj92nQKbI7bMCoDIssme1
         ztQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=P/UwDon5UwRPx/xxF7ZKPy4QSCUyi0Wc12nVxQux3OY=;
        b=fnpNFAS6kyg9nuAj3XQkTop5Y7vuNoawF1vhNWs6nmV7QzxfEMBOUYm/55lJVXNfNw
         mOq5cTbYCRVVY9hGwMrtZg9dim5kZsPF6e2n3g9LTwgs+nSHJwm2nDD+8dQ8ISGnrhL5
         S1AeMuDxMCRlZj63BaGN8R1Cj9BxDzbw3kbIcJlkYVzYTrzlNcMUvHvHJjOldSbWNzYe
         ICoCz5BpTjhTj/ntmR0j8B9jX8dnKXXE6yRgh7xV3Dmc51lgRdQzPoRmObaE7DvyXQCa
         UtOyGMd644pVPc7r8Vlx+tewrVoF83m3GvuDxH4PusrMC8/RzflN/rK8oexbzYRmkDZB
         HYUA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@roeck-us.net header.s=default header.b=0N40zWNy;
       spf=pass (google.com: domain of linux@roeck-us.net designates 208.91.199.152 as permitted sender) smtp.mailfrom=linux@roeck-us.net
Authentication-Results: mx.google.com;
       dkim=pass header.i=@roeck-us.net header.s=default header.b=0N40zWNy;
       spf=pass (google.com: domain of linux@roeck-us.net designates 208.91.199.152 as permitted sender) smtp.mailfrom=linux@roeck-us.net
Date: Mon, 23 Apr 2018 09:54:34 -0700
From: Guenter Roeck <linux@roeck-us.net>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
	ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4.14 000/164] 4.14.36-stable review
Message-ID: <20180423165434.GD12958@roeck-us.net>
References: <20180422135135.400265110@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180422135135.400265110@linuxfoundation.org>
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
X-GMAIL-THRID: =?utf-8?q?1598455435628222896?=
X-GMAIL-MSGID: =?utf-8?q?1598556707609353618?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Sun, Apr 22, 2018 at 03:51:07PM +0200, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.14.36 release.
> There are 164 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Tue Apr 24 13:51:05 UTC 2018.
> Anything received after that time might be too late.
> 

For v4.14.35-165-g7474ba0:

Build results:
	total: 146 pass: 146 fail: 0
Qemu test results:
	total: 141 pass: 141 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
