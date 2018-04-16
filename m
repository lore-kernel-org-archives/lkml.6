Return-Path: <linux-usb-owner@vger.kernel.org>
X-Cyrus-Session-Id: sloti22d1t05-3972417-1523906576-2-15089031546587525157
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, MAILING_LIST_MULTI -1, ME_NOAUTH 0.01, RCVD_IN_DNSWL_HI -5,
  LANGUAGES en, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='209.132.180.67', Host='vger.kernel.org', Country='US',
  FromHeader='org', MailFrom='org'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: linux-usb-owner@vger.kernel.org
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523906575; b=HLIfNZt/BZOwLuJeo5dck3/caoc3nu+MgNLiZr2cdxCBQudwOu
    rOmN+dtC4hvOFD1zQCz2pH4YqY3XX54q7/rfZkD1Njm3zg5222xZHr705c+YPmBa
    YRDzbDHG4lYv9mj3twGFWet4aaEp5Hkc/E6KSYuWwrPVAjrHeBW0D9g0HxEIsW/o
    idYoZhPCYG+aCL1tgTXhkKUjhPLu7EDmTrzgnWKo4DEj8Boebkn9oY7w78BpGeXm
    H+Upm6ZKFAakPobiHWFpaIgAZV9XDNPIcLIB7k5WuNCo0B9LilefXR4WNPrXKN5X
    5MbMrdDMUm42FnS41It0wLT3eVCYzFsNEqbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to:sender
    :list-id; s=fm2; t=1523906575; bh=ilNKI5LsbtV6NWQHYKK278m2TFyY4W
    ExlitNizhGx/g=; b=g62pAvXI/s18a7tWF8hd3H+fXnQz+0ldCd5cvt5tWuJTvX
    9B4llcdUXKVgAe99x4alPY7tYnQbzC7dXSemF9wWYO+pl8AcA6Nc0zu7pDXVNgJR
    qHENbZL1f2LUIzl/D23Ff2MjeGc9f+csaSQFWf6HxNWFCsacHq2tszURsaL3Hrzi
    ooaW6migdpot+U7EhBRxhCe2uZp5l4pYCMn77XkM1f1WeANjy8uRrXgIYNSqbG7c
    oZbvzwAhN/sjDOp2uQbKEme+KSwQfe4KLn+BB5rGHGdCYmbuaAhSMf3xNhhKTsYd
    9uSExk5he3iMzh1L9W3gjqW1iUpt/5dWxS+F/JiA==
