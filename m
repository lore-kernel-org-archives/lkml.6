Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AH8x224oWPGH8PFtBxcPfdL6TNI3mwdU44hp6AypoygeJjVmwQFWH1Z/EVl5njyBLaEX7zMyOdOV
ARC-Seal: i=1; a=rsa-sha256; t=1519245338; cv=none;
        d=google.com; s=arc-20160816;
        b=OAJqW0z1X1nHyZ/zhzs6ZQNdii0ecVdM23T/zhHSACNIkSkEETn60RUGE/emVa8yyR
         SOplGGg+uthVUGaeFWwIE8tssemmto8vQmcu6fI2ceyHZ6Vk0d87tyPcqfJwR3zzqGFq
         BoRZ8JLN9rbObBbAbw76dhoXe53HhPcgavKo3j151actog+Z4HpEbu39wZc1B+IGX5UT
         v3hE6IFKXP02fG4RNXc9+LoTg3BrvB7HvJgQcLNlj9+dYGdZAiU0ez5AygU/XfuT6RhK
         i5eXJSv0RGzC37DIZr7bhfxHE3sqk8S3u0PdlwYbqQi6Dk87XgqaZ/PqCNiI77R0Q+2v
         n3uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=dNDZxezFyoblRh2Kg9qU4mEl2BOT8IccJwbbOQvqjE4=;
        b=fjjswZJP+ZKzQ2Q5lhNWDII7ye+5CubHI0FYSoOBxjyheQr818ip9c1iLP9QgY8ouh
         yCyKNE8JliOfqBv5cceFUmGVB/Gz3Ox+oM00YbLOdxPZFi65c7okFlAYSjm6CHvhbhhJ
         Xc8PYMLtFwNiLe8DHZl/8AEYHTsRTftkoRYSIjiTauZmi5yg6oXa3xG5shQEeM7fciAw
         QgNfQ/bsdzb5XFWWWnTBO4TGwFRRF22Peuk7p9SGoutHOZPozwolea7YLIWQgVbivQwz
         tn0Y8xmMFaR7sAjJ/lDJtC3rMS8//NM1fiyHcviK3tKR0qChJ4lb8ME3Pj1d4qqpRE/7
         djQg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,375,1515484800";
   d="scan'208";a="205995936"
Subject: Re: [PATCH v2 2/8] [PATCH 2/8] Documentations: dt-bindings: Add a
 document of PECI adapter driver for Aspeed AST24xx/25xx SoCs
To: Andrew Lunn <andrew@lunn.ch>
Cc: joel@jms.id.au, andrew@aj.id.au, arnd@arndb.de,
 gregkh@linuxfoundation.org, jdelvare@suse.com, linux@roeck-us.net,
 benh@kernel.crashing.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-hwmon@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 openbmc@lists.ozlabs.org
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-3-jae.hyun.yoo@linux.intel.com>
 <20180221171349.GG29204@lunn.ch>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <4afd2fec-b015-72d4-300e-3dd7696f6ff0@linux.intel.com>
Date: Wed, 21 Feb 2018 12:35:35 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.2
MIME-Version: 1.0
In-Reply-To: <20180221171349.GG29204@lunn.ch>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027883264098537?=
X-GMAIL-MSGID: =?utf-8?q?1593044200647285287?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 2/21/2018 9:13 AM, Andrew Lunn wrote:
> On Wed, Feb 21, 2018 at 08:16:00AM -0800, Jae Hyun Yoo wrote:
>> This commit adds a dt-bindings document of PECI adapter driver for Aspeed
>> AST24xx/25xx SoCs.
> 
> Hi Jae
> 
> It would be good to separate this into two. One binding document for a
> generic adaptor, with a generic PECI bus, and generic client
> devices. List all the properties you expect at the generic level.
> 
> Then have an aspeed specific binding for those properties which are
> specific to the Aspeed adaptor.
> 

That makes sense. I'll add generic PECI bus/adapter/client and Aspeed 
specific documents as separated.

> 	 Andrew
>   
> 

Thanks again for sharing your time to review it. I really appreciate it.

BR,
Jae
