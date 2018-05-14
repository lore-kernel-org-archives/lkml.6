Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AB8JxZqSh5HO5EuDY5NxXRZSe3igbWfnCxpA8W3SwtRX3di+b9FssQUXdstoh7BGG1UCNsbMDHqU
ARC-Seal: i=1; a=rsa-sha256; t=1526308895; cv=none;
        d=google.com; s=arc-20160816;
        b=GUfhf7vXhjK5Vh9CvEetQsyJtxfv/F+TYBxF/yzXLvBRVgtJIUPof1h5HUfiPyDskJ
         NbpXhik92a6fc7wiOi++eznOyJ0PvWuiKxeeIhhWjf7b5QSW3FCEPrOtAbWtV1xNEbCW
         YEfeQfgAksxKsZCOlw1rxcDurJe1iF24Y8cmVpgOx36Qrl7JWHq9mj9H5owzbi0OFGPY
         Ud3EcgTo3SWve+QLIlEG21I8K+YZP7AmlG6yV4XFiRtwTDPRfV0stPYu1I6n6Y4WX0z7
         PD/ZfRO4o5qJYHNIxXg7VftnR+NYIyuTI1W0VWsXeeZNEKVXHUbCnLAShvR8ScYPUxis
         r5wg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=l7L7OoGejVNdlz5eMO5IuGlAJxyrsymrdUVjDtW20aY=;
        b=k/dE12mshS8y0bm9zEde+Qzw3JmGDDEZ2Gg0iwv6fweGAQSyLvlEfK3CDbwhHmxwwg
         t1/zyQ3jikk9fBPfoeu0XzudypR3kOA2/XUpx6l7MtaXPmq5wrt93S6MGMjkBTHUkx0f
         grbMgYqaC9Bp2tW85K/CGQcfMwJpPTOIMc/mi+OzJGQHBvveOE3AoV+hcODeRzdX3mtS
         GqzHOqRkxmQlEYjM+fxJkhRiMwIcIMpODM0/pi3JqV/nZF0qd7fS5ZZO8Itq8Oap3RD9
         o+qFvDw4NoK+bZesWZD10Vt3qL3xot001Uvuwe0uBlHkhAew7Dplx/daVtQJ50ZlCSWi
         gIEQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 linux-arm-kernel@lists.infradead.org, Lorenzo.Pieralisi@arm.com,
 hanjun.guo@linaro.org, rjw@rjwysocki.net, Will.Deacon@arm.com,
 Catalin.Marinas@arm.com, gregkh@linuxfoundation.org, Mark.Rutland@arm.com,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 wangxiongfeng2@huawei.com, vkilari@codeaurora.org, ahs3@redhat.com,
 Dietmar.Eggemann@arm.com, Morten.Rasmussen@arm.com, palmer@sifive.com,
 lenb@kernel.org, john.garry@huawei.com, austinwc@codeaurora.org,
 tnowicki@caviumnetworks.com, jhugo@codeaurora.org, ard.biesheuvel@linaro.org
Subject: Re: [PATCH v9 04/12] arm64/acpi: Create arch specific cpu to acpi id
 helper
To: Jeremy Linton <jeremy.linton@arm.com>, linux-acpi@vger.kernel.org
References: <20180511235807.30834-1-jeremy.linton@arm.com>
 <20180511235807.30834-5-jeremy.linton@arm.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <d64175c1-3ab4-8854-e26e-486ada09e308@arm.com>
Date: Mon, 14 May 2018 15:41:28 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180511235807.30834-5-jeremy.linton@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1600214161845271552?=
X-GMAIL-MSGID: =?utf-8?q?1600450876120782291?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 12/05/18 00:57, Jeremy Linton wrote:
> Its helpful to be able to lookup the acpi_processor_id associated
> with a logical cpu. Provide an arm64 helper to do this.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> Tested-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Tested-by: Vijaya Kumar K <vkilari@codeaurora.org>
> Tested-by: Xiongfeng Wang <wangxiongfeng2@huawei.com>
> Tested-by: Tomasz Nowicki <Tomasz.Nowicki@cavium.com>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Acked-by: Sudeep Holla <sudeep.holla@arm.com>

-- 
Regards,
Sudeep
