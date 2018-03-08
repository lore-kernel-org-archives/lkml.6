Return-Path: <sudeep.holla@arm.com>
X-Google-Smtp-Source: AG47ELtqdaWrF/Knnwl+qMCE0cRv0JgG6I1J+7r6h0Vootg1MoOw+mGJu5M68hkOEAeIwjuisgJd
ARC-Seal: i=1; a=rsa-sha256; t=1520509699; cv=none;
        d=google.com; s=arc-20160816;
        b=qz9f3Drh/QVE0wuwpiqhUCQbReWh+4ZenHa18eZgpD8UuCfpAVQcGnOFC5tspYgFbK
         VLNskf8nrN8Y/vy5rj9UEPU1YU2tpv9yc4xP1Td2NGXu1Co9rw1AEyW/uR13rFDlvg9n
         NuCvbpgXb3VJbEEjcgmTt9Cib71GGtqM91wC78WCccmMBd9sLInvFlHXpwSri1iCgxFU
         t4dJBrPQVTcDwB5Xz6P35zIC/Nz3DEkCsXhASdHfFoG8x6wb+80EURhxpno2RumN2sR5
         y4MeHSEuzJhOgPwxbl5YPgznxjCyD0XaOrfsdvR1FTpIj3fdOVZYvjbi3oqNAC07bFcu
         ZBxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:to:subject
         :cc:arc-authentication-results;
        bh=l2hwGSdUA3i646QWPoll+ILFofsPmzlFamWWM6jiTWk=;
        b=McAn4OTpddxBQpx/1hMXfAfoq+ZiEKoWjUouHPmIxvZ9OLhZRPT+dSWGnfMhIMTnCl
         0qeoBlUNrSp5wAXzPs82P9BfzW3Wz7CNBbggWXyj98xSDFMR+no+Swhfb4ssCrhvZWJB
         RKJIlDEeoB2MRUq1Ier5CKRhU4nRU2k3usn7Mu7i75C25ZWciEDFUMDf9XDnlNZSpEdR
         NuwdwePsbirSPIS0ZZy5KejYwt1kQYSB1CRxX0tynsdSmtgE10cJ0P8HkzS+hx/UitfY
         Gy/J/zT3wvkPneL8tkGB8JvLFXzi0cmUJvVz5ujReINbs9ECpWzgtw8l7cm6WTJMxVnH
         oNgQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of sudeep.holla@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=sudeep.holla@arm.com
Cc: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "matt@codeblueprint.co.uk" <matt@codeblueprint.co.uk>,
 "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
 "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
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
From: Sudeep Holla <sudeep.holla@arm.com>
Organization: ARM
Message-ID: <f6a416b7-542f-a3c3-538f-8549cf4e96c3@arm.com>
Date: Thu, 8 Mar 2018 11:48:09 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <CY1PR0201MB0764FB23021F5DC694C7F56DB8D80@CY1PR0201MB0764.namprd02.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592948931841332945?=
X-GMAIL-MSGID: =?utf-8?q?1594369978470011030?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



On 07/03/18 22:25, Jolly Shah wrote:
> Hi Sudeep,
> 

[...]

>>> +Examples:
>>> +	firmware {
>>> +		zynqmp_firmware: zynqmp-firmware {
>>> +			compatible = "xlnx,zynqmp-firmware";
>>> +			method = "smc";
>>> +		};
>>> +	};
>>>
>>
>> Do you foresee using SMC/HVC for this firmware even on future platforms?
>> If not, I suggest to keep the protocol part separate from the transport i.e.
>> smc/hvc via ATF. It could be replaced with mailbox or some h/w mechanism in
>> future ?
>>
> 
> We have PSCI and EEMI interfaces exposed to linux from ATF. PSCI is
> an EEMI client. We do not have current plans to switch to mailbox as it
> will require 2 communication channels to PMU as PSCI is through ATF.
> 

OK, but I just saw some bindings that has mailbox interface, honestly
it's getting too confusing with multiple series on the same thing
floating and hence I requested to put it together as one series.
-- 
Regards,
Sudeep
