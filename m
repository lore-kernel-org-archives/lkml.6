Return-Path: <prvs=604e35b7f=Richard.Leitner@skidata.com>
X-Google-Smtp-Source: AG47ELtF/wvdXkm7RJujMndsEsnyLquD9SWsYtRK5t9HNCNenl+sfR1iZVui8QEB6+ZGon0Qc7+J
ARC-Seal: i=1; a=rsa-sha256; t=1521027399; cv=none;
        d=google.com; s=arc-20160816;
        b=dv3GTvC0YXNgIs0wdIA1WRI7YNN/b+K0GsH66tMGqBs+rU6SsjoDAcPbn4WJNyY8vf
         i8P9JmaUyFdt1Cq3UeAoh2byOTFJVe8/4NZ+ipFevob0JkHqo9ZrNRHg/x/mS0j2dR/3
         N1NyVAnDXppYbvTedTLP4Gf7Rj12mLgIxlQeoCkQ4pEi5RbrL01Twg0yH0n6e5OpJZnv
         TTK3f+fvyZ+Ljm0JSy4c0c/MjCqAASVtooSRYKDkqtIwRqPGmgrrqdwRkuANd3hiRhkm
         ZTL2tzFUrJrZdzj7dZw0rGpACnwWjAodcfwgaRMOHa2JhbiPahd6uXR7rb67nuuWHHLk
         rc/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=5fJhY2kqXJqYFALUC9cOXvVkra7AzxibNPGcy1cznWU=;
        b=MpyaulGPzLUX6MitlsPoEhtijoPTXk3WOeTxnvAKj9HD12BJnvCS6b95qZ2g9G6jVQ
         JHOZ0XM0JwhRUYXpgPG5ZdwCtMj6GZn3gxClHkfh+lqAkynsvNFbBQLtkJ8CEHn/UB2l
         PxVQg1agBEslF0afwrPjQ8UpXFVbRmh5WAQrkK+eno71mASPSDv7SQ8s3eFYh2R4TCGM
         Ke4R/iwBgyI+xY9bSC6LpRZOR5DQNolOO2lYFrrRrWrqbJxW7E2f68EOgydSXCnvFQjO
         0RwicNmubONpm99P6rDIpsokYwrkOheiYzrFTputa1rH8PcSzQx1uoK4wzKaL6VlsObe
         ljlQ==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of prvs=604e35b7f=richard.leitner@skidata.com designates 91.230.2.99 as permitted sender) smtp.mailfrom=prvs=604e35b7f=Richard.Leitner@skidata.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of prvs=604e35b7f=richard.leitner@skidata.com designates 91.230.2.99 as permitted sender) smtp.mailfrom=prvs=604e35b7f=Richard.Leitner@skidata.com
X-IronPort-AV: E=Sophos;i="5.47,470,1515452400";
   d="scan'208";a="9210717"
Subject: Re: [PATCH 2/3] usb: host: pci: introduce PCI vendor ID for Netlogic
To: Greg KH <gregkh@linuxfoundation.org>, Richard Leitner <dev@g0hl1n.net>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <mathias.nyman@intel.com>, <bhelgaas@google.com>
References: <20180314102933.21367-1-dev@g0hl1n.net>
 <20180314102933.21367-3-dev@g0hl1n.net> <20180314104849.GB32615@kroah.com>
From: Richard Leitner <richard.leitner@skidata.com>
Message-ID: <d755d623-2bb3-460f-45a0-2be6ab6f47ea@skidata.com>
Date: Wed, 14 Mar 2018 12:36:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314104849.GB32615@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex3srv.skidata.net (192.168.111.81) To
 sdex5srv.skidata.net (192.168.111.83)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594908624828665894?=
X-GMAIL-MSGID: =?utf-8?q?1594912825577911567?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On 03/14/2018 11:48 AM, Greg KH wrote:
> On Wed, Mar 14, 2018 at 11:29:32AM +0100, Richard Leitner wrote:
>> From: Richard Leitner <richard.leitner@skidata.com>
>>
>> Replace the hardcoded PCI vendor ID of Netlogic with a definition in
>> pci_ids.h
> 
> Why?  It's only being used in one file, so it should not be in
> pci_ids.h, right?

It's also used as PCI_VENDOR_NETLOGIC in arch/mips/netlogic/xlp/.

Should this be replaced with PCI_VENDOR_ID_NETLOGIC from pci_ids.h?

> 
> thanks,
> 
> greg k-h
> 

thank you!

regards;Richard.L
