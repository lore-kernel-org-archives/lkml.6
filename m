Return-Path: <robherring2@gmail.com>
X-Cyrus-Session-Id: sloti22d1t05-4163989-1523640297-2-11725632538113848115
X-Sieve: CMU Sieve 3.0
X-Spam-known-sender: no
X-Spam-score: 0.0
X-Spam-hits: BAYES_00 -1.9, FREEMAIL_ENVFROM_END_DIGIT 0.25,
  FREEMAIL_FORGED_FROMDOMAIN 0.25, FREEMAIL_FROM 0.001,
  HEADER_FROM_DIFFERENT_DOMAINS 0.25, RCVD_IN_DNSWL_NONE -0.0001,
  RCVD_IN_MSPIKE_H3 -0.01, RCVD_IN_MSPIKE_WL -0.01, SPF_PASS -0.001,
  LANGUAGES encafr, BAYES_USED global, SA_VERSION 3.4.0
X-Spam-source: IP='74.125.82.196', Host='mail-ot0-f196.google.com', Country='US',
  FromHeader='org', MailFrom='com'
X-Spam-charsets: plain='us-ascii'
X-Resolved-to: greg@kroah.com
X-Delivered-to: greg@kroah.com
X-Mail-from: robherring2@gmail.com
ARC-Seal: i=1; a=rsa-sha256; cv=none; d=messagingengine.com; s=fm2; t=
    1523640296; b=ufQz1uGER/cMaSkLadWUJoj47T+kQu/WPpcmN9P1fuj2q/zY/G
    Tv7On/HeALUjie0yVcivseWrhGcMHCpsT+X1NxiyPnddUzoWIn4AxTXu3w2Al007
    iE8xfdH5f1IlGJDTNmNRZoYZZWoOSnyS2WgZHYKmqGTHhQfXMTzM7HbEwbKr5x/B
    NgCt5+Ho2DrJKpA+qFqmrUZcLyO2p6df/lluU3j6xIlnI4Y2JBMDEDn16+T8F2fA
    DDNwm5qYcnM6RhgMGPRZOS+/8EHusPqwogU9H/DO3E2HK6FtGH6iPIjk6wkvKHLN
    WT1faGj8V54x4eqSGSyYhZn3iMcrH5gyzo6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=
    messagingengine.com; h=date:from:to:cc:subject:message-id
    :references:mime-version:content-type:in-reply-to; s=fm2; t=
    1523640296; bh=LjwUWG0W/A1J2SlnzB0SNC8CW88cDfyLP9UhjFJLYJM=; b=R
    Hww7vrs2LPGD+DJGC1T5vgI2LohiynUs5xYQk0b0qlQzxGBYDq7+fwbhAuDHkQ9c
    HDlSJ+c4UfzvrCTXQroAb89X0nsAV70h0O9T0WyFmd7+VNaUb1VRDljaqSOKF4KA
    It65ldR+uMUOnF9utxzRu0CKd7a+KBLb/B4ncGoMf1J8z5I0j8wccncgKFuVQ89u
    kaVoAtf3YH9tXfwdfV/Doczr+V6oGbLAz0FdVibI02JN9A/1y57uwd4vezerPS5i
    0MxPSXOIFEG5PF5YoE+IiqDKGSOT5cCiBZmpERoXcUwInAb5Pe0uls78wzgJBG22
    gGFy1KAD4oeZcKnTxhvdA==
ARC-Authentication-Results: i=1; mx2.messagingengine.com; arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=74.125.82.196 (mail-ot0-f196.google.com);
    spf=pass smtp.mailfrom=robherring2@gmail.com smtp.helo=mail-ot0-f196.google.com;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sbvKFzID;
    x-ptr=pass x-ptr-helo=mail-ot0-f196.google.com x-ptr-lookup=mail-ot0-f196.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
