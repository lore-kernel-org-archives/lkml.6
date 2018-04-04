Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3959850-1522838062-2-6346038318489233908
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522838062; b=oALyRGQp+xGmaDIuaOBWP6iWZ6S7Lc11Eg/ZwqczNH/2pfcrqK
    DVCGu+JVRkCZTBQd6vsz9dG5mrbBbkoTvq5iO2i4ct06cHaSxFit9yLD0oTPkJXi
    mALqTNyaVCNg6ykUXyrKu9ajHWg5MP3ExldXJwpajpa72/xFRp/jfJq5EoGHwd9E
    0xaMNJraGWhYhX1lZap8QZMd+yKqazcKlj65O0rHpn0hTEOwLaTO3SiOOQZlQQ7A
    IOLunMSRkzRxRlkQ88uL+3qceIsiZMCMxfcGnAzbUyGBNIdaciuA06vNNRRyj8Fv
    VkHzknKn1c/AzWtk6CmFI43Iw6PtOs2I8qMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522838062; bh=qMXzD5OgMRey8T+ymKQu6M/k0otRW80WOA9M83sBF1
    Q=; b=N3fGzN/5AxmGQw16ZIVHlYNugpyahTJaUmjqxRKDEbz+mPCWQkemRpFXg5
    sT7Rv8b82xAdMxPg3HFd8yfj7g+oZsTBVt5gTvKeiLahYKWnH9IM7seggq1445YL
    iPlJQAR6YH+S6U8ScUSPtS6yNPcpzui++mWhSVdHApkTVpmlhjqOUQBprr3lWR7e
    6i8OX0cPHdG8d1ZmK4Gs/bD65DzF506t55Zlp0J/fgUy9Q+C85QszxgGo8wYKwV3
    3gYPPhY7Ma5A3MLXoWBeglVcsgpoQJ67M6f8nOw95I5VnVjXfm93otraFuxgz1z6
    JZ+kYSH0vquP7dFOsaYFuwN15/uw==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=YT/bw/MB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
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
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=YT/bw/MB x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfFL5GAj0QLvOR03YQ7bthGVmgtGGLnHt0LVnC1QAwzHHU5NSgcOLBvMYBZL03pZ61G2c8qDpuGycq3sVgHLfa/AlOYyWJppxEAg7zdOZJ5onJOekhGNm
    mzJGt7h9V74mmPtywmITPnUrubKIaGnmXlJCV7aAQQRo+mw8vsqJpRBbRTVmK0PD65jqByrWz+XUaYjGCRrl2OrxxsMemlQ6E0oIfWS4QPwb4kCRmfU60ICN
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=QyXUC8HyAAAA:8 a=c-n4J4-pAAAA:8 a=OLL_FvSJAAAA:8 a=VwQbUJbxAAAA:8
    a=5shu24LA6ngBDNbr4BQA:9 a=QEXdDO2ut3YA:10 a=UeXTCEmezP8A:10 a=x8gzFH9gYPwA:10
    a=B9tjyiFVUVcA:10 a=L0NDqeB7ZLmQzAogN4cw:22 a=oIrB72frpwYPwTMnlWqB:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751270AbeDDKeM (ORCPT <rfc822;greg@kroah.com>);
        Wed, 4 Apr 2018 06:34:12 -0400
Received: from conssluserg-03.nifty.com ([210.131.2.82]:40121 "EHLO
        conssluserg-03.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751117AbeDDKeK (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Wed, 4 Apr 2018 06:34:10 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-03.nifty.com w34AXsEI026547
X-Nifty-SrcIP: [209.85.217.179]
X-Google-Smtp-Source: AIpwx4+j5ifQHbxLJTUEdPcIJH4lYZRR2AhBH3Hmk1Qs2fpNaWx0c8hb8as8Ukk26X9lXpobo9qPWCJDf0O3fhvDoQ4=
MIME-Version: 1.0
In-Reply-To: <CAK8P3a0t4ooQNJrak_r_Qc2T4UeQB9k3SgStuaBptV2DcA8SBA@mail.gmail.com>
References: <CAK7LNATkS6pFQ9Gexm1uiG8e-3x6QXh-GYs3ABVEQzBnFK5gqw@mail.gmail.com>
 <87vad7cz2i.fsf@linux.intel.com> <CAK7LNARBVG54o+fozHk8efXUNk8GSkRcRcdDNrtUhDs5kOA7=Q@mail.gmail.com>
 <87po3fcxs4.fsf@linux.intel.com> <CAK7LNATpFZYK-f4j7sJpur-u43bK1gsz_eS1wurTq7C+n6pHAw@mail.gmail.com>
 <87woxns8nd.fsf@linux.intel.com> <CAK8P3a0t4ooQNJrak_r_Qc2T4UeQB9k3SgStuaBptV2DcA8SBA@mail.gmail.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 4 Apr 2018 19:33:13 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQae2RAnVJtGdoQDuOHjP6MDptGrvWuQoJAzQ269p_k-Q@mail.gmail.com>
Message-ID: <CAK7LNAQae2RAnVJtGdoQDuOHjP6MDptGrvWuQoJAzQ269p_k-Q@mail.gmail.com>
Subject: Re: Multiple generic PHY instances for DWC3 USB IP
To: Arnd Bergmann <arnd@arndb.de>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        linux-usb@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        DTML <devicetree@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Mathias Nyman <mathias.nyman@linux.intel.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

Hi Arnd,

2018-04-04 17:43 GMT+09:00 Arnd Bergmann <arnd@arndb.de>:
> On Wed, Apr 4, 2018 at 10:00 AM, Felipe Balbi
> <felipe.balbi@linux.intel.com> wrote:
>>
>> Hi,
>>
>> Masahiro Yamada <yamada.masahiro@socionext.com> writes:
>>>>> Each DWC3 instance is connected with
>>>>> multiple HS PHYs and multiple SS PHYs,
>>>>> depending on the number of ports.
>>>>
>>>> in that case, you shouldn't need dwc3 at all. A Host-only dwc3 is xHCI
>>>> compliant. If you really don't have the gadget block, there's no need
>>>> for you to use dwc3. Just use xhci-plat directly.
>>>
>>> Sorry, I was misunderstanding.
>>>
>>> Some of our SoCs support gadget,
>>> so we need to use the dwc3 driver.
>>
>> fair enough. Now we need to figure out how to pass multiply PHYs to a
>> multi-port dwc3 instance.
>>
>> Kishon, any ideas? How do you think DT should look like?
>
> See this series from Martin Blumenstingl:
>
> https://www.spinics.net/lists/linux-usb/msg166281.html
>
>       Arnd


Very useful information!

Not tested yet, but I quickly reviewed the series visually,
and probably this will work for us.

Thanks!


-- 
Best Regards
Masahiro Yamada
