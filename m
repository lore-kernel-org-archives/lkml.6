Return-Path: <jae.hyun.yoo@linux.intel.com>
X-Google-Smtp-Source: AG47ELsVPv6lTdOVsgA28qwBQv/kH2CXjkV0zSgYQTN69DG9JOvhRbwwd7u2zJbciIzcHZu0JDwu
ARC-Seal: i=1; a=rsa-sha256; t=1520370497; cv=none;
        d=google.com; s=arc-20160816;
        b=FjKOK8Y9EvEQp+e4ll43Ais7W03kAjms/R1UpFjLb7sw13QTwfgXAjR4bQmWT5rbfr
         jtrtX9oWc4QxM5223IfUNOhi7DJPbvlJXuyfsZaGucMTCmtKjFXvmxzBSCTaqBExGtpl
         vAuxNHm8gnkcrG2Qkf91zNSFQaEb5ErJAicrPTuKxBurFZSN42CaCf269SG3FpBpwpgY
         LDJNv9budG/0y70zKnRT9F69WGNsXUQeMRPTTg/a/DInoZF5zf7+3MRWDrk7IyJjdnr2
         KI6cJSyzNhKHUvrzMXpm47p8gAfX/EjTassv/H0joXoLQbt+Y83nKL5+1XeSG14B3wTS
         ITdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=SJ92i6wTqxbJ0gWyciIdqHo0MVEaDviVBcSDEXuL4cU=;
        b=lSE6fEgha24LgyhWFMNC+uMARZ3LUAc8KAwYohi5LFk/VsicPlQf4cwULnzCUhLlRN
         Anng7iCvUBqfEwwkoL5Z6Dv+Jy1Z0gicZgmUISTUC/BtGaY2md9So5HXAjRYy7FlXKNi
         OAF73ae+L8NSoPQ7AGIeeNk8uLF/6WUtN73nIF/LzSe4yexvFEHpRWjv3hHDTbLGyFn6
         QeHjW5XweVcUU7f1YTk3krjuNm2Wy2u+yuXPCHp1SlZRXdi0OPH8xWVvrvdBQy/QC3Ai
         3J3ZwLyXqICIHxnsYbXtt82GtDZnazI/Ft2mfM6Dp/9WEC8MON6MNrCBw2FaFCAEj405
         DB9w==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: best guess record for domain of jae.hyun.yoo@linux.intel.com designates 192.55.52.151 as permitted sender) smtp.mailfrom=jae.hyun.yoo@linux.intel.com
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,433,1515484800";
   d="scan'208";a="206015644"
Subject: Re: [PATCH v2 6/8] [PATCH 6/8] Documentation: hwmon: Add a document
 for PECI hwmon client driver
To: Randy Dunlap <rdunlap@infradead.org>, joel@jms.id.au, andrew@aj.id.au,
 arnd@arndb.de, gregkh@linuxfoundation.org, jdelvare@suse.com,
 linux@roeck-us.net, benh@kernel.crashing.org, andrew@lunn.ch
Cc: linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-hwmon@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
References: <20180221161606.32247-1-jae.hyun.yoo@linux.intel.com>
 <20180221161606.32247-7-jae.hyun.yoo@linux.intel.com>
 <0e3750a0-d45b-368d-f5cb-d2cca6797ecb@infradead.org>
From: Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>
Message-ID: <27a5a530-6083-89fb-3258-bc29fb71d30f@linux.intel.com>
Date: Tue, 6 Mar 2018 13:08:16 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <0e3750a0-d45b-368d-f5cb-d2cca6797ecb@infradead.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1593027890051239231?=
X-GMAIL-MSGID: =?utf-8?q?1594224015176464346?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Randy,

On 3/6/2018 12:28 PM, Randy Dunlap wrote:
> Hi,
> 
> On 02/21/2018 08:16 AM, Jae Hyun Yoo wrote:
> 
>> +temp<n>_label		Provides DDR DIMM temperature if this label indicates
>> +			'DIMM #'.
>> +temp<n>_input		Provides current temperature of the DDR DIMM.
>> +
>> +Note:
>> +	DIMM temperature group will be appeared when the client CPU's BIOS
> 
> 	                       will appear when
> 

I'll fix this description as you suggested. Thanks a lot!

Jae

>> +	completes memory training and testing.
>>
> 
> 
