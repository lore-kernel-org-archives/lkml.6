Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-1429089-1522757768-2-13084310987959521041
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
    1522757767; b=egX3HfN3ta3nH/ho9UcJmZk1Dl4igUrgezQ9pmKVbMq2JRPyTi
    R9JB+G8LKeYr+RhZfFUVCFcrKbj2kgcLHDS1jLae6vUmzHQj+sWwiUTEhkb1z5aZ
    ZueILqi3q+zG+o2H5guAbKrR8atmI2WMSZLS/CBIhQipTng+IuxohryAq81kpV1S
    RnEUkA2hIDnNjVQ7oqctGeu7tU/ipCo06nHJYbHNdqhrCqGiWuatgBdVKguFdL2R
    V6TQaptkBjwFX8IcBXHRL9r05NQ7oShhUPp4MccCbFyOQ929dyzyXW+QWaL0X2mF
    iypbEIEsOAmT5tbiyv/y+UtALPGAu5nQ79Ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=mime-version:in-reply-to:references:from
    :date:message-id:subject:to:cc:content-type:sender:list-id; s=
    fm2; t=1522757767; bh=k62p1rr7SWqXZQWm3DO79C6sGsqZGfAkWLbtANQDpr
    4=; b=vJL0A52PbmtZp1cqiS7sKB7GBkluocyqbaWaGK8ikelG0TGeuVdMUMDmoN
    RuTXZdn+yE9Rl7PLxNPBvq8MhJK/VAMS7v4CjAvWZpGMXRSEHbRZG6Rvrp6s2EEj
    OMfyyTdMvQ/kvWMBYdB2RhMFtJGAz11aESaRolr8RV5WC41MYjVp3OhKCJ/aTAfN
    vTqE3FsDqngaW3T5IBkn3rSkfKTboOBrZqS+bWLqXbzgk8CFz5dzmpqQUb3Ik+a2
    DbvFo/7yan3kpu4GyDwZZ8f2ShJYp+R46Yy9QbUYnt1gPUFcVg7LysWb0euQ4kG0
    M1NlNVTbPrQDBdCzoMkb8yFVSG3w==
ARC-Authentication-Results: i=1; mx4.messagingengine.com; arc=none (no signatures found);
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=rW+3d/6E x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
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
    dkim=fail (body has been altered, 2048-bit rsa key sha256) header.d=nifty.com header.i=@nifty.com header.b=rW+3d/6E x-bits=2048 x-keytype=rsa x-algorithm=sha256 x-selector=dec2015msa;
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=socionext.com;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=socionext.com header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfEb/65qaDAqNOFI21/TWeCZ3/kXy/EoUmSZrh4tVnMyRkRGS3iQRoAHIGMxtrDaNlTgaKno043EK92GesbTWfYbJ6GgZLWcXMIW/f1MwtpELmz6NfjNP
    lTuAnG6KU63IgVs5E8g2vyb/BULEf7kvF/vndIiP66ExEaDClg1jk89loDTKEpjm5VxHfE4YfgB/xW/OgPdeniKy5z6GVxDfUjH2wZtuwcmDoJJGt1GB9r/U
X-CM-Analysis: v=2.3 cv=JLoVTfCb c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=IkcTkHD0fZMA:10 a=Kd1tUaAdevIA:10
    a=KKAkSRfTAAAA:8 a=D19gQVrFAAAA:8 a=VwQbUJbxAAAA:8 a=ncGq_cB_pO34GDIl-9AA:9
    a=IdUx01UEeU446eiQ:21 a=U4qG39-SqMZLwaTw:21 a=QEXdDO2ut3YA:10
    a=x8gzFH9gYPwA:10 a=cvBusfyB2V15izCimMoJ:22 a=W4TVW4IDbPiebHqcZpNg:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755455AbeDCMPv (ORCPT <rfc822;greg@kroah.com>);
        Tue, 3 Apr 2018 08:15:51 -0400
