Return-Path: <SRS0=uOC5=M5=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D49ECDE39
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:06:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37B852152C
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Oct 2018 16:06:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B852152C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727953AbeJRACV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Oct 2018 20:02:21 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:34027 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727103AbeJRACV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Oct 2018 20:02:21 -0400
Received: by mail-oi1-f195.google.com with SMTP id v69-v6so21539248oif.1;
        Wed, 17 Oct 2018 09:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eHo1mueLbFAic3RwYt+vw5+NfCDL/FBxrFoMMrZMhPM=;
        b=Ffbxwn5zJKJ2aTdBwTbKBcRiOeOpiEqcO2SFlKyoxqFQSZx0//Hmf1p96da8ECkIs1
         VEY631SIRGNlZb4dC3DzhEFUw9VRq1CmdU0MahxRK9WEDSmOk5TJ5e/34TxaVugxfk1G
         e9GfF5Hrn3G3kwi/asYw/4U/dwQtBQsbLd3BsQ2TCuYqxtElVvlsJ2TGnnHpTL4L2rQY
         ljdi/8iLmwTQjwB9ev6GF55RIWP2CcdQ9oglLaD9bmWW5DzqKKjZ0y8UU5QQFeqbJkH9
         i9Ug43bWCq7T2pJC+No/J7F9oB5Wy9aG5swIF643MNzy4eLafPjPvN6ANBsVvefplJRl
         sibA==
X-Gm-Message-State: ABuFfoi1j6Rhu6SWq58rMVVsTF2nz1XsKNXxSNn+GdZjA1Sl+aJOyQBz
        DH2UySfIdOYtpunQkkKowQ==
X-Google-Smtp-Source: ACcGV616XGWdwMXmwKC3xabqD+WnRqpqNFzUPXFrruRzwJ0KYy7xtgMDS/t2SVzrDuF6d3BM03HmcQ==
X-Received: by 2002:aca:1c19:: with SMTP id c25-v6mr13598522oic.246.1539792357827;
        Wed, 17 Oct 2018 09:05:57 -0700 (PDT)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id u17-v6sm5390408oia.43.2018.10.17.09.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 17 Oct 2018 09:05:57 -0700 (PDT)
Date:   Wed, 17 Oct 2018 11:05:56 -0500
From:   Rob Herring <robh@kernel.org>
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: clock: add description of 74aup1g157gw
Message-ID: <20181017160556.GA14935@bogus>
References: <87efcy1rm4.wl-kuninori.morimoto.gx@renesas.com>
 <87d0si1rkt.wl-kuninori.morimoto.gx@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87d0si1rkt.wl-kuninori.morimoto.gx@renesas.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 10, 2018 at 02:16:35AM +0000, Kuninori Morimoto wrote:
> 
> From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> 
> 74aup1g157gw needs i0 and i1 pin as input, select and output it by
> sel gpio pin. This patch adds description for 74aup1g157gw as clock
> multiplexer.
> "nxp,74aup1g157gw-clk" will select most closest input as output,
> "nxp,74aup1g157gw-audio-clk" will select 48kHz/44.1kHz categorized
> input as output.
> 
> Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
> ---
>  .../devicetree/bindings/clock/nxp,74aup1g157gw.txt    | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/nxp,74aup1g157gw.txt
> 
> diff --git a/Documentation/devicetree/bindings/clock/nxp,74aup1g157gw.txt b/Documentation/devicetree/bindings/clock/nxp,74aup1g157gw.txt
> new file mode 100644
> index 0000000..d07bc04
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/nxp,74aup1g157gw.txt
> @@ -0,0 +1,19 @@
> +NXP 74AUP1G157GW Low-power 2-input multiplexer for clock
> +
> +Required properties:
> +- compatible:	"nxp,74aup1g157gw-clk"      (select closest input as output)
> +		"nxp,74aup1g157gw-audio-clk (select 48kHz / 44.1kHz as output)

I don't understand why you need the second one.


What's wrong with the existing gpio-mux-clock binding?

> +- clocks:	select input clock as i0, i1
> +- clock-names:	"i0" and "i1"
> +- sel-gpios:	selector pin
> +
> +Examples:
> +
> +	clk {
> +		#clock-cells = <0>;
> +		compatible = "nxp,74aup1g157gw-audio-clk";
> +		clocks = <&clk8snd>, <&clksnd>;
> +		clock-names = "i0", "i1";
> +		sel-gpios = <&gpio_exp_75 13 GPIO_ACTIVE_HIGH>;
> +	};
> +
> -- 
> 2.7.4
> 
