Return-Path: <groeck7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1521297600; cv=none;
        d=google.com; s=arc-20160816;
        b=BY85ZsGz72TRKBgGLZnDTzx/r8L9noSX9ZRGS68aNhCEmHMPXueJ30QWjV067KOQ32
         +vPq7DXyWlEKPDP6X3VnWqnJ7n5MkuCSUe6FoC/AuuW9jFM7kJN1KcnpJuFbt1DK84ID
         4rXqSFOezWolpvc4e2+tFkla/8BFMZ0yCfvC39c9ijPQeGKP/ldBJ47M0neZ2jKzXAr3
         EszLC+noiPxVKQ95+XWpJx9US7VUPRIHFeJQG39GBeaqAEUXO021fC12aIQXjwmM9Sq2
         a+2A9YFrKS5ujIxYrXRDf2afMvorF2dBtSCZJ4fppO4o1w4fdzqzKI+v/1OYhNYxOrHZ
         rp0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:sender
         :dkim-signature:arc-authentication-results;
        bh=5WD1mDQJsTLWG83vktxwskw5Da8OpmVyV5e34mlkicw=;
        b=ieXhad6RifXpeZ+TMIhIz2ummBh5FUA0QRVrUXnctajW4+lyRlVZgXZDiUO+NBOPVt
         pOzpHk+tKNv3kp3+LNg6cyl0bvlKBc2qXN2bwOPTC6/jREEXtxEgMHigsLUUAxa+ReYH
         R3AIjKHfLsgB3an9YF8RF9FgLwN3lpcwnc9KbhdjCgWVJ8QzmqfOt88VGxebCV+A977W
         Bj7ZlsX/KAVZ4zqPiKddFJOnG9bnM7rkXWZAHzhCLZaIrvHeFfuwRsOSLqDvcJjDn73B
         N8zh0mt+A+o9TvB8zUrmHd1RBFvOCpNGUsXaCKMEi2W0Kom5B67x38CsaFKSHZq+tIs+
         JMPA==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZZR83bZB;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=ZZR83bZB;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=groeck7@gmail.com
X-Google-Smtp-Source: AG47ELvEzQmDmUpr5t+8SJs3t0smUwkC2qHhvXPg33AGLa8fieiMaGE/dvsDC6CYUfriM2PFccOeDg==
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 3.18 00/25] 3.18.100-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 shuahkh@osg.samsung.com, patches@kernelci.org,
 ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
 stable@vger.kernel.org
References: <20180316152232.750180431@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <6d1c02f3-e57f-6a5d-1108-515f805d9952@roeck-us.net>
Date: Sat, 17 Mar 2018 07:39:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180316152232.750180431@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1595108276054795320?=
X-GMAIL-MSGID: =?utf-8?q?1595196152585820651?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 03/16/2018 08:22 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.100 release.
> There are 25 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Mar 18 15:22:18 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 137 pass: 137 fail: 0
Qemu test results:
	total: 119 pass: 119 fail: 0

Details are available at http://kerneltests.org/builders.

Guenter
