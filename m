Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AH8x224VAex/V0uBSNHKgoh3O2AtNv9lIBAZeMELyFF/TWLwC/SICPyPEkuB+cSinEeQHZd5mFke
ARC-Seal: i=1; a=rsa-sha256; t=1519245752; cv=none;
        d=google.com; s=arc-20160816;
        b=TR/PxlP4W8s7kt0sNr8YUtWOkPiROC1aPqfGWfiQfHnOC08QTCtUdQu5zITpR93ta+
         wzD1sxGKFLnF04vSv/T8IoeuJCDYZi3nH12Dodcawm4zkuqHHHCehZJlH1Cv2jXOq1IB
         DaI7hSFufWshmWg8xXfeB7wjTaT3Qh19TwuWG4vujX1foNglCiLo4Gd1y7qOLWrUiFDA
         si8sgDDlJ8pFhqUqI62h+5njAaHAzuQWT2xApEvxmc37mCwuVujR2wtzUW7/O18KVgIP
         kmHdzSQQTydTPdm9mqyoxMk1IlChLjXs0lKbJ5Cm+vbPzInjO1oaHQ/Fcp2957GDz6qT
         P5OA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=iG17yVyKd6TgSNgbK7loZitHVjRgpqOJDbyHVyi0hUs=;
        b=wIjcwQGNjcpFZ9hm1lLMGsLzpaOj05zp5VPrhChZ2R80BvfvGV+ctArbW3/09Gq3As
         7EL4L2vZ/U4H8LRgIH9Qr/s96xfcua7GXKt9Mli4TVeWdR8mVKBJ+QLSQRECplnoTpnx
         pH6Z1EmXrSW4vfM1caS0zINEGqFXxENfupLox14XoLHEem4r7YPgXqKQEu812YZuTNtJ
         /omdOHm9x4ivGEzGPRb6Km4lOjw+M7dA32/k/fYntARVx/wnbHVYfojpUcAykfQZkqBM
         0wnVgepeQLwDiBzsz7vqVGJJXPY4Z9ekPGnae84maymuZZ6yC1jKqhasw88CsUtUGOhy
         0dXQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 134.134.136.65 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,375,1515484800";
   d="scan'208";a="205997240"
Subject: Re: [PATCH v2 1/8] [PATCH 1/8] drivers/peci: Add support for PECI bus
 driver core
To: Greg KH <gregkh@linuxfoundation.org>
Cc: joel@jms.id.au, andrew@aj.id.au, arnd@arndb.de, jdelvare@suse.com,
 linux@roeck-us.net, benh@kernel.crashing.org, andrew@lunn.ch,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-2-jae.hyun.yoo@linux.intel.com>
 <20180221175853.GA22320@kroah.com>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <7f152459-a232-e62a-3c34-e995f8c85d63@linux.intel.com>
Date: Wed, 21 Feb 2018 12:42:30 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180221175853.GA22320@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027882449244386?=
X-GMAIL-MSGID: =?utf-8?q?1593044634428688435?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2/21/2018 9:58 AM, Greg KH wrote:
> On Wed, Feb 21, 2018 at 08:15:59AM -0800, Jae Hyun Yoo wrote:
>> This commit adds driver implementation for PECI bus into linux
>> driver framework.
>>
>> Signed-off-by: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
>> ---
> 
> Why is there no other Intel developers willing to review and sign off on
> this patch?  Please get their review first before asking us to do their
> work for them :)
> 
> thanks,
> 
> greg k-h
> 

Hi Greg,

This patch set got our internal review process. Sorry if it's code 
quality is under your expectation but it's the reason why I'm asking you 
to review the code. Could you please share your time to review it?

Thanks a lot,
Jae
