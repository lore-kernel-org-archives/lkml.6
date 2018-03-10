Return-Path: <christophe.leroy@c-s.fr>
X-Google-Smtp-Source: AG47ELs/og9lsKMhPoT+uOqVZBDUzg0uUQ5DaEQZWZcBPCwROVqPeR/9678UZu5dERel/D4W6RPJ
ARC-Seal: i=1; a=rsa-sha256; t=1520666881; cv=none;
        d=google.com; s=arc-20160816;
        b=YcPr/p0msjzbAHnPzJrEnTQeHwzXUcU9pcZA3j+xisl7jXiEIspZ6D1J4rQec38sma
         FKbwjktbPAINSw9fkw2KAoCro9GgjaQnqj8GFBNnwr1zHEB3cz74Tof+g/KWgyIJ6SBl
         D0PndwcHiYJPpDb51vgn2L1XV2RHRJJB0P9n2IGvlG2+dxE3BVcy6c6E6C98TBnyAarY
         CGSQRlMveXxuT4HoVKGWkAZxciWbo2VCZCBc785PfJnuUXxqXEwndNUpjpqhRKv+DWah
         UVCYyq7OQuQg58/BnM0xgV7wfCqw7BtJCdqZ2BomN0XXNlltTI3BLGIJHN7f9xbjLhVv
         GwLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :arc-authentication-results;
        bh=Wm6j2m0/QDf1Ha7CLOtq/Tm1JBhFcrcpByNQENezbsg=;
        b=g9gdkaeMGoqxCz0Pma8Oc5osmTH2hw0M8n2B6mRyz8/XkNuEfKmsqNLT3Qp/6/nHmW
         9O9fN6UymjF2P6CHzIWDdeFy7DWPjy0O5IPTsJ9/vwyrJ6D6vm/5HzbjMfFZVfb4nJ7i
         PzsDbwXe5D3wnO5L7LxLVuw/tTPkTu9fEymat63d/vM4VxESJee/9LlX9hNzirOmNf3t
         x3RaVFqBHVoMWoJuLWoWavWWCIDbfq7q70d8H8V0IHICkKS1BXrXv7xQbKC5lspKVbzT
         kbyA+1kfYdcRwqI8eOiit/xANNVuq9xAlUjcPZ/ISBF0zZdU2B+au34GES+OjONTar0L
         9kDg==
ARC-Authentication-Results: i=1; mx.google.com;
       spf=pass (google.com: domain of christophe.leroy@c-s.fr designates 93.17.236.30 as permitted sender) smtp.mailfrom=christophe.leroy@c-s.fr
Authentication-Results: mx.google.com;
       spf=pass (google.com: domain of christophe.leroy@c-s.fr designates 93.17.236.30 as permitted sender) smtp.mailfrom=christophe.leroy@c-s.fr
Subject: Re: [PATCH 4.14 1/4] powerpc/mm/slice: Remove intermediate bitmap
 copy
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
References: <69684e92a32d00c491540e8adfa34fcb50c36244.1520468013.git.christophe.leroy@c-s.fr>
 <20180310001043.GD13963@kroah.com>
From: christophe leroy <christophe.leroy@c-s.fr>
Message-ID: <39af0017-6a9c-a032-8167-40b5f30840f8@c-s.fr>
Date: Sat, 10 Mar 2018 08:27:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180310001043.GD13963@kroah.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1594475718248427288?=
X-GMAIL-MSGID: =?utf-8?q?1594534795664378777?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>



Le 10/03/2018 à 01:10, Greg Kroah-Hartman a écrit :
> On Fri, Mar 09, 2018 at 04:48:59PM +0100, Christophe Leroy wrote:
>> Upstream 326691ad4f179e6edc7eb1271e618dd673e4736d
> 
> There is no such git commit id in Linus's tree :(
> 
> Please fix up and resend the series.

I checked again, it is there

https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/powerpc/mm/slice.c?h=next-20180309&id=326691ad4f179e6edc7eb1271e618dd673e4736d

The id seems to be exactly the same.

Christophe

> 
> thanks,
> 
> greg k-h
> 

---
L'absence de virus dans ce courrier électronique a été vérifiée par le logiciel antivirus Avast.
https://www.avast.com/antivirus
