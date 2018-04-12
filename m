Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AIpwx49+iTm+OwEbfR0t42AKNyP8mOHEaub5pme3Ur3Dm+T9NYn1GKwn+sYhB1sc59tsAXkONMb3
ARC-Seal: i=1; a=rsa-sha256; t=1523499631; cv=none;
        d=google.com; s=arc-20160816;
        b=AlO0p1A7HgNLYYaEiaQgAJ+sXDP0A8cXTw6yqrV5X1DRmA1WKrcDef27EdroAsADhd
         ryc/vjY/ui1vm7yrLpPgEhuuhCYKjDcy4MuZv0QTTaZ7hftbAxDYd3sMRLXJrbD+Iibz
         +MM5cS3fZQeWoYLYJrVJJDMgiMV9pIZpfIqS9NzEndv9LVFB3tLMJUJA8AR9G9DzvxJ9
         dTExkRgoHLLMVUrqNrIozy0v/J162gyZMD1R/PY4b956qoJZFpT0wQch4F4rpR8iW5/J
         qhOzPlGTHd7LidKDHfRwWUZgILrEitT7aNNEVXIqz2C0yHBCio7Dog6WpFc8fj1uRG5k
         CWnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=UJsoprSML5r80QY+HyZ/ZXBtBl3cV3mhovRcI8sRSMc=;
        b=b0dehU2UcYKLwA03aRV9No1vWqEuFujCzcXyLEdz0WqSR5PbHR/0GUUy2A552bO03U
         /CTkvmTvgDoy06NZ9SJeXC7vl7lewKlTfS9v6WphYuheqhedoeFw0HIkw4da234KpAqa
         id6toR0BhW1mangn6XQuW6TenbzLc9uFVXwP/4UKons3dr2ncMTl+TKwW/1kaiQYU36K
         sUu0WPUq3Jb0sa60CM0UGUGj2KJsvaP0Cb/MXFDq+MhCHhMiPYGpctJp/rPrvFq4/Q2x
         CV9orkgzZp0aGqHVCvkR4jydMNeagbpZFcCsGE1Oprxbqj2RBM4Z9s3qlwKjia+W4sV6
         7Qwg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 134.134.136.126 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,439,1517904000";
   d="scan'208";a="36573332"
Subject: Re: [PATCH v3 05/10] ARM: dts: aspeed: peci: Add PECI node
To: Joel Stanley <joel@jms.id.au>
Cc: Alan Cox <alan@linux.intel.com>, Andrew Jeffery <andrew@aj.id.au>,
 Andrew Lunn <andrew@lunn.ch>, Andy Shevchenko <andriy.shevchenko@intel.com>,
 Arnd Bergmann <arnd@arndb.de>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Fengguang Wu <fengguang.wu@intel.com>, Greg KH <gregkh@linuxfoundation.org>,
 Guenter Roeck <linux@roeck-us.net>, Haiyue Wang
 <haiyue.wang@linux.intel.com>, James Feist <james.feist@linux.intel.com>,
 Jason M Biils <jason.m.bills@linux.intel.com>,
 Jean Delvare <jdelvare@suse.com>, Julia Cartwright <juliac@eso.teric.us>,
 Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
 Milton Miller II <miltonm@us.ibm.com>, Pavel Machek <pavel@ucw.cz>,
 Randy Dunlap <rdunlap@infradead.org>,
 Stef van Os <stef.van.os@prodrive-technologies.com>,
 Sumeet R Pawnikar <sumeet.r.pawnikar@intel.com>,
 Vernon Mauery <vernon.mauery@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linux-doc@vger.kernel.org, devicetree <devicetree@vger.kernel.org>,
 linux-hwmon@vger.kernel.org, Linux ARM
 <linux-arm-kernel@lists.infradead.org>,
 OpenBMC Maillist <openbmc@lists.ozlabs.org>
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-6-jae.hyun.yoo@linux.intel.com>
 <CACPK8Xf7ta43K=POx8J6bAdjvX=wCzy-+HWqHsm+RstQxeetCQ@mail.gmail.com>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <64dae4bb-8049-a09d-d0bb-18f6ec52ea63@linux.intel.com>
Date: Wed, 11 Apr 2018 19:20:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CACPK8Xf7ta43K=POx8J6bAdjvX=wCzy-+HWqHsm+RstQxeetCQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385135685935687?=
X-GMAIL-MSGID: =?utf-8?q?1597505149926244427?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 4/11/2018 4:52 AM, Joel Stanley wrote:
> On 11 April 2018 at 04:02, Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com> wrote:
>> This commit adds PECI bus/adapter node of AST24xx/AST25xx into
>> aspeed-g4 and aspeed-g5.
>>
> 
> The patches to the device trees get merged by the ASPEED maintainer
> (me). Once you have the bindings reviewed you can send the patches to
> me and the linux-aspeed list (I've got a pending patch to maintainers
> that will ensure get_maintainers.pl does the right thing as far as
> email addresses go).
> 
> I'd suggest dropping it from your series and re-sending once the
> bindings and driver are reviewed.
> 
> Cheers,
> 
> Joel
> 

Do you mean that bindings and driver of ASPEED peci adapter driver 
including documents?

Thanks,
-Jae
