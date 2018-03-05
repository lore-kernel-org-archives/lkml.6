Return-Path: <robin.murphy@arm.com>
X-Google-Smtp-Source: AG47ELt67m6T7zx54cCKo18al5Xu6lcL0HB3gZW6ZkBZsib06lxswgf9/3XlMCP8vRAJCCTetTHt
ARC-Seal: i=1; a=rsa-sha256; t=1520264254; cv=none;
        d=google.com; s=arc-20160816;
        b=M4QHAKOiyHaP/f0CMcOJV+pT+D5+iVZhnbRMWvg4wvqca48h45iK5xu7tt0M0H84Tu
         ptzdPvuxwfrRX5VpE0XleGYwcTbKoHaA0DSLMfB5lXlPgL3s1FFkFFzRi/qJmPkxvsus
         Ib65O8jil4V+13sdFzOV/kGdr1u8NSgXZhstISNMypkQNmcA4f9GOmS6sr3Okb7ZlEDm
         4TkbHO+70RRsrKpbkpWCp2YhOv1hgwtWD+E8Y0BCrCbI0tpaiPDJwbZrEUHgN8wP5SwY
         2eHcnoWvZ3CyLbEb5EsXzAYF1zQduwAUfQzgY135T+ZX/bCi/iAF952aAISfH62jCzoZ
         tCQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=SnrFVKNkFlxgHgNEKo9naTgZwSQyGMdbXAKTD7DXXCs=;
        b=S7iY54azWh+NI9Ao0d1qFa/OzoqegJ76OiTPYUNFDhPzVi5oMvobcu7m1XeBX2edqJ
         ylBLZRRnL8ih+/8rkOF8xuOM7+i2FO0qO5OI0d9kZSxMm0DgW1knMXe013eerMu0EYWR
         aDVa21ZUZ0Lqt7Rgb1dMamU87WOaZaZ1Ta1JMOnGhCXm0HNqKFpiWq5VUUTiWDb1nN6z
         QbcO2b0jf+MeAoXqNyPN7TSPNhE5EvoyQ0yP2jsp8c5oOzrd0hwDYPIW7lMO7SW8JKGG
         4INiri+M+9DkqSwSTY9CBQb3vkiD5atJzFwXWwm/cGv7R52H7CewHMLEv4PKvXVP5OtU
         w0Gw==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of robin.murphy@arm.com designates 217.140.101.70 as permitted sender) smtp.mailfrom=robin.murphy@arm.com
Subject: Re: [PATCH 1/6] Docs: dt: add fsl-mc iommu-parent device-tree binding
To: Nipun Gupta <nipun.gupta@nxp.com>,
 "will.deacon@arm.com" <will.deacon@arm.com>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "catalin.marinas@arm.com" <catalin.marinas@arm.com>
Cc: "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, "hch@lst.de" <hch@lst.de>,
 "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
 "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
 "joro@8bytes.org" <joro@8bytes.org>, Leo Li <leoyang.li@nxp.com>,
 "shawnguo@kernel.org" <shawnguo@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Bharat Bhushan <bharat.bhushan@nxp.com>,
 "stuyoder@gmail.com" <stuyoder@gmail.com>,
 Laurentiu Tudor <laurentiu.tudor@nxp.com>
References: <1520260166-29387-1-git-send-email-nipun.gupta@nxp.com>
 <1520260166-29387-2-git-send-email-nipun.gupta@nxp.com>
 <5cdeded1-ca3c-339a-bf73-73401e7dd4ed@arm.com>
 <HE1PR0401MB24254CBDB8B6F537D08B925DE6DA0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
From: Robin Murphy <robin.murphy@arm.com>
Message-ID: <f382e92a-8ab5-7c93-1f39-fe6797e5c876@arm.com>
Date: Mon, 5 Mar 2018 15:37:29 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <HE1PR0401MB24254CBDB8B6F537D08B925DE6DA0@HE1PR0401MB2425.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594108370915742934?=
X-GMAIL-MSGID: =?utf-8?q?1594112611288106445?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On 05/03/18 15:00, Nipun Gupta wrote:
> 
> 
>> -----Original Message-----
>> From: Robin Murphy [mailto:robin.murphy@arm.com]
>> Sent: Monday, March 05, 2018 20:23
>> To: Nipun Gupta <nipun.gupta@nxp.com>; will.deacon@arm.com;
>> mark.rutland@arm.com; catalin.marinas@arm.com
>> Cc: iommu@lists.linux-foundation.org; robh+dt@kernel.org; hch@lst.de;
>> m.szyprowski@samsung.com; gregkh@linuxfoundation.org; joro@8bytes.org;
>> Leo Li <leoyang.li@nxp.com>; shawnguo@kernel.org; linux-
>> kernel@vger.kernel.org; devicetree@vger.kernel.org; linux-arm-
>> kernel@lists.infradead.org; linuxppc-dev@lists.ozlabs.org; Bharat Bhushan
>> <bharat.bhushan@nxp.com>; stuyoder@gmail.com; Laurentiu Tudor
>> <laurentiu.tudor@nxp.com>
>> Subject: Re: [PATCH 1/6] Docs: dt: add fsl-mc iommu-parent device-tree binding
>>
>> On 05/03/18 14:29, Nipun Gupta wrote:
>>> The existing IOMMU bindings cannot be used to specify the relationship
>>> between fsl-mc devices and IOMMUs. This patch adds a binding for
>>> mapping fsl-mc devices to IOMMUs, using a new iommu-parent property.
>>
>> Given that allowing "msi-parent" for #msi-cells > 1 is merely a
>> backward-compatibility bodge full of hard-coded assumptions, why would
>> we want to knowingly introduce a similarly unpleasant equivalent for
>> IOMMUs? What's wrong with "iommu-map"?
> 
> Hi Robin,
> 
> With 'msi-parent' the property is fixed up to have msi-map. In this case there is
> no fixup required and simple 'iommu-parent' property can be used, with MC bus
> itself providing the stream-id's (in the code execution via FW).
> 
> We can also use the iommu-map property similar to PCI, which will require u-boot
> fixup. But then it leads to little bit complications of u-boot - kernel compatibility.

What needs fixing up? With a stream-map-mask in place to ignore the 
upper Stream ID bits, you just need:

	iommu-map = <0 &smmu 0 0x80>;

to say that the lower bits of the ICID value map directly to the lower 
bits of the Stream ID value - that's the same fixed property of the 
hardware that you're wanting to assume in iommu-parent.

> If you suggest we can re-use the iommu-map property. What is your opinion?

I think it makes a lot more sense to directly use the property which 
already exists, than to introduce a new one to merely assume one 
hard-coded value of the existing one. Extending msi-parent to msi-map 
was a case of "oops, it turns out we need more flexibility here"; for 
the case of iommu-map I can't imagine any justification for saying 
"oops, we need less flexibility here" (saving 9 whole bytes in the DT 
really is irrelevant).

Robin.
