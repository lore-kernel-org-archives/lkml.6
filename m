Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AIpwx4++xxUGp3jsLxKY8Le3gcaGEIxeY+E8KtDthOWJorPl+J0GlEUVNjRVzZpU9MkOjrAmuel+
ARC-Seal: i=1; a=rsa-sha256; t=1523989275; cv=none;
        d=google.com; s=arc-20160816;
        b=kWeQ2sAOj1P9A+y+eJ5zInEMeZohtTzDOsLy3NXt4VYm5ZXYOa7AI7zPA4rZpTNDdR
         U/VO3Bc6a9zlh4KzAApfcbnmpCprns7HUmAiyGz3ye0t0tJcx0h5PHr8bmrJNBS45lg9
         tkQ0QgMANCcIH9H/g6pzJrKcRBIw+0g6ZOln7l6DMJwI2mANp1Ncpd0ntHYU7PZ28dWG
         hqk09TvlcI5UmBjJR/q/iQXkGOvjPUfwNadKRTn6u6ydIVtvhRWGaesf9j3+fvpCO3X3
         GLYXANP/TvIDlYWMGLFyOrHD3YgT3tSVSKDAbChJVghcEYnHPo74OUh7MKW4ofaLYaS2
         +CIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=GUA7O6E4X4Dn1F6xlI35nNbsDr5eGe2UWq9W8ijkkn4=;
        b=MgZyyvZS+wajGFUsUrxH3+9u/IPV5wS8R/z+BwRwLwSkUbuzfDWctIknl+nv+H2pvD
         opPWokGkloMUB1IcJZ/Z0PtdLFvAkApRBHjOatQQmj8/zowE3S2gmEaDH6JJmLBXXbHe
         EcJ2nHfyJP8QV17MzaQctFyj+2bc5T6Ee27z4TS5fwMIm5B0j1GnijkyfRgjCVzMW2U3
         z8cGSD+t7y4LL+Kj2OH69cqBGZsrbndYt7RqpgV2gyaPaObZhhM0Qh5iyRSivKxXO5Ba
         Ylge5fcFnbhTM+yQkeBkXBjy5zd7FGc8SIlOGDXeVN6ldSIRSePey1DW8Wj6k1oOSTeL
         Yoqg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 134.134.136.31 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,464,1517904000";
   d="scan'208";a="192236637"
Subject: Re: [PATCH v3 06/10] drivers/peci: Add a PECI adapter driver for
 Aspeed AST24xx/AST25xx
To: Robin Murphy <robin.murphy@arm.com>, Alan Cox <alan@linux.intel.com>,
 Andrew Jeffery <andrew@aj.id.au>, Andrew Lunn <andrew@lunn.ch>,
 Andy Shevchenko <andriy.shevchenko@intel.com>, Arnd Bergmann
 <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
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
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, openbmc@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20180410183212.16787-1-jae.hyun.yoo@linux.intel.com>
 <20180410183212.16787-7-jae.hyun.yoo@linux.intel.com>
 <93e7f93c-a2e4-1e16-be4c-b908f88b9897@arm.com>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <684d1e9e-b07d-ef79-4333-e47d11326e7f@linux.intel.com>
Date: Tue, 17 Apr 2018 11:21:13 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <93e7f93c-a2e4-1e16-be4c-b908f88b9897@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597385137876997151?=
X-GMAIL-MSGID: =?utf-8?q?1598018577692460198?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Robin,

On 4/17/2018 6:37 AM, Robin Murphy wrote:
> Just a drive-by nit:
> 
> On 10/04/18 19:32, Jae Hyun Yoo wrote:
> [...]
>> +#define PECI_CTRL_SAMPLING_MASK     GENMASK(19, 16)
>> +#define PECI_CTRL_SAMPLING(x)       (((x) << 16) & 
>> PECI_CTRL_SAMPLING_MASK)
>> +#define PECI_CTRL_SAMPLING_GET(x)   (((x) & PECI_CTRL_SAMPLING_MASK) 
>> >> 16)
> 
> FWIW, <linux/bitfield.h> already provides functionality like this, so it 
> might be worth taking a look at FIELD_{GET,PREP}() to save all these 
> local definitions.
> 
> Robin.

Yes, that looks better. Thanks a lot for your pointing it out.

Jae
