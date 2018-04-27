Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-599407-1524854442-2-18055785518876813988
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524854441; b=eAd0PWzO+grgjcMR4zLajevL9Hq6K8OUGJydEkx9IUwf+GoA66
    dwP97KKKt1sjdiDTOvzguHQ6D8D2ZD+4OyxjL3fQ5II3k2K8dpnjtcR5tTzwpXB5
    sHoNJvuYA1A+USanYQSniXrgLWpOtPinzy0UsD6UwD2VN4FC+fb6diFFTk+gA67S
    8izwN2+tFuefIyrg0bppNm9R27KJa7bbgc3qVbJ86r4AzuZWleABPHm2oMHJx2Ht
    3nxUnYf58DhmRLmgYoShAO3oq1crx//5k7ReEfRkbv3MQRuETTdqJ8JRCS6zyais
    jRb8v3lt4l1qlAU3uztURuuY6Dyct5VuMP7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524854441; bh=51GUBhEjHtzJzHJCf8QB8RvvP3OBNp7+/PaN27gCgd
    w=; b=F54ICQlSEV2oOHc69bnEa6PKSj2qJvZD0X8F5jHsE3zFZC6pTQS9H3g8Ob
    QFNgSVdNhXB2WYs175UK0A5eEawFWBSI94Z8UFZFEX2Um3WeJ8nw+ETwxVzUkKwC
    T+GxyK2KfLwgVTewMPKB5cJub/b74BUkFlR5kXjrOn8dvVMP3OyUyhxumqJfePiP
    r/00mWbwgIv9PyYAp42AcElcGSZdbnfsKKwsl9SsKdg4uY+uJFu79Gh9nEKU9atJ
    qhSVQ4KhOLTWIKKAL2l4mRcBgdEbO0pQIn6X8wl2HGIXB0pgUQfrO8v2p/3jd8jx
    mx1n75QBgodcIFtB3EgcnqkREIlw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEhQ6BK92avPTuK4DRv8BLkp1PPa85N8xRrfe4VLoLI01JkOF1rVy7Zjppu7p2qWv9zL3LY25qDZga113BNpey6BmhDgOtDIbCsV0t/eRxzuISpGFGlW
    O7GU/wLqspCpstZ03kDIbDGWGJVFHPaGad7PERyotU0EHxwBSr1DnOuWjZTSO7yJcCGsFwnLrg8btZBxVrT72Hk+4w6JLPMNiR/1LvfQSmW+uz/ACyueU59t
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=c-n4J4-pAAAA:8 a=VwQbUJbxAAAA:8 a=L1ABxL_F76uQkT2qEb0A:9
    a=3bM4AWcxkuvMA8oe:21 a=p276pXJcVoZNZjWt:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=L0NDqeB7ZLmQzAogN4cw:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758020AbeD0Sk1 (ORCPT <rfc822;greg@kroah.com>);
        Fri, 27 Apr 2018 14:40:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:35690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753079AbeD0SkX (ORCPT <rfc822;linux-usb@vger.kernel.org>);
        Fri, 27 Apr 2018 14:40:23 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 93960218D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh@kernel.org
X-Google-Smtp-Source: AB8JxZovY57UlcK+yrLckGDhEao31cHZBxT79f34MqxpbsQ3drCBZFNe2E+7VTKMiUBpAxyEFa/FHfWzv2ORwytEbuU=
MIME-Version: 1.0
In-Reply-To: <CAK7LNATtOxUjfoqmgAu-X_OYihKkMMRVLaYimEY0bRogOoHRZQ@mail.gmail.com>
References: <1524135818-14825-1-git-send-email-yamada.masahiro@socionext.com>
 <1524135818-14825-3-git-send-email-yamada.masahiro@socionext.com>
 <20180425152114.pzklc5uqva3nil5v@rob-hp-laptop> <CAK7LNATtOxUjfoqmgAu-X_OYihKkMMRVLaYimEY0bRogOoHRZQ@mail.gmail.com>
From: Rob Herring <robh@kernel.org>
Date: Fri, 27 Apr 2018 13:40:01 -0500
X-Gmail-Original-Message-ID: <CAL_JsqJ6pp+Rybb35B6RBMBvvRiFWL=S3QLDoKYnRtpUcCCYfg@mail.gmail.com>
Message-ID: <CAL_JsqJ6pp+Rybb35B6RBMBvvRiFWL=S3QLDoKYnRtpUcCCYfg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] usb: dwc3: support clocks and resets for DWC3 core
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Linux USB List <linux-usb@vger.kernel.org>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Roger Quadros <rogerq@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        DTML <devicetree@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Fri, Apr 27, 2018 at 11:20 AM, Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
> Hi Rob,
>
>
> 2018-04-26 0:21 GMT+09:00 Rob Herring <robh@kernel.org>:
>
>>> diff --git a/Documentation/devicetree/bindings/usb/dwc3.txt b/Documentation/devicetree/bindings/usb/dwc3.txt
>>> index 0dbd308..feb1cc33 100644
>>> --- a/Documentation/devicetree/bindings/usb/dwc3.txt
>>> +++ b/Documentation/devicetree/bindings/usb/dwc3.txt
>>> @@ -7,6 +7,27 @@ Required properties:
>>>   - compatible: must be "snps,dwc3"
>>>   - reg : Address and length of the register set for the device
>>>   - interrupts: Interrupts used by the dwc3 controller.
>>> + - clock-names: should contain "ref", "bus_early", "suspend"
>>> + - clocks: list of phandle and clock specifier pairs corresponding to
>>> +           entries in the clock-names property.
>>> + - resets: a single pair of phandle and reset specifier
>>
>> This should be optional as some SoCs don't have separate, s/w controlled
>> resets of modules.
>
> OK.  I will move resets to optional property.
>
>
> Please let ask a question.
>
>
> The number of clocks should be the same across SoCs.
> (Even if there is no s/w control for clocks,
> we should input something such as clk-fixed-rate.)

I guess if there's really not s/w control, then the number may vary,
but let's worry about that when someone has that problem.

> On the other hand, the number of resets can be different
> across SoCs.  If there is no s/w control for resets,
> we can make it optional.   (optional = 1 or 0 reset)
>
> Is this what you mean?

Yes. I think it's just more common to not have a reset than not have clocks.

> If we had something like reset-nop (or reset-dummy)
> in case no s/w control, we would be able to input something.
> I am not sure if this is the right thing, though.

I don't think we should require things if they are not needed.

Rob
