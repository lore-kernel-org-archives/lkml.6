Return-Path: <joel.stan@gmail.com>
ARC-Seal: i=1; a=rsa-sha256; t=1518490200; cv=none;
        d=google.com; s=arc-20160816;
        b=GWz6onT2mifas1oMSEb0bnZdtoYUv9RDE6UDxrEI0xVCKjFeXHadur3qMasshImBjE
         OaZ6GuAFPfp08RZBzpqLzoXtDufqCP0HysAcUfY8cKyS91f8HeqPAgCLQdbi+ZPu11F6
         UkNFfh/n1EBuAyy0cjOHVu2gi6JxAW4YcFWFyInVPTyGlQTqWVDdImRIA8TwC9NFbPNQ
         kTE+l1tgvYQQ/iWloCu0OkFX4UjOiYQcUn2SKX7lBLKF1AZYdrzQYzBuAioxIwiSqEdI
         1TRpGaBHG+UIHeRQFihdeemY8tMKuizKJynNScYHyCrGjIASLZGjEA3oMAswZqc3hauZ
         YoiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20160816;
        h=cc:to:subject:message-id:date:from:references:in-reply-to:sender
         :mime-version:dkim-signature:arc-authentication-results;
        bh=tHVf9w41KPYy1mBIYFtdBzhUpGs915/5paY0iHoS7TQ=;
        b=LLY7Ow2sCNaygWfIBDr6MYxnSqmGDEDBKbQX92klJVBdFA+qc0yNrRRhToN0dQxaOz
         FSabqSC9oKqQ4LpkGQ+yWAm0TtEDwpBj3mBQ9enseFYAQybxVJz4fzcDbolfKpx6rCRF
         fdP9KajmocF9+OgLDO1pfZARzcuhSD86xwX94ff45kLd6rqEeqaAaU9WInx+Nwn5ifXN
         nacaJxNYNOa1j7i4cHyTTOtWxUZMEijyLfHS16Ae5XeA+01Ur7xgzBUkemXWIvnrzPuD
         DyrfmxKNy0aSsimj7f/NOHNU2BUVP4AifdMsTH7IomOS9sKcQ1qQMX09MtyQ/TvJ/lBW
         jC9A==
ARC-Authentication-Results: i=1; mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=E3RGA3IQ;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
Authentication-Results: mx.google.com;
       dkim=pass header.i=@gmail.com header.s=20161025 header.b=E3RGA3IQ;
       spf=pass (google.com: domain of joel.stan@gmail.com designates 209.85.220.65 as permitted sender) smtp.mailfrom=joel.stan@gmail.com
X-Google-Smtp-Source: AH8x224d7aiXhuFNWehuOCJpPBV425DY9ky/U2RfqwF8Iu8cYjqnj/Vk4EgKun0abHQZdNfRCA4ZbapnXRh6jTN91Gg=
MIME-Version: 1.0
Sender: joel.stan@gmail.com
In-Reply-To: <20180212143654.xh3vrhvvj62mdtog@rob-hp-laptop>
References: <20180212051549.8575-1-joel@jms.id.au> <20180212051549.8575-10-joel@jms.id.au>
 <20180212143654.xh3vrhvvj62mdtog@rob-hp-laptop>
From: Joel Stanley <joel@jms.id.au>
Date: Tue, 13 Feb 2018 13:19:39 +1030
X-Google-Sender-Auth: oaPgmgclv2ughGh3RuIGEmaRwJA
Message-ID: <CACPK8Xf6Lfo1hwC0s=rp6DZsyDVpiW_vQPfsuLxCrUtV+Swx9g@mail.gmail.com>
Subject: Re: [PATCH 09/10] dt-bindings: fsi: Add optional property no-scan-on-init
To: Rob Herring <robh@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Mark Rutland <mark.rutland@arm.com>,
	Christopher Bostic <cbostic@linux.vnet.ibm.com>, Jeremy Kerr <jk@ozlabs.org>,
	Brad Bishop <bradleyb@fuzziesquirrel.com>, Edward James <eajames@us.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, devicetree <devicetree@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-getmail-retrieved-from-mailbox: INBOX
X-GMAIL-THRID: =?utf-8?q?1592171060192825925?=
X-GMAIL-MSGID: =?utf-8?q?1592252380074197681?=
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Tue, Feb 13, 2018 at 1:06 AM, Rob Herring <robh@kernel.org> wrote:
> On Mon, Feb 12, 2018 at 03:45:48PM +1030, Joel Stanley wrote:
>> From: Christopher Bostic <cbostic@linux.vnet.ibm.com>
>>
>> Add an optional FSI master property 'no-scan-on-init.  This
>> can be specified to indicate that a master should not be
>> automatically scanned at init time.  This is required in cases
>> where a scan could interfere with another FSI master on the same
>> bus.
>>
>> Signed-off-by: Christopher Bostic <cbostic@linux.vnet.ibm.com>
>> Acked-by: Jeremy Kerr <jk@ozlabs.org>
>> Signed-off-by: Joel Stanley <joel@jms.id.au>
>> ---
>>  Documentation/devicetree/bindings/fsi/fsi.txt | 7 +++++++
>>  1 file changed, 7 insertions(+)
>
> Please add acks/reviews when posting new versions.

Sorry Rob, I forgot about your ack. Thanks for reminding me.

Cheers,

Joel
