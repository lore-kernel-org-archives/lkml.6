Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1050350-1522744271-2-5143679294038995449
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, HEADER_FROM_DIFFERENT_DOMAINS 0.249, RCVD_IN_DNSWL_HI -5,
  T_RP_MATCHES_RCVD -0.01, LANGUAGES en, BAYES_USED global,
  SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='CN',
  FromHeader='com', MailFrom='org'
X-Spam-charsets: plain='UTF-8'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1522744271; b=KumnVnwFe4HXz7nQJk89fg0kyRvK8TiSkGh5QDvoNRw0qBAQEx
    rZ8WUuN0D/BCtbQKhydzmIp/z4ixD3X2w+ri5FpZNBOMZG5TgnXshjmi2yGoJEPd
    KqXB2ybLxd6iva1GdROpg+CIzWPs31wE664XKifxLwKQlevDDqfyE+SOk1Pz8Rpz
    GsYQ+8cMlEX7iMkr04liZZDyatoYQp/TdqX44wZCBIZyBKdMY7pPLvNB59GiNrcd
    ao8a6YE5hzA42L2Igr46CP7PUOZJMZpRw3KsCYhPMJ3y6SFi5jYsInPYDLU9CfNb
    dq+4FQ1NeEWk8YspiHTAo/7hIODYIPe0lD7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522744271; bh=v3VQXmUTmSVBMvth/G8V8huyaKh/92veT1dEG//aKu
    4=; b=kk/BxZk1OrquxszL7W4GOWsZSy8vsIrHV+bGuPJjY7qczZlKjppe5qpsIX
    qS/zikILhh52fMbf4VDPhwFJEk2X1nbgQADPTNhn3FRb2Vwwn3Jwv3rlvr3yKXZN
    w5IcnxbYePh/xLZwABeEZOL2+Hailt4yhV0cfpOg5hjfRCc1AWhjw0iVlmESCeq9
    cMNjvCepQsa4o+NBspnCsGZ6yhiDYdaqhUw+AkqYedShCzpq39XH3AhcujI/pZTQ
    OzZVTCYgS0i2g9i+XeB99cdauSPy47gntN5HiHwS9AHm/z/Sb5yPvn28hu6zTWgH
    cf7l+EjfihYDx9bWMTGee4R5lgXQ==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=F+FWxLM4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=F+FWxLM4 x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfDuWoCSvA7zD+tkZl8kYE8VzzuCviDFAlZ2WAst/UFJdgVJe7X8fiLKg43UhS2HS8a7B96qraiu5UX+Tqncwfh9A941fzBq0afCi3yF3JIbrPSxa25z4
    I6LpaYT6UAUtOkP+tWidJitiftmeg6KfrIrQV9VMdj52aOROq+ridFqRnKOTuMGZRHJJ0Lv59PHM5nidLKEIg0ifrPFVMO7FjFsIR/ARpKODyKqFjME0Oolk
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=c-n4J4-pAAAA:8 a=VwQbUJbxAAAA:8 a=I_dIe7Myjgi8I4batyMA:9 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=L0NDqeB7ZLmQzAogN4cw:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755220AbeDCIa7 (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 04:30:59 -0400
Received: from conssluserg-06.nifty.com ([210.131.2.91]:22792 "EHLO
        conssluserg-06.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755154AbeDCIa6 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 3 Apr 2018 04:30:58 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-06.nifty.com w338UifE004754
X-Nifty-SrcIP: [209.85.213.46]
X-Google-Smtp-Source: AIpwx4/Iul+YqN6l4Wfv5WnhvWmqDmRdivDyfz0CJyIdxjhXHMOQ3of3ISqRcuTGQobYsn6qEPMVdR+3n9ku0bBGZmw=
MIME-Version: 1.0
In-Reply-To: <1522742421.5089.1.camel@pengutronix.de>
References: <1522303676-7035-1-git-send-email-yamada.masahiro@socionext.com> <1522742421.5089.1.camel@pengutronix.de>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 3 Apr 2018 17:30:03 +0900
X-Gmail-Original-Message-ID: <CAK7LNARmw5-d5v41GRPhmVk69obK0gVt_EEGnpydk3GU2UaV9Q@mail.gmail.com>
Message-ID: <CAK7LNARmw5-d5v41GRPhmVk69obK0gVt_EEGnpydk3GU2UaV9Q@mail.gmail.com>
Subject: Re: [PATCH] usb: dwc3: of-simple: use managed and shared reset control
To: Philipp Zabel <p.zabel@pengutronix.de>
Cc: Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-03 17:00 GMT+09:00 Philipp Zabel <p.zabel@pengutronix.de>:
> On Thu, 2018-03-29 at 15:07 +0900, Masahiro Yamada wrote:
>> This driver handles the reset control in a common manner; deassert
>> resets before use, assert them after use.  There is no good reason
>> why it should be exclusive.
>
> Is this preemptive cleanup, or do you have hardware on the horizon that
> shares these reset lines with other peripherals?


This patch is necessary for Socionext SoCs.

The same reset lines are shared between
this dwc3-of_simple and other glue circuits.



>> Also, use devm_ for clean-up.
>>
>> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
>> ---
>>
>> CCing Philipp Zabel.
>> I see his sob in commit 06c47e6286d5.
>
> At the time I was concerned with the reset_control_array addition and
> didn't look closely at the exclusive vs shared issue.
>>  drivers/usb/dwc3/dwc3-of-simple.c | 7 ++-----
>>  1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/usb/dwc3/dwc3-of-simple.c b/drivers/usb/dwc3/dwc3-of-simple.c
>> index e54c362..bd6ab65 100644
>> --- a/drivers/usb/dwc3/dwc3-of-simple.c
>> +++ b/drivers/usb/dwc3/dwc3-of-simple.c
>> @@ -91,7 +91,7 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
>>       platform_set_drvdata(pdev, simple);
>>       simple->dev = dev;
>>
>> -     simple->resets = of_reset_control_array_get_optional_exclusive(np);
>> +     simple->resets = devm_reset_control_array_get_optional_shared(dev);
>
> From the usage in the driver, it does indeed look like _shared reset
> usage is appropriate. I assume that the hardware has no need for the
> reset to be asserted right before probe or after remove, it just
> requires that the reset line is kept deasserted while the driver is
> probed.
>
>>       if (IS_ERR(simple->resets)) {
>>               ret = PTR_ERR(simple->resets);
>>               dev_err(dev, "failed to get device resets, err=%d\n", ret);
>> @@ -100,7 +100,7 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
>>
>>       ret = reset_control_deassert(simple->resets);
>>       if (ret)
>> -             goto err_resetc_put;
>> +             return ret;
>>
>>       ret = dwc3_of_simple_clk_init(simple, of_count_phandle_with_args(np,
>>                                               "clocks", "#clock-cells"));
>> @@ -126,8 +126,6 @@ static int dwc3_of_simple_probe(struct platform_device *pdev)
>>  err_resetc_assert:
>>       reset_control_assert(simple->resets);
>>
>> -err_resetc_put:
>> -     reset_control_put(simple->resets);
>>       return ret;
>>  }
>>
>> @@ -146,7 +144,6 @@ static int dwc3_of_simple_remove(struct platform_device *pdev)
>>       simple->num_clocks = 0;
>>
>>       reset_control_assert(simple->resets);
>> -     reset_control_put(simple->resets);
>>
>>       pm_runtime_put_sync(dev);
>>       pm_runtime_disable(dev);
>
> Changing to devm_ changes the order here. Whether or not it could be a
> problem to assert the reset only after pm_runtime_put (or potentially
> never), I can't say. I assume this is a non-issue, but somebody who
> knows the hardware better would have to decide.



I do not understand what you mean.
Can you describe your concern in more details?

I am not touching reset_control_assert() here.

I am delaying the call for reset_control_put().


If I understand reset_control_put() correctly,
the effects of this change are:
  - The ref_count and module ownership for the reset controller
    driver will be held a little longer
  - The call for kfree() will be a little bit delayed.

Why do you need knowledge about this hardware?



-- 
Best Regards
Masahiro Yamada
