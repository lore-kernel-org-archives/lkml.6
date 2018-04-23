Return-Path: <jean-philippe.brucker@arm.com>
X-Google-Smtp-Source: AIpwx49oyp8X1x/ZS5F9YzWVV+noI1Err+n14BRBYMEGM5NWkcq9IdAAeigkSas27yh9zUbOHNm2
ARC-Seal: i=1; a=rsa-sha256; t=1524498614; cv=none;
        d=google.com; s=arc-20160816;
        b=juiOUDDWZVmLYXCQUHjlM0uG2yLtxiOW9Pleoayd4fvGXqoa6O/AswuO5lYd6VDMq1
         croBTVn4cW+3BsTfSPKV56TWb5YuZ+OkrDAzK/HGb51+Q/oDfsh/aeUbuc2erLjXK6BY
         ixkGdsslRtbjYb9Hbjkg4J6sLk6dibGp1QLnyvynV+Q9HZFuhpC62BqbMNd/8/j4lhRR
         PIeK22hOgKOzUa0SHAuqp/nX8Sobq9wlWbyra8Mo3ytGwUGZWT+qo7JUbpg0y3EkNTU0
         L36hC1dQAxlF31SBqB+eOtVeqlV3yKp2wMUl19ah9AriN4eeIV5zbp5wfIl27h+PhiWV
         OtNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=pEyvbLrNjqgowZG54nqWjDKaD3Vhekz7LTdV7+gvf2A=;
        b=S4gSOUJpVsZW0x7rWNlrte+GIt/vaJi97bvoJA6c709gsBMduTnxo7nVDzPEEQfD2h
         ToX9Ca1K/WokrUnY98KsvrauYSyeCKhgqwQe74BLqcnaR18P9Elr/FVYsqYM3xpqOqS2
         lJwKKzXjxVL9XQzp3LzjwB7e3y6EEXNcHNBLKpQVS7mpVRGwNRkWogVDU5mRbwtaKyaB
         cZ6qEzpvlynEBoLAeu15BzDZXSF9u/hBKdmfKULZJvZIRSnqaIcL9MB6qZJqRvAt94/l
         wRoowHAz5s8WJV6YoE79n21/xxMrtu81uV6UGZnJ1ovQjY8wASg7SVOIOo2Sd9kzTeQH
         OQDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of jean-philippe.brucker@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jean-philippe.brucker@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of jean-philippe.brucker@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=jean-philippe.brucker@arm.com
Subject: Re: [PATCH v4 13/22] iommu: introduce page response function
To: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 LKML <linux-kernel@vger.kernel.org>, Joerg Roedel <joro@8bytes.org>,
 David Woodhouse <dwmw2@infradead.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Alex Williamson <alex.williamson@redhat.com>,
 Rafael Wysocki <rafael.j.wysocki@intel.com>, "Liu, Yi L"
 <yi.l.liu@intel.com>, "Tian, Kevin" <kevin.tian@intel.com>,
 Raj Ashok <ashok.raj@intel.com>, Christoph Hellwig <hch@infradead.org>,
 Lu Baolu <baolu.lu@linux.intel.com>
References: <1523915351-54415-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1523915351-54415-14-git-send-email-jacob.jun.pan@linux.intel.com>
 <AM4PR0802MB23698019B80CCE6B083D1448A3890@AM4PR0802MB2369.eurprd08.prod.outlook.com>
 <20180423051649.63f0febd@jacob-builder>
From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Message-ID: <051f977b-b274-d94b-61f7-dece19770624@arm.com>
Date: Mon, 23 Apr 2018 16:50:07 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20180423051649.63f0febd@jacob-builder>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1597940910346286875?=
X-GMAIL-MSGID: =?utf-8?q?1598552659409449949?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 23/04/18 13:16, Jacob Pan wrote:
> I shall drop these, only put in here to match your patch. i am looking
> into converting vt-d svm prq to your queued fault patch. I think it will
> give both functional and performance benefit.

Thanks, I just rebased my patches onto this series and am hoping to
re-send the IOMMU part early next month.

Jean
