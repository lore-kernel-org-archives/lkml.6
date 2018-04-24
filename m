Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-2128120-1524533820-2-10041212014636007487
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.25, MAILING_LIST_MULTI -1,
  RCVD_IN_DNSWL_HI -5, LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1524533818; b=i76t5/eesvpmaxfsBZsPs/6YtjgvMnlntLS7KmiLBUlrZ4ODHU
    gXljKlizcoGAN6OHU1RWwSs/Dza2g9feQHsLU1o8KvBt7HUl6R53x1d07sCL/78o
    eOiMrwP4WY5H3rClLEBOeT74xrVZP2PjIh16C+q0G8XDCZddU7xziXfhc3J5T96l
    1+roCXRisYG8a96e2WdOOiKFp/vsMizzFOWf4HcxYPqza8MjZHlSPfTh7pa0ku+E
    NwumFzdTv8ujQFAYSFjp9Tg3A8W4MWXhwEI4YuqfdE2AUfGExUmJjpFhC304A937
    cW5mfbgnTfKt2onH+6ESdhZd2JBlQFKtmJLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1524533818; bh=EvIC8PgveqxdFivSGlnGIiluJSJHhgSyS8VaJpCPYz
    k=; b=aY7WQb7tXaJph1XXAZ9sjuB5QcW4BoUh6TwA5pLb51P0KAHCDTHFwGkC7N
    X/Nj8YFVdIP0hK7pM6QgdPgnSwA7NYzh1Et8VcChjlG6qHsoOujakxZ8sSXLnrj/
    YMKy21ecXi39FsEIPwl0NCv7hzN3gqFQLuteCFEJV/4sGPUpqYFZK3zr5h4gOPvC
    H7JYB615BEzQShsLWDQACBRxyp4teV1fzUVj9/u3NzIQ2mFUe4PP/Wg5G2QLSg71
    aw+bPm9t6uCimCaULypdC/DGdI1aW5HT07ZQa19K1LJm/7+svOzAlq4E9wZPxY8Y
    gT/YBJgkRw/D6Sz5BKkvW950qxyA==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=M2icWXip x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx4.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=M2icWXip x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfENrUu7Qcmh8OZL10XBKfH4CpJKPLtrKuTVpiVTx4mySjSADIKCBLPIT19DKnqggO6saHT5vzfPwD5WV/FH0sye2y/VipDQh859pKfUrq+zYbWowyICd
    qy7ElMP1/iTZaNeLTjy2A7refZ2WtmFHTiyaQoC5MI6phqSN1xugPBeVz9wFWmxAuy6jRBLoRAXlPfF/KBRB06ID1/7XQ7HHli1yC2lJwCgL+Gmy4EkXWfet
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=LpQP-O61AAAA:8 a=VwQbUJbxAAAA:8 a=CwpoP0PEuqse49icyeQA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=pioyyrs4ZptJ924tMmac:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932708AbeDXBgu (ORCPT <rfc822;greg@kroah.com>);
        Mon, 23 Apr 2018 21:36:50 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:49180 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932652AbeDXBgs (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 23 Apr 2018 21:36:48 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w3O1ag9f008521
X-Nifty-SrcIP: [209.85.217.179]
X-Google-Smtp-Source: AB8JxZoFvh7jxuAXALdFELdvN9TGccjuBgYcOrVthQ15eBPUpKf5N42xjw/+GJbFbfR/8VNg5cCgFX3ZKN3MF/aw1g8=
MIME-Version: 1.0
In-Reply-To: <31be9c49-7562-1c06-7bf9-bafaea2f1c16@codeaurora.org>
References: <1524135818-14825-1-git-send-email-yamada.masahiro@socionext.com> <31be9c49-7562-1c06-7bf9-bafaea2f1c16@codeaurora.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 24 Apr 2018 10:36:01 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQZEkarVA-JKgivjJsV8yhGsXpJUEeoJB=UhXfj5y-Knw@mail.gmail.com>
Message-ID: <CAK7LNAQZEkarVA-JKgivjJsV8yhGsXpJUEeoJB=UhXfj5y-Knw@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] usb: dwc3: support clocks and resets for DWC3 core
To: Manu Gautam <mgautam@codeaurora.org>
Cc: linux-usb@vger.kernel.org,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        Rob Herring <robh@kernel.org>, Roger Quadros <rogerq@ti.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        DTML <devicetree@vger.kernel.org>,
        Felipe Balbi <balbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-24 9:11 GMT+09:00 Manu Gautam <mgautam@codeaurora.org>:
> HI,
>
>
> On 4/19/2018 4:03 AM, Masahiro Yamada wrote:
>> In the current design of DWC3 driver,
>> the DT typically becomes a nested structure like follows:
>>
>>   dwc3-glue {
>>           compatible = "foo,dwc3";
>>           ...
>>
>>           dwc3 {
>>                   compatible = "snps,dwc3";
>>                   ...
>>           };
>>   }
>>
>> The current DWC3 core (drivers/usb/dwc3/core.c) can not handle
>> clocks / resets at all.
>>
>> The only solution we have now, is to put DWC3 core node under
>> the glue layer node, then add clocks and resets there.
>> Actually, dwc3-of-simple.c exists to handle clocks and resets.
>>
>> As always for digital circuits, DWC3 core IP itself needs clock input.
>> This is specific to this IP.  So, supporting clocks and resets in
>> dwc3/core.c makes sense.
>
> Why can't dwc3-of-simple be used with this IP?
> Adding core/reset handling in both core and glue drivers might
> only add to confusion and I cant think of a reason why having a parent
> node representing dwc3-of-simple glue would be any concern.
> Or are you planning to remove dwc3-of-simple.c driver?


dwc3-of-simple.c can be removed only after at least
all upstream DT files are migrated.
(and give enough time for migration of downstream DT)

At least, new platforms are not required to use this hack.




-- 
Best Regards
Masahiro Yamada
