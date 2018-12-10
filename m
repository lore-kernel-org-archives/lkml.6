Return-Path: <SRS0=GJN7=OT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83697C5CFFE
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0012082F
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 19:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4B0012082F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729618AbeLJT5e (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Dec 2018 14:57:34 -0500
Received: from mout.kundenserver.de ([212.227.17.24]:40337 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727515AbeLJT5c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Dec 2018 14:57:32 -0500
Received: from oxbaltgw08.schlund.de ([172.19.246.14]) by
 mrelayeu.kundenserver.de (mreue106 [213.165.67.113]) with ESMTPSA (Nemesis)
 id 1M6VRf-1gYwe22WZl-006umG; Mon, 10 Dec 2018 20:57:07 +0100
Date:   Mon, 10 Dec 2018 20:57:06 +0100 (CET)
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        linux-kernel@vger.kernel.org
Cc:     linux-rpi-kernel@lists.infradead.org, eric@anholt.net,
        agraf@suse.de, Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Message-ID: <591400583.99086.1544471826205@email.ionos.de>
In-Reply-To: <20181210163036.24813-3-nsaenzjulienne@suse.de>
References: <20181210163036.24813-1-nsaenzjulienne@suse.de>
 <20181210163036.24813-3-nsaenzjulienne@suse.de>
Subject: Re: [PATCH 2/2] Input: raspberrypi-ts - add devicetree binding
 documentation
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Medium
X-Mailer: Open-Xchange Mailer v7.8.4-Rev47
X-Originating-Client: open-xchange-appsuite
X-Provags-ID: V03:K1:wkyoO1DBfNNGCLm5usqT4SuSHkFlQdOjUSRJ6BfUmaiGZo2RyfX
 aMDKNqEujkpx4bKuRIGKoZwIBrtZAas+ixbRe7YjPlGXiiBhwTv2LjTds6lPrTCpU0HyqAb
 ySpED5i6fpCiD027kI7z2a1GvxprJ5pedE+YDNtoQsjWu+94F0rXvOg5PU7k+EcJf7G1d03
 WL73DK/8A0FaUKJCBqLWA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aIiXk5ztYtQ=:5oDrMXfHRQKAGUFIYHOrlt
 /gO5+valVzQBkUcYXYAnGAakTPa9v4x+QvaDZbKbY8nFzPxZ9wjzCXQkyEP8gx180HTYcBtfi
 fd5JwwjV2PDP04iYRDwIy6QPLWwi+bdZGFhOtcQD9gksj2AVZw3ySVQNn83muzjK6gSdpVL7c
 MwcRPMDk/pyS4vMDI/9zX7WCj7slLb7373CBXGZLid/8x151mY0uH4FVyNSg9GoSGnFskMmeX
 GoJu+TG3iGYwMShj8q4OgHsoFBXMR16zADwdRpDYkww8pXVoLx8BUpknlU2WgLbWA08d6BiRO
 hsjIC4ZRwqa9cyJVIFGEpSaGOMI6Z4quSbYHclK6/H862zTupxWo3kzn1MX+fiGkoiHj/BBh3
 uGqU30wlhbGAmbVkXUfJm4kaahiSiQE2cr4aHfMkpT5AlyHvAO7BCzb0mzL9mUBQVEK9C2zS5
 CJhGKIvDDtfWmKvn9eRJ5JN/+87/hPchU3mM/ToEm56m243gnpiptiIr/7ncCrz3x7zNf0/TC
 6DENN0S269+ed3biuVxzieSco4HfkY2IopQmZEmme7T6gv2iRVYx/+Pdr6uqpVfvuuxUGAOvS
 lLrjse36ocW7Y+HR1dtnwoEbYQ4hkWbqDnZhfuJXklnxZRd9ubAY65C91gp7W4sbytqugPUbX
 vYbUwzuzJmrif6v/0nFwXBLefEtVxXB5tr+d05t5bwySjYJqWuYxkJXo20mblpTYURSY1HusK
 IgHRCTKIVtoiPEsw/OscF6NlGUjhk0xOoqBXjx6s6axvprurshcfWAEcxJs=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nicolas,

please change your subject to something like this:

dt-bindings: input: Add Raspberry Pi Touchscreen

and also change the order of your patches. The binding always comes first.

> Nicolas Saenz Julienne <nsaenzjulienne@suse.de> hat am 10. Dezember 2018 um 17:30 geschrieben:
> 
> 
> Adds device tree documentation for Raspberry Pi's official 7"
> touchscreen.

Maybe you should mention that we need this binding for an overlay.

> 
> Signed-off-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
> ---
>  .../touchscreen/raspberrypi,firmware-ts.txt   | 26 +++++++++++++++++++
>  1 file changed, 26 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt b/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt
> new file mode 100644
> index 000000000000..38e22eb222e9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/input/touchscreen/raspberrypi,firmware-ts.txt
> @@ -0,0 +1,26 @@
> +Raspberry Pi 3 firmware based 7" touchscreen

Please drop the 3 here

> +=====================================
> +
> +Required properties:
> + - compatible: "raspberrypi,firmware-ts"
> +
> +Optional properties:
> + - firmware: Reference to RPi's firmware device node
> + - touchscreen-size-x: See touchscreen.txt
> + - touchscreen-size-y: See touchscreen.txt
> + - touchscreen-inverted-x: See touchscreen.txt
> + - touchscreen-inverted-y: See touchscreen.txt
> + - touchscreen-swapped-x-y: See touchscreen.txt
> +
> +Example:
> +
> +firmware: firmware-rpi {
> +	compatible = "raspberrypi,bcm2835-firmware";
> +	mboxes = <&mailbox>;
> +
> +	ts: touchscreen {
> +		compatible = "raspberrypi,firmware-ts";
> +		touchscreen-size-x = <800>;
> +		touchscreen-size-y = <480>;
> +	};
> +};
> -- 
> 2.19.2
>