Authentication-Results: mx2.messagingengine.com;
    arc=none (no signatures found);
    dkim=none (no signatures found);
    dmarc=none (p=none,d=none) header.from=kernel.org;
    iprev=pass policy.iprev=74.125.82.196 (mail-ot0-f196.google.com);
    spf=pass smtp.mailfrom=robherring2@gmail.com smtp.helo=mail-ot0-f196.google.com;
    x-aligned-from=fail;
    x-cm=none score=0;
    x-google-dkim=pass (2048-bit rsa key) header.d=1e100.net header.i=@1e100.net header.b=sbvKFzID;
    x-ptr=pass x-ptr-helo=mail-ot0-f196.google.com x-ptr-lookup=mail-ot0-f196.google.com;
    x-return-mx=pass smtp.domain=gmail.com smtp.result=pass smtp_is_org_domain=yes header.domain=kernel.org header.result=pass header_is_org_domain=yes;
    x-tls=pass version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128;
    x-vs=clean score=0 state=0
X-ME-VSCategory: clean
X-CM-Envelope: MS4wfOVJi/VbQkXkWm9zYOi6tFIq3ma0GH+5bgVRWPM9nJMFYzlvyTpa71+tzI2049qK9nakgm3mWe6pvulcaZG8yWEOPZv3XdLQIUw9gBYQLP2VX/RfaxfM
    Y4wAzvMnMTfKzfPU8zDnA4dlakDHAlaSuy4hbw3tmA2b/Of0X7dmSpp0jtD6UJGvTMcMGdG9rgTF8tiTpeG7yVTagK9OAlHUwDo=
X-CM-Analysis: v=2.3 cv=E8HjW5Vl c=1 sm=1 tr=0 a=rKuKgrJtuVtuZiXyUMzdmg==:117
    a=S9Yh29hGjA0mksVP5FvCIw==:17 a=kj9zAlcOel0A:10 a=Kd1tUaAdevIA:10
    a=l0hiEBf7AAAA:8 a=VwQbUJbxAAAA:8 a=4rqkTYGcxANBfacGQGwA:9 a=CjuIK1q_8ugA:10
    a=ynCB8LqupOr-u-Kv-6Up:22 a=AjGcO6oz07-iQ99wixmX:22
X-ME-CMScore: 0
X-ME-CMCategory: none
X-Google-Smtp-Source: AIpwx4+Q/3HDZnONzkaU/zxUBWDDd/znN6nBJ5ZzI6cSkqkVM7J88IMzAQSmwaAvlWkZo8RBhQv2Sg==
Date: Fri, 13 Apr 2018 12:24:53 -0500
From: Rob Herring <robh@kernel.org>
To: ShuFan Lee <leechu729@gmail.com>
Cc: greg@kroah.com, heikki.krogerus@linux.intel.com, linux@roeck-us.net,
	mark.rutland@arm.com, shufan_lee@richtek.com, cy_huang@richtek.com,
	jun.li@nxp.com, mats.dev.list@gmail.com,
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v5 2/2] dt-bindings: usb: rt1711h device tree binding
 document
Message-ID: <20180413172453.55zjfuvud6r5wtrd@rob-hp-laptop>
References: <1523239895-4467-1-git-send-email-leechu729@gmail.com>
 <1523239895-4467-3-git-send-email-leechu729@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1523239895-4467-3-git-send-email-leechu729@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
X-getmail-retrieved-from-mailbox: INBOX
X-Mailing-List: linux-kernel@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>

On Mon, Apr 09, 2018 at 10:11:35AM +0800, ShuFan Lee wrote:
> From: ShuFan Lee <shufan_lee@richtek.com>
> 
> Add device tree binding document for Richtek RT1711H Type-C chip driver
> 
> Signed-off-by: ShuFan Lee <shufan_lee@richtek.com>
> ---
>  .../devicetree/bindings/usb/richtek,rt1711h.txt         | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/richtek,rt1711h.txt

Reviewed-by: Rob Herring <robh@kernel.org>
