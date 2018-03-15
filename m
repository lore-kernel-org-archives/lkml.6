Return-Path: <marc.zyngier@arm.com>
X-Google-Smtp-Source: AG47ELtJRVlpDYTyVj5hAzJtxZUnFTIFy5nixfgQez4+6/e8+iR6eF7Z5bCaaQMrg1JkMfCevA0R
ARC-Seal: i=1; a=rsa-sha256; t=1521110803; cv=none;
        d=google.com; s=arc-20160816;
        b=ZWFnI/cT8YBqqlYxMX8dOmGv7rIr9WRspHkZeKyCVRYaS8BniogDw0BR4VJUTfSqRV
         TWw89NYqaBART5RVMAwu14RkQ+fN4Bt8bUGfyYE7tQ6S1NNFpHIc7RUnI5c2llLJTnvt
         qFANHXXguC007hAiYTEySfza6AzmcyDnfmMc4IVKV/LN5qEpR+QxabYAS9AbINPYQoXL
         8xnFcDbRRfrvwLYOmgmAS8yh4xZpXbU8P/XgzVbOdPvcDsl4F9X7O2blp7AE+3xw2zHV
         CCN+Hsx5eV0Hx/MYlozLO1Rnb9BBeD0M3SVBygaXUmpPhg66RnU3tq7Ibc6YB0TQJyRV
         tdPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:organization:from:references:cc:to
         :subject:arc-authentication-results;
        bh=GTV9URN9PWqNIQI54Ixpbrlrs2FQ+f35wlTpyx8RzME=;
        b=gcoDg2VXdROLfLwgrEjUQgC/7ilo67SEXgz3rGnb+oDVU1QPMxxsQBGblcxx87VQhm
         /+JoTp7+cLSiomyufWCWFjVBJQvOGE0kZ438Z/8PH9sLXupFg8kBt/MfGG7+znW6C2OH
         sPBuCn+pbixtktuGmjceX/T2H7kiy/0DqO5yBOpQcgezLVYLDI/nz2t8IT79O4fQ+/aw
         E1svqyM6oxPe0/+SqVg8NILTI/yC+q+TlXEx7jbmPapdj7VgUulFfVdVKYZK+efOuzkg
         SVe+p1n43CGQpqZglXO4cGbfdtOt+D+GzP5Ck0nD3ISnPTwKFyMYplEV4CxImpMN1lnj
         zwGA==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of marc.zyngier@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=marc.zyngier@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of marc.zyngier@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=marc.zyngier@arm.com
Subject: Re: [patch 0/4] genirq: Clean up license information
To: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>
Cc: Ingo Molnar <mingo@kernel.org>,
 Kate Stewart <kstewart@linuxfoundation.org>,
 Philippe Ombredanne <pombredanne@nexb.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20180314211515.429128440@linutronix.de>
From: Marc Zyngier <marc.zyngier@arm.com>
Organization: ARM Ltd
Message-ID: <ee9d2a70-0d49-2a97-7f4d-33bb950d7855@arm.com>
Date: Thu, 15 Mar 2018 10:46:40 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314211515.429128440@linutronix.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594949825957172254?=
X-GMAIL-MSGID: =?utf-8?q?1595000282101110556?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 14/03/18 21:15, Thomas Gleixner wrote:
> The following patch series cleans up the licensing information in the
> generic irq subsystem.
> 
>   * Replace boiler plate language and sloppy references with SPDX
> 
>   * Add missing SPDX identifiers to files with no license reference
> 
>   * Use the proper tag format
> 
> While at it clean up the top of file comments by removing pointless
> references to the filename itself and condense the information where
> appropriate.

For the series:

Acked-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny...
