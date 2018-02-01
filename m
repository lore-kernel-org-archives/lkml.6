Return-Path: <xieyisheng1@huawei.com>
X-Google-Smtp-Source: AH8x226DNXrb65svW6rmLF6iCpLjO6gEQiQJrFYq5dq+e1+XvyHAB9rus/xYVKE+wAjOYp110WK5
ARC-Seal: i=1; a=rsa-sha256; t=1517446759; cv=none;
        d=google.com; s=arc-20160816;
        b=GIk8zkTAkb1eyDFofmDGfk7lSI6v3wANKIuSYGBkXn86PGDwXwt7MwJdEOt1xkoTSe
         8DrZ2VNnFTss7dLdal1R/gdDhbLuCknwcR2DMp7fiRtZft7LjmQZ/I9B4PQbMUF9AC8F
         O9iEJgGeHDa1Xjo70RnpCkR6rHG4f4QFm6u43ziQuyOdqkg8t7QfNQj/y3VS/sDh0cEl
         41WJCxu4CiJM3DUFzTgvUu2ENUfpSsIEfJLmQxTkRXYSq3MJT6ZUbk7JHPwbA6tHDQcv
         KkOkHTg9U8TeY57lIQlTC75/7V/EHT3eHmOCvq/G4ig0frp7efY1aFdiFkDVq/alQNJz
         ns/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:in-reply-to:mime-version:user-agent:date
         :message-id:from:cc:references:to:subject:arc-authentication-results;
        bh=xdYDCubRD8bkQ1c5P3c6BWXnVuCwcwnw2C7Y7ZfYSYs=;
        b=xRp2rAqBTvsSMpHFVivYFziQHvAc10kv+F7ez1ORaskN8pjbqB0pHpyr88oWEGD1wT
         zT+HRyHrZsgv+oahOuYsyFB4FJGhf3AFj17jDbt4GswnmUeKJBQh3XjmD4mmgCfA4HUJ
         tToDIRdpjd7WGvR19yVTks/57oGuJThJDsypyUMLA1ui3jV9LdgIZzH6SK2F8qrgsvmX
         kolAolgNhvmplz2YLlHQMg6mrOLZRl30wk86GG1dBCj+gNbxYdzqNyU5DCv5MjmBTMfb
         luoOC+QPO/ZvGKi92syr+KUBd3AIwx2AkCzarwA2vtTEl3RjtiSuepfD4f7Kt2/WOTka
         yLzg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of xieyisheng1@huawei.com designates 45.249.212.32 as permitted sender) smtp.mailfrom=xieyisheng1@huawei.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of xieyisheng1@huawei.com designates 45.249.212.32 as permitted sender) smtp.mailfrom=xieyisheng1@huawei.com
Subject: Re: [PATCH] staging: android: ion: minor cleanup for ion_page_pool
To: Greg KH <gregkh@linuxfoundation.org>
References: <1517392252-20964-1-git-send-email-xieyisheng1@huawei.com>
 <20180131113229.GA14082@kroah.com>
CC: <devel@driverdev.osuosl.org>, <sumit.semwal@linaro.org>,
	<linux-kernel@vger.kernel.org>
From: Yisheng Xie <xieyisheng1@huawei.com>
Message-ID: <865ec1d8-a37b-2cbc-4397-3a787848c4ec@huawei.com>
Date: Thu, 1 Feb 2018 08:57:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.1.0
MIME-Version: 1.0
In-Reply-To: <20180131113229.GA14082@kroah.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.177.29.40]
X-CFilter-Loop: Reflected
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1591101683669684926?=
X-GMAIL-MSGID: =?utf-8?q?1591158253192698405?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Greg,

On 2018/1/31 19:32, Greg KH wrote:
> On Wed, Jan 31, 2018 at 05:50:52PM +0800, Yisheng Xie wrote:
>> ion_page_pool.c now is used to apply pool APIs for system heap, which do
>> not need do any initial at device_initcall.
>>
>> Meanwhile, this patch also remove some useless include files.
> 
> Please only do one thing per patch, otherwise if one of the different
> things you do has a problem, all of the changes have been reverted.
> 
> Yeah, it's a pain at times, but that's the way kernel development is,
> sorry.

Sorry, I should always remember this.

> 
> Please break this up into two patches and resend.  I will be glad to
> queue them up after the merge window ends when 4.16-rc1 is released.

I will sent the next version ASAP.

Thanks
Yisheng
> 
> thanks,
> 
> greg k-h
> 
> .
> 
