Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AG47ELv+EcSOOEG9OERRpcC273dfOkujcesk+smnHS8yenphkA27f58fNzilgtC/c4p/oYeRxfTT
ARC-Seal: i=1; a=rsa-sha256; t=1520936175; cv=none;
        d=google.com; s=arc-20160816;
        b=s2aruvN5sY6xLqWfLcNWSaWQzsm6JNSBzD2605ghHpeD000F1mynIuPWPciEW392Qd
         fUqG8kvb1IRLe/loU6f2GWMh5aoxUE5fDU+PWQc1+ebS6QHAHKl+ESv7n1jbAfS5e2Xl
         qGHLu3jqjJCf51poHiflAqiRSKexsb27cwzJX32Q/PuDNHLv6SGxaTD6tzA9S61/L+Cd
         O7ZqeLeCkmkUigD3rXgbr991Uo63kPUXewfA6vS4EJJDtEtmbBDOZwHOncobWhIq9j8y
         2g+hQkcnCExBigNez7WqpNP34420JsqiUc7xCK841xM3H/AB3zgxyble6KtZVtQ+sb8S
         xFww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=w+IFGq5Qq9VIkNT0zycQQUtuXJ4C4l9lVX2xPp6cBrw=;
        b=zXMz+1pAlbVhw5VvX/egOrFf92xFZvKJxW8H5ZjjIcj4yUOR/WmtG4s6IWexoUryFA
         X2TAxzIu2Nug7PLF+lmJTS89TrF4gZgig7H2HovOZzXqSuo8sDUHecyZq2dTa6NakuJa
         Mwsgj30jrkU0APwTXjo9xVPe+G4RWbkQmw/JsXvjDVDDwe8ED4zJ+VLyN9W/LSz6qVIq
         N2a+8mdg+qt4NQmsojmqZfqxTUAv0o2fj2o8qiT/SKTGtZUce4qEoQgltKyQaGv6io2Z
         Zjmha4o9SRuR1aE0trm6bTz665a2G6SLFfjl57pKksnLdSCMOnjLWK9s6WnjbDT04DLP
         iFow==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: Sudeep Holla <sudeep.holla@arm.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
 "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
 "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "ard.biesheuvel@linaro.org" <ard.biesheuvel@linaro.org>,
 "mingo@kernel.org" <mingo@kernel.org>,
 "keescook@chromium.org" <keescook@chromium.org>,
 "dmitry.torokhov@gmail.com" <dmitry.torokhov@gmail.com>,
 Rajan Vaja <RAJANV@xilinx.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH v5 1/4] dt-bindings: firmware: Add bindings for ZynqMP
 firmware
To: Jolly Shah <JOLLYS@xilinx.com>
References: <1519154467-2896-1-git-send-email-jollys@xilinx.com>
 <1519154467-2896-2-git-send-email-jollys@xilinx.com>
 <778329dd-76a7-0151-26d9-30e87e0c888d@arm.com>
 <CY1PR0201MB0764FB23021F5DC694C7F56DB8D80@CY1PR0201MB0764.namprd02.prod.outlook.com>
 <f6a416b7-542f-a3c3-538f-8549cf4e96c3@arm.com>
 <DM2PR0201MB07678A47B5380DC14E6F6126B8D30@DM2PR0201MB0767.namprd02.prod.outlook.com>
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <755770ba-d110-8b2e-3c1f-9b65686dc51f@arm.com>
Date: Tue, 13 Mar 2018 10:16:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <DM2PR0201MB07678A47B5380DC14E6F6126B8D30@DM2PR0201MB0767.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592948931841332945?=
X-GMAIL-MSGID: =?utf-8?q?1594817171084102195?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 12/03/18 23:07, Jolly Shah wrote:
> Hi Sudeep,

>>>> Do you foresee using SMC/HVC for this firmware even on future platforms?
>>>> If not, I suggest to keep the protocol part separate from the transport i.e.
>>>> smc/hvc via ATF. It could be replaced with mailbox or some h/w
>>>> mechanism in future ?
>>>>
>>>
>>> We have PSCI and EEMI interfaces exposed to linux from ATF. PSCI is an
>>> EEMI client. We do not have current plans to switch to mailbox as it
>>> will require 2 communication channels to PMU as PSCI is through ATF.
>>>
>>
>> OK, but I just saw some bindings that has mailbox interface, honestly it's getting
>> too confusing with multiple series on the same thing floating and hence I
>> requested to put it together as one series.
> 
> Mailbox binding is used for power management driver. Mailbox is only
> used for PMU->APU communication. APU->PMU communication is always
> through EEMI firmware interface which is using SMC/HVC.
> 

Ah OK, is it because there's no non-secure mailbox or to avoid races,
all non-secure EEMI is channeled through SMC ?

-- 
Regards,
Sudeep
