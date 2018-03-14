Return-Path: <prvs=604e35b7f=Richard.Leitner@skidata.com>
X-Google-Smtp-Source: AG47ELuBm3wQGJfnp+cUaL7v4CwwEgVtcdDcCQX0biMDz8merzjprO80mr9GNbe9oUwN5ZU5T5uX
ARC-Seal: i=1; a=rsa-sha256; t=1521027534; cv=none;
        d=google.com; s=arc-20160816;
        b=KNzIqL+dxEac37ntQuvPxajPmT2+OEUqREsZVDKonnOohQdmCe1q4neHo3hUtE/0uD
         HFDjwu/Rq4xI03tle1Up35y+4BaKWs7XK05M4rHYhnDSVHO1poNoSr2MT5W44TZs8g8z
         9pBZiGM8fg/LphsolZuPNFQrQ8E00oMr8ZEPeu6uB8aPH8XiBI8PL6RkG9blAWxyJce5
         RefKJY9/J2Rv5MUNJQmgAyzp8XpxMCPq1K3sXWL3OEiZIW7h9+RpJANNN6pXA3//u305
         v9rl39h1UxM8iHRdPCmSAEy9fRU6Yh4f9esmYuUuj/xcOZQzSBcOzHyRy8FMS8eo81ck
         tl0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=EoQJ4FcRowyIyo6Q0Tpwmj5ESJOjGbOmoASv1HKQsQM=;
        b=Cn7l+MWKQcE9q1TKXYvR/sySTgVua9dE9jg6YiBESeS6tQhxV5eicikE2UGAw5eYDi
         fZSsEgLgN/F7JoJknlnCY6W2AWmZzaVq+Acom1wox3O43O8A/HL6VxN5aThxCgX1ZH74
         LiNdPBIL7ajxregF3PGnio02rW30HB3MggG8e5afVLgv+Anq9ckdP9zwUuc/o1xvZf8X
         hx4v8geK/TCY5/Vkfo1EmziKc0P340CfGrWeBonNkEIzdcM7Ydy/5iiBiFHVM+4qdR6K
         isaJDYrA/uSdNyL3z3GYGdf0LzXtWAMM2iTiNpdUVy4NcRBR0XR0j96V0TJ0TQ88Z1RY
         ETng==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of prvs=604e35b7f=richard.leitner@skidata.com designates 91.230.2.91 as permitted sender) smtp.mailfrom=prvs=604e35b7f=Richard.Leitner@skidata.com
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of prvs=604e35b7f=richard.leitner@skidata.com designates 91.230.2.91 as permitted sender) smtp.mailfrom=prvs=604e35b7f=Richard.Leitner@skidata.com
X-IronPort-AV: E=Sophos;i="5.47,470,1515452400";
   d="scan'208";a="1327947"
Subject: Re: [PATCH 3/3] usb: host: pci: replace hardcoded renesas PCI IDs
To: Greg KH <gregkh@linuxfoundation.org>, Richard Leitner <dev@g0hl1n.net>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-pci@vger.kernel.org>, <mathias.nyman@intel.com>, <bhelgaas@google.com>
References: <20180314102933.21367-1-dev@g0hl1n.net>
 <20180314102933.21367-4-dev@g0hl1n.net> <20180314104925.GC32615@kroah.com>
From: Richard Leitner <richard.leitner@skidata.com>
Message-ID: <d46c3232-1a45-7e28-9691-de2fcb964ae4@skidata.com>
Date: Wed, 14 Mar 2018 12:38:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180314104925.GC32615@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.111.252]
X-ClientProxiedBy: sdex3srv.skidata.net (192.168.111.81) To
 sdex5srv.skidata.net (192.168.111.83)
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594908630617691660?=
X-GMAIL-MSGID: =?utf-8?q?1594912967636357741?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>


On 03/14/2018 11:49 AM, Greg KH wrote:
> On Wed, Mar 14, 2018 at 11:29:33AM +0100, Richard Leitner wrote:
>> From: Richard Leitner <richard.leitner@skidata.com>
>>
>> Introduce Renesas uPD72020{1,2} PCI device IDs in pci_ids.h and replace
>> the harcoded values with them.
>>
>> Signed-off-by: Richard Leitner <richard.leitner@skidata.com>
>> ---
>>  drivers/usb/host/pci-quirks.c | 6 ++++--
>>  drivers/usb/host/xhci-pci.c   | 4 ++--
>>  include/linux/pci_ids.h       | 2 ++
>>  3 files changed, 8 insertions(+), 4 deletions(-)
>>

> Now this patch was fine :)
> 
> Care to redo this series?

Sure. Will send a v2 soon.

> 
> thanks,
> 
> greg k-h
> 

thank you!

regards;Richard.L
