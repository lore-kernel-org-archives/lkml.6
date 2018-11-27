Return-Path: <SRS0=Hds+=OG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0613AC43441
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C8F88204FD
	for <linux-kernel@archiver.kernel.org>; Tue, 27 Nov 2018 01:57:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8F88204FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728161AbeK0MxT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 27 Nov 2018 07:53:19 -0500
Received: from mail-ot1-f66.google.com ([209.85.210.66]:35786 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727544AbeK0MxT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Nov 2018 07:53:19 -0500
Received: by mail-ot1-f66.google.com with SMTP id 81so18700711otj.2;
        Mon, 26 Nov 2018 17:57:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=sho3N2s/7HZvdw++PnCrNgGdDuYCSgichEjbpvFo56c=;
        b=KaOnSTOVrsm5fy5LBjqcu3XT9886Yfvzt1rPnEg8uuEWoYWF2/ysBPurhEU7XSG3yE
         iexXpmB50a1oi1Au9wIug36MbVvc36x2vasnqYQ+PhlmmT+htKjm2HQQtqNy+hTiQdNZ
         x3/GiCpexStJumD35Ypp5HQAOa2A9yCjofCIPrHEJb5xi8mS4IprvFA7miCdIUJl73Dj
         tUxdgEeHhlEJFxK0CLrDre0sv8fjkgyO2LOJ1vNpbBNxhJaEO1n5JCPm/7beHx2dUhP+
         E1yYOrDU4WnKz0Oy+R8O+Y1q66KqLrlwIhmlc5nllsP6vX1+mNLzm7ypeFVD0YDL1GXG
         oprQ==
X-Gm-Message-State: AA+aEWYbcBHUcMm4H+YMBg3RjjMut5SxkrON+Z5gZpjkl9E4WgCBIIpx
        3lpMs5xb5wvt2H4MHdszFg==
X-Google-Smtp-Source: AFSGD/VezLNjTDzjspwdAbCmxfhmf+NfZjakxJNy0F2vnI8N/EkRowTzVYHuwrkIS394xqg9p5sYkA==
X-Received: by 2002:a9d:715d:: with SMTP id y29mr17371660otj.148.1543283827339;
        Mon, 26 Nov 2018 17:57:07 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.gmail.com with ESMTPSA id t8sm2493738otp.69.2018.11.26.17.57.06
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 26 Nov 2018 17:57:06 -0800 (PST)
Date:   Mon, 26 Nov 2018 19:57:05 -0600
From:   Rob Herring <robh@kernel.org>
To:     Hao Zhang <hao5781286@gmail.com>
Cc:     robh+dt@kernel.org, mark.rutland@arm.com,
        maxime.ripard@bootlin.com, wens@csie.org, mturquette@baylibre.com,
        sboyd@kernel.org, thierry.reding@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pwm@vger.kernel.org, linux-sunxi@googlegroups.com,
        hao5781286@gmail.com
Subject: Re: [PATCH v3 1/6] Documentation: ARM: sunxi: pwm: add Allwinner
 sun8i.
Message-ID: <20181127015705.GA17836@bogus>
References: <20181125161859.GA5277@arx-s1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181125161859.GA5277@arx-s1>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 26 Nov 2018 00:18:59 +0800, Hao Zhang wrote:
> This patch adds Allwinner sun8i pwm binding document.
> 
> Signed-off-by: Hao Zhang <hao5781286@gmail.com>
> ---
>  .../devicetree/bindings/pwm/pwm-sun8i.txt          | 24 ++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pwm/pwm-sun8i.txt
> 

Reviewed-by: Rob Herring <robh@kernel.org>
