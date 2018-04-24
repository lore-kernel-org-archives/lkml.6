Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AIpwx4/P/ntmj40NEpayai9v4epTl5TIZQWm7OkFroxqTw58NanZuKY98wGd+Jq1vh9ZUWT+Cqck
ARC-Seal: i=1; a=rsa-sha256; t=1524587389; cv=none;
        d=google.com; s=arc-20160816;
        b=D62+fnaL/qgj40umCKMc2KtSr15c9zCqZEafy7m5DZUZFzB4qKFkrL2AwGHtrC5bFj
         LFW8ubt/HO0Bp0jimGO+4U2YcYJ/amZ8eoYUXHxkiHYAwCaKEsNCgEfHjJmpxSEN3c1g
         APZ0q6t3B8Q4Has5jLzDiNEd0h4Y3c7xaMISKdp8p+x3cvpgDmnIoCJ1uBkkINXhlqPW
         IOG26xAwAacZuGgOpei8s4L0Lsvoyz2c0RpFFn3G/2qHppOtaA6DHYVf3aIk+J4wxYDn
         vKA76SzAIeJfYfNddl5v1zWZbBYmNZYr1waJ5BLgU59tRpX6TnwbBUXp69+Oj4YSWqCI
         iGxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=RLTo2clS5dJyYqiL8R2zhdOzUuS/2iRnCWOBpkYZsP8=;
        b=knFlsZW4FreBbmSju6klnnlu+F8iEtFu58ddHqbjHmbWuvfFfnsxjM9AJfA+qQo3Qv
         VK8V6tE9gLSewiKTMIvcKzKajCSv3Wzp2QE62BvBO1B+nJezrDc0FgWZm19jNZXM6M13
         +wX0f7cklXG848Ab3ribTMyfMvpujiIFvbuqTUltX8zKwOqGkGB4SL+WJ/LnFcbbBv8a
         bPxxIG3gfoXKiyouROafdZxxFpnNUsxd50kmJs+d6a8RfcmEyFbZNKLrDY2wZsi5QwNN
         0Wrh8lEgjRqFqcxeWtJv3wBr25f7sV4vkVAjhC14hMEbFLP/3sIs+hZIlomQIINq8F+b
         3YBw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.43 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,323,1520924400";
   d="scan'208";a="53285782"
Subject: Re: [PATCH v3 03/10] drivers/peci: Add support for PECI bus driver
 core
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Alan Cox <alan@linux.intel.com>, Andrew Jeffery <andrew@aj.id.au>,
 Andrew Lunn <andrew@lunn.ch>, Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Fengguang Wu <fengguang.wu@intel.com>, Greg KH <gregkh@linuxfoundation.org>,
 Guenter Roeck <linux@roeck-us.net>, Haiyue Wang
 <haiyue.wang@linux.intel.com>, James Feist <james.feist@linux.intel.com>,
 Jason M Biils <jason.m.bills@linux.intel.com>,
 Jean Delvare <jdelvare@suse.com>, Joel Stanley <joel@jms.id.au>,
 Julia Cartwright <juliac@eso.teric.us>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Milton Miller II <miltonm@us.ibm.com>, Pavel Machek <pavel@ucw.cz>,
 Randy Dunlap <rdunlap@infradead.org>,
 Stef van Os <stef.van.os@prodrive-technologies.com>,
 Sumeet R Pawnikar <sumeet.r.pawnikar@intel.com>,
 Vernon Mauery <vernon.mauery@linux.intel.com>
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-4-jae.hyun.yoo@linux.intel.com>
 <1524585717.21176.504.camel@linux.intel.com>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <af70513f-a827-9aaa-1acf-629ae1692d7c@linux.intel.com>
Date: Tue, 24 Apr 2018 09:29:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <1524585717.21176.504.camel@linux.intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385135111000345?=
X-GMAIL-MSGID: =?utf-8?q?1598645746542702626?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/24/2018 9:01 AM, Andy Shevchenko wrote:
> On Tue, 2018-04-10 at 11:32 -0700, Jae Hyun Yoo wrote:
>> This commit adds driver implementation for PECI bus core into linux
>> driver framework.
>>
> 
> All comments you got for patch 6 are applicable here.
> 
> And perhaps in the rest of the series.
> 
> The rule of thumb: when you get even single comment in a certain place,
> re-check _entire_ series for the same / similar patterns!
> 

Thanks for your advice. I'll keep that in mind.

Jae
