Return-Path: <groeck7@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1524925537; cv=none;
        d=google.com; s=arc-20160816;
        b=iSFW7J72UPtxy0UA1TzOLsipqSaSekgwB/u9aoQtMQg6pZFrircgEVBhR25Vb38Whh
         4hZPq6Q366sm8uxUtpPDhEePEBnChRpLM6LUDp1/4JkoJyf0noRJSpqBfvtDBaHBd4gE
         negguXMKM24ywrINcB9UXdQlzymrCczlGJk6o6kZ2tjI7t1qpvZMWNyUdaxk5Vb2r9xt
         Lt7rMsGiuz5Iu/2Nup70RPxNHMDhyr2VVKYGvRU8dMfPnReRKBRaDQz1vFWPoJyhPwxQ
         caYMMZF3ya2UjqmUwMSZ7y57epiOXCp1+hmp2wI25QUokXJjoLSn/bdGKPG/HrDYLcB6
         l1Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:sender
         :dkim-signature:arc-authentication-results;
        bh=7YMLDBZ8WcDLZ9ARO19xCHQ3JswOJYVN50Sl2rUrHqU=;
        b=0bJg9CvYT3Htu/i7RxJjieTHPMeMciqygSRwUbrCsoEfzRpr/7entIWAMlLOL27zzB
         EezYmEzfHqlHRj46mtlfmZV+XKh2IpKwJVFbcCU666csDLYC7FOpqrB7ZDTi9PPU5ekb
         DYPTeJi90x3fNEILS4UzkTYuth6j2zgOHw2dumKpNbbD7016If8Qt86QC8XEPQRv79II
         mQ4MYN70ODnWTuZbch6E8wK62WtumD6tbwb522TSlFRxw8udjA30FJR4VkpxuSSNfkgk
         bIkRfnasMzryytxbj5+Ss4fUVjm+WjH2E0ViG3yuk8AQpW9+jxx6RFPFKhBvhXhx+v2b
         Dgxg==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vS8/DzQm;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=groeck7@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=vS8/DzQm;
       spf=pass (google.com: domain of groeck7@gmail.com designates 209.85.220.41 as permitted sender) smtp.mailfrom=groeck7@gmail.com
X-Google-Smtp-Source: AB8JxZrIcFwwfyHmicF02/Vwv5yNlNT/cKYa7yN83yqY5DZlFoOhD2jzaVLL8dXzM1YiYonMJsVf7A==
Sender: Guenter Roeck <groeck7@gmail.com>
Subject: Re: [PATCH 4.4 00/50] 4.4.130-stable review
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org
Cc: torvalds@linux-foundation.org, akpm@linux-foundation.org,
 shuah@kernel.org, patches@kernelci.org, ben.hutchings@codethink.co.uk,
 lkft-triage@lists.linaro.org, stable@vger.kernel.org
References: <20180427135655.623669681@linuxfoundation.org>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <837717a7-2e33-ce3a-f6d3-eaae65fd0cf0@roeck-us.net>
Date: Sat, 28 Apr 2018 07:25:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180427135655.623669681@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1598908162748669149?=
X-GMAIL-MSGID: =?utf-8?q?1599000320219945108?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 04/27/2018 06:58 AM, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.130 release.
> There are 50 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Sun Apr 29 13:56:42 UTC 2018.
> Anything received after that time might be too late.
> 

Build results:
	total: 146 pass: 146 fail: 0
Qemu test results:
	total: 127 pass: 127 fail: 0

Details are available at http://kerneltests.org/builders/.

Guenter
