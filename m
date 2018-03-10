Return-Path: <natechancellor@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1520643038; cv=none;
        d=google.com; s=arc-20160816;
        b=leD+5Ukq54LGeVVW+J5eGTzg8F5WsTl517ddxf3jFPq9i++OcE9v2Bt3UoOriowngj
         R4SNn16+oo1r/j8+cuBNbk6bwBGyDWRdpOqEHqZXf+09ZrO/q3ZL5D3xICrUOpAF9gjs
         tZchoQ/EdtvOY2Wm6/qs1aZK5DpXg+SvRcTeZwTLGUX+ylxnYjnrC1z6NNefYvpHQqd/
         HxGvnlV+bTW3bHUpgXaOlUla5mQtnWSqsXsvljCrK53GoiXRXtHwKepHgA4Ilgyf2BTf
         eCTTfWrg6+quoAhKJOep0Fb9oa/feFUAkdtUtnH+oBPWgkzW41lkNzas0tIOKR4RK4S4
         eKLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:dkim-signature
         :arc-authentication-results;
        bh=RSJrUJykVZgP/wXhNfRqEOjnZFkIgoPrYOu7Uzt4qXw=;
        b=Yeqv4ICqqSTLEUKBPwI9k715jeIpSsn7BFQzYXAD13XmKy4FR7jK0BhzxYk0BgOk5b
         oagdJRY89Xo83JF+cE3WuOB5AOPzN2FA7+QWV+lKygNGXjtDTf/ssJ6Roy4Ws25XX/75
         SYm3QxpGoa8Selx6zqITKHJrUSSQus/oUBUWV1eFI1vnmYECAk9I0bbLW2bVv2PZT/9c
         OoS+mHFDYX2vkPJutUtaDpZHY7/DNkuTEPh31bswn/syNMOM45+x9b/4nOzFr888UrGM
         AsCMnl6FmdC91AHNzyYSjTdcq/nr3LX4jE9z5+uTBJHVfxS7yhiX/RmTDOpfahUBniSc
         m4nw==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=kBYRkx87;
       spf=pass (google.com: domain of natechancellor@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=natechancellor@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=kBYRkx87;
       spf=pass (google.com: domain of natechancellor@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=natechancellor@gmail.com;
       dmarc=pass (p=NONE sp=QUARANTINE dis=NONE) header.from=gmail.com
X-Google-Smtp-Source: AG47ELtfrHAWqjH1hmswoK8OT7JTt6hBs2wzgDSlKy2FzqpVjQCL7LHm0jaWF0VAZCBFCtnxIGoGnA==
Date: Fri, 9 Mar 2018 17:50:35 -0700
From: Nathan Chancellor <natechancellor@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
	akpm@linux-foundation.org, linux@roeck-us.net,
	shuahkh@osg.samsung.com, patches@kernelci.org,
	ben.hutchings@codethink.co.uk, lkft-triage@lists.linaro.org,
	stable@vger.kernel.org
Subject: Re: [PATCH 4.4 00/36] 4.4.121-stable review
Message-ID: <20180310005035.GA21196@flashbox>
References: <20180310001807.213987241@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180310001807.213987241@linuxfoundation.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594507896678991964?=
X-GMAIL-MSGID: =?utf-8?q?1594509794823045780?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Mar 09, 2018 at 04:18:16PM -0800, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 4.4.121 release.
> There are 36 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Mon Mar 12 00:17:54 UTC 2018.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.4.121-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-4.4.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h
>

Merged, compiled, and flashed onto my Pixel 2 XL and OnePlus 5.

No merge conflicts and no visible issues in dmesg or general usage.

Thanks!
Nathan