ARC-Authentication-Results: i=1; mx6.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=j9AIqFN8;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
Authentication-Results: mx6.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,has-list-id=yes,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=209.132.180.67 (vger.kernel.org);
    spf=none smtp.mailfrom=linux-usb-owner@vger.kernel.org smtp.helo=vger.kernel.org;
    x-aligned-from=orgdomain_pass (Domain org match);
    x-cm=none score=0;
    x-google-dkim=fail (body has been altered, 2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=j9AIqFN8;
    x-ptr=pass x-ptr-helo=vger.kernel.org x-ptr-lookup=vger.kernel.org;
    x-return-mx=pass smtp.domain=vger.kernel.org smtp.result=pass smtp_org.domain=kernel.org smtp_org.result=pass smtp_is_org_domain=no header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-vs=clean score=-100 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfLVsCw4QDt3RbtISVZ/YGJIAce8ybW8+Uu80NSMm0fYtVvJtfz1SO1/bSD3g5tI4XElxUdAtmYN/Hf2aKCOpRupVtRkFREHAV1ntRwymfx31NlxPFz0V
    B3z9zCCwc1yo3lOUH7A2hGnvOMBGCax9XX8dRICVJDuSjLFHKDJHPLDEP0bDLyfAaDjy9xjWbuv+g9Hl+Lxi5jdRLFjcioWuhPT7WDUA9TwIOWtxSLJIZvHx
X-CM-Analysis: v=2.3 cv=FKU1Odgs c=1 sm=1 tr=0 a=UK1r566ZdBxH71SXbqIOeA==:117
    a=UK1r566ZdBxH71SXbqIOeA==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=WFZIRff2AAAA:8 a=XYAwZIGsAAAA:8 a=VwQbUJbxAAAA:8 a=OpAJuOwQtL-6merF6poA:9
    a=CjuIK1q_8ugA:10 a=x8gzFH9gYPwA:10 a=E8ToXWR_bxluHZ7gmE-Z:22
    a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753420AbeDPTWa (ORCPT <rfc822;greg@kroah.com>);
        Mon, 16 Apr 2018 15:22:30 -0400
Received: from mail-ot0-f196.google.com ([74.125.82.196]:45125 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753233AbeDPTW2 (ORCPT
        <rfc822;linux-usb@vger.kernel.org>); Mon, 16 Apr 2018 15:22:28 -0400
X-Google-Smtp-Source: AIpwx4+N4vz70g9MBjzJLnGhpOeSNEnGiKf+yOVKWjfedwafcg/IVputpjPcvj/JdMjulr87my7ncA==
Date: Mon, 16 Apr 2018 14:22:26 -0500
From: Rob Herring <robh@kernel.org>
To: Phil Elwell <phil@raspberrypi.org>
Cc: Woojung Huh <woojung.huh@microchip.com>,
        Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "David S. Miller" <davem@davemloft.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Randy Dunlap <rdunlap@infradead.org>, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: Re: [PATCH 4/4] dt-bindings: Document the DT bindings for lan78xx
Message-ID: <20180416192226.p5pg3yvixdulobt4@rob-hp-laptop>
References: <1523541336-145953-1-git-send-email-phil@raspberrypi.org>
 <1523541336-145953-5-git-send-email-phil@raspberrypi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523541336-145953-5-git-send-email-phil@raspberrypi.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-usb-owner@vger.kernel.org
X-Mailing-List: linux-usb@vger.kernel.org
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Thu, Apr 12, 2018 at 02:55:36PM +0100, Phil Elwell wrote:
> The Microchip LAN78XX family of devices are Ethernet controllers with
> a USB interface. Despite being discoverable devices it can be useful to
> be able to configure them from Device Tree, particularly in low-cost
> applications without an EEPROM or programmed OTP.
> 
> Document the supported properties in a bindings file, adding it to
> MAINTAINERS at the same time.
> 
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>
> ---
>  .../devicetree/bindings/net/microchip,lan78xx.txt  | 44 ++++++++++++++++++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/net/microchip,lan78xx.txt
> 
> diff --git a/Documentation/devicetree/bindings/net/microchip,lan78xx.txt b/Documentation/devicetree/bindings/net/microchip,lan78xx.txt
> new file mode 100644
> index 0000000..e7d7850
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/net/microchip,lan78xx.txt
> @@ -0,0 +1,44 @@
> +Microchip LAN78xx Gigabit Ethernet controller
> +
> +The LAN78XX devices are usually configured by programming their OTP or with
> +an external EEPROM, but some platforms (e.g. Raspberry Pi 3 B+) have neither.
> +
> +Please refer to ethernet.txt for a description of common Ethernet bindings.
> +
> +Optional properties:
> +- microchip,eee-enabled: if present, enable Energy Efficient Ethernet support;

I see we have some flags for broken EEE, but nothing already defined to 
enable EEE. Seems like this should either be a user option (therefore 
not in DT) or we should use the broken EEE properties if this is h/w 
dependent.

> +- microchip,led-modes: a two-element vector, with each element configuring
> +  the operating mode of an LED. The values supported by the device are;
> +  0: Link/Activity
> +  1: Link1000/Activity
> +  2: Link100/Activity
> +  3: Link10/Activity
> +  4: Link100/1000/Activity
> +  5: Link10/1000/Activity
> +  6: Link10/100/Activity
> +  7: RESERVED
> +  8: Duplex/Collision
> +  9: Collision
> +  10: Activity
> +  11: RESERVED
> +  12: Auto-negotiation Fault
> +  13: RESERVED
> +  14: Off
> +  15: On
> +- microchip,tx-lpi-timer: the delay (in microseconds) between the TX fifo
> +  becoming empty and invoking Low Power Idles (default 600).

Needs a unit suffix as defined in property-units.txt.

> +
> +Example:
> +
> +	/* Standard configuration for a Raspberry Pi 3 B+ */
> +	ethernet: usbether@1 {
> +		compatible = "usb424,7800";
> +		reg = <1>;
> +		microchip,eee-enabled;
> +		microchip,tx-lpi-timer = <600>;
> +		/*
> +		 * led0 = 1:link1000/activity
> +		 * led1 = 6:link10/100/activity
> +		 */
> +		microchip,led-modes = <1 6>;
> +	};
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 2328eed..b637aad 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14482,6 +14482,7 @@ M:	Microchip Linux Driver Support <UNGLinuxDriver@microchip.com>
>  L:	netdev@vger.kernel.org
>  S:	Maintained
>  F:	drivers/net/usb/lan78xx.*
> +F:	Documentation/devicetree/bindings/net/microchip,lan78xx.txt
>  
>  USB MASS STORAGE DRIVER
>  M:	Alan Stern <stern@rowland.harvard.edu>
> -- 
> 2.7.4
> 