Received: from conssluserg-02.nifty.com ([210.131.2.81]:25503 "EHLO
        conssluserg-02.nifty.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755300AbeDCMPu (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Tue, 3 Apr 2018 08:15:50 -0400
DKIM-Filter: OpenDKIM Filter v2.10.3 conssluserg-02.nifty.com w33CFSVI004050
X-Nifty-SrcIP: [209.85.213.45]
X-Google-Smtp-Source: AIpwx4+V6LHIjaXerPWATKMUgncK+qYPDJN8BswuHP6STYENipmAXsvVXNYTTte/+YTpSNKzEhRhBwTkzeuEFct41Ec=
MIME-Version: 1.0
In-Reply-To: <20180403080335.ksekhxwvbzbxhmln@dell>
References: <CAK7LNARFWDMgmWsCjUmVrm4ZeYOcKCbizijxmDXob618ABjNWg@mail.gmail.com>
 <20180402120414.GA8159@lunn.ch> <CAK7LNAQ6LKk3NtGLB8g07ocyvXidpTHsApeDuctvEHyyLvk2ew@mail.gmail.com>
 <20180402133219.GA10520@lunn.ch> <20180403080335.ksekhxwvbzbxhmln@dell>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Tue, 3 Apr 2018 21:14:47 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQbWUYuhow5VdNDc+SuttY+u3xh9zk92kLEy9id6TNCFg@mail.gmail.com>
Message-ID: <CAK7LNAQbWUYuhow5VdNDc+SuttY+u3xh9zk92kLEy9id6TNCFg@mail.gmail.com>
Subject: Re: [Question] MFD driver that handles clocks/resets and populates
 child nodes
To: Lee Jones <lee.jones@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>,
        linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

2018-04-03 17:03 GMT+09:00 Lee Jones <lee.jones@linaro.org>:
> On Mon, 02 Apr 2018, Andrew Lunn wrote:
>
>> On Mon, Apr 02, 2018 at 10:21:01PM +0900, Masahiro Yamada wrote:
>> > 2018-04-02 21:04 GMT+09:00 Andrew Lunn <andrew@lunn.ch>:
>> > >> The maintainer of DWC3, Felipe Balbi, requested to
>> > >> split the glue layer driver into small parts such as
>> > >> reset, regulator, phy, etc.
>> > >
>> > > What exactly did Felipe ask for? Did he ask that the patch be split
>> > > up, one patch per reset, regulator, phy etc?
>> >
>> >
>> > Yeah.  That is what we understood from his comments.
>> >
>> >
>> > These are the feed-backs from him.
>> >
>> > https://lkml.org/lkml/2018/1/23/298
>> > https://lkml.org/lkml/2018/1/24/352
>>
>> > > Are all these resources used just by the DWC3? Or is it a true MFD,
>> > > multiple functions?
>> >
>> > I do not think this is a real MFD.
>> >
>> > This is a DWC3 glue layer, i.e.
>> > a collection of misc registers that control
>> > the DWC3 IP.
>> >
>> >
>> > Just splitting it into small pieces
>> > to use PHY, reset, regulator framework in Linux.
>> >
>> > Of course, the price of this approach
>> > is so cluttered Device Tree,
>> > honestly I do not like it much.
>>
>> This however the correct way to do this. You should have a phy driver,
>> and a regulator driver, and a reset driver. The DWC3 then uses
>> phandles to these drivers.
>>
>> How is the IO map area 65b00000 split up. Can you cleanly separate it
>> into sub areas, which do not overlap, so you have a sub-area for the
>> PHY driver, a sub-area for the regulator driver and a sub-area for the
>> reset area? If you can cleanly split it up, you don't need an MFD. If
>> however the registers are in overlapping areas, you do need an
>> MFD. The MFD core provides access to the registers, while its children
>> implement PHY, reset, regulator etc.
>
> This device certainly sounds like an MFD to me.
>
> Can you share the DT you've written please?


This is still under the internal review in Socionext,
but I attached it below FWIW.

(I am not the author of this DT.
 Written by Kunihiko Hayashi,
 and clocks/resets parts were slightly modified by me.)


Just skimming the driver, I guess it will be possible to flatten
the node structure by separating the register space into sub-areas.
If this is success, we do not the MFD driver.


usb@65b00000 {
        compatible = "socionext,uniphier-ld20-usb3-glue",
                     "syscon";
        reg = <0x65b00000 0x1000>;
        clock-names = "usb";
        clocks = <&sys_clk 14>;
        reset-names = "usb";
        resets = <&sys_rst 14>;

        usb_rst: reset {
                compatible = "socionext,uniphier-ld20-usb3-reset";
                #reset-cells = <1>;
        };

        regulators {
                compatible = "socionext,uniphier-ld20-usb3-regulator";

                usb_vbus0: vbus-0 { };
                usb_vbus1: vbus-1 { };
                usb_vbus2: vbus-2 { };
                usb_vbus3: vbus-3 { };
        };

        usb_hsphy: hs-phy {
                compatible = "socionext,uniphier-ld20-usb3-hsphy";
                #address-cells = <1>;
                #size-cells = <0>;
                #phy-cells = <0>;
                clock-names = "phy-clk0", "phy-clk1";
                clocks = <&sys_clk 16>, <&sys_clk 17>;
                reset-names = "phy-rst0", "phy-rst1";
                resets = <&sys_rst 16>, <&sys_rst 17>;
                port0-supply = <&usb_vbus0>;
                port1-supply = <&usb_vbus1>;
                port2-supply = <&usb_vbus2>;
                port3-supply = <&usb_vbus3>;

                port@0 {
                        reg = <0>;
                        nvmem-cell-names = "rterm", "sel_t",
                                           "hs_i";
                        nvmem-cells = <&usb_rterm0>,
                                      <&usb_sel_t0>,
                                      <&usb_hs_i0>;
                };
                port@1 {
                        reg = <1>;
                        nvmem-cell-names = "rterm", "sel_t",
                                           "hs_i";
                        nvmem-cells = <&usb_rterm1>,
                                      <&usb_sel_t1>,
                                      <&usb_hs_i0>;
                };
                port@2 {
                        reg = <2>;
                        nvmem-cell-names = "rterm", "sel_t",
                                           "hs_i";
                        nvmem-cells = <&usb_rterm2>,
                                      <&usb_sel_t2>,
                                      <&usb_hs_i2>;
                };
                port@3 {
                        reg = <3>;
                        nvmem-cell-names = "rterm", "sel_t",
                                           "hs_i";
                        nvmem-cells = <&usb_rterm3>,
                                      <&usb_sel_t3>,
                                      <&usb_hs_i2>;
                };
        };

        usb_ssphy: ss-phy {
                compatible = "socionext,uniphier-ld20-usb3-ssphy";
                #address-cells = <1>;
                #size-cells = <0>;
                #phy-cells = <0>;
                reset-names = "phy-rst0", "phy-rst1";
                resets = <&sys_rst 18>, <&sys_rst 19>;
                port0-supply = <&usb_vbus0>;
                port1-supply = <&usb_vbus1>;

                port@0 {
                        reg = <0>;
                };
                port@1 {
                        reg = <1>;
                };
        };
};






-- 
Best Regards
Masahiro Yamada
