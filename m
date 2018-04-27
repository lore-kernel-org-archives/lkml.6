Return-Path: <xtrymind@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524844852; cv=none;
        d=google.com; s=arc-20160816;
        b=whyqdW87FDf0F/mEOTMPu15bc0RhXnviCbIjDkknO+33gVtQfnAsUju4k7mLgRRYGX
         i1SG2IpDQ8xrdfyMYiq+0Uhn5tX3zAU83CZW8AferUFpKsvMri7gVbDrteouyjpouE2i
         YrjyLpEKgkVrKXliCNlxQ5xsEs4iJrLAFACzI9dYutv0pDVMrzrksNb1Z/tpfEJUWaoY
         PgFWcC9ug1ais1eZBVPyp7vQSuEmYYSV4GB52NjERuK2qhvbi8kb08BTaBCcmlQ4CE6B
         7WnSgtT/qf+yBM/8nskgQjDpXjojwpCFDJ7bfAuPmQG+J0xAi8OEr7n2wZ2m68eKdEQb
         b/7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-language:content-transfer-encoding:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :dkim-signature:arc-authentication-results;
        bh=ZSlbGrL7fpONPqXDNX9SIv1BWA2WnjdiDOD2KZuUtNA=;
        b=GGJgEoC1DfBLUjNtRF8HvNjg0xmcL5nO8bxsnjkAOHt4b6kpM0GRR5w+oDTHO24Mmz
         IAcAXA4dW+JRQPSghCuWAxCc5h4dalLbYDNRAHkdoF3mDviKhz1F4Ze77sUiqy1I0yp3
         ZVTUZDSwcUz9B1n3A3oyZXhPDxQf844Gls14/w7FepVeti/EQrsfd0q+fexaYxxUYp+x
         JjskJGFK8cOjJsRwDZtpue6tw8KEc59Lj76+Co0pG0WDeIyjowclJXLQ2/+BZe47PkM0
         rKNGNnrRnbFb/uDbYh8Oig3khS7qb6FM8kA0b2xAdDCP6dsCtOcHSdmG9JMejLxzj85T
         QSCQ==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lTHElHeC;
       spf=pass (google.com: domain of xtrymind@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=xtrymind@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=lTHElHeC;
       spf=pass (google.com: domain of xtrymind@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=xtrymind@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AB8JxZovJlE4CX6lqcyuAXm+W4LM12nZdHq4sX2MtkoFgz31sa0hC0ZcS47U3i0jVf2UQoIIjuE9tg==
Subject: Re: [PATCH 3.18 00/24] 3.18.107-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
 ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
 stable@vger.kernel.org
References: <20180427135631.584839868@linuxfoundation.org>
From: Dede Dindin Qudsy <xtrymind@gmail.com>
Message-ID: <4b4c131e-5869-a39a-c991-35055c65c35f@gmail.com>
Date: Fri, 27 Apr 2018 23:00:41 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427135631.584839868@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598907995162115578?=
X-GMAIL-MSGID: =?utf-8?q?1598915716159395428?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 27/04/18 20:57, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 3.18.107 release.
> There are 24 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
>
> Responses should be made by Sun Apr 29 13:56:20 UTC 2018.
> Anything received after that time might be too late.
>
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v3.x/stable-review/patch-3.18.107-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-3.18.y
> and the diffstat can be found below.
>
> thanks,
>
> greg k-h

build and tested on rn4, No dmesg regressions.

thanks,
