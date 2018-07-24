Return-Path: <SRS0=hTZH=KI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15BE3C28CF6
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:00:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD51120880
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Jul 2018 20:00:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD51120880
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-kernel-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388695AbeGXVI0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Jul 2018 17:08:26 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:45037 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388466AbeGXVI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jul 2018 17:08:26 -0400
Received: by mail-ed1-f67.google.com with SMTP id f23-v6so5136130edr.11;
        Tue, 24 Jul 2018 13:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=o+6etfhMf0YuFoC2tElGN9Ch+OyTu4cH8W1qO2y4+zY=;
        b=Ugoy+Cpb33hdC6aeGF7Ed70l6atcs7rkF5Khf/zOd/1X7uVT0hVZJJjAhn7q5Uu8hi
         z30SKIIacHbNkNz4XyPEAhCTCjFyuSi/NbuguFOuM9kBG6sM0yCT1NISRrSQ+ALFH86T
         5xWWZ+lQ1yt3oBOcqS/gzWQpMThkpXrgMTzUPTUKCP+0SnYS5XP0JJMRF5uhvQDEEpPt
         Dgkc6lVE0cgx3wW1RbIWpmNTpFwFdVy0b4On2f4XlvQ2dw2mcxLSzykZxycBBroizy2P
         de7gkOoEJ7BcJGVZuauM0R5ZwM0lOWT91wkm3PxoTWJYon8ZxYNK4H9hnCkTQp7m4CSR
         sm/A==
X-Gm-Message-State: AOUpUlGd/7VBaaKBRQEy4s6/juZNNGyg4NDjo6e6YQZ4PCxgRTSplNga
        WGsHqQvMlmnp3elWsXxDVEw=
X-Google-Smtp-Source: AAOMgpcAqe/7PLv0XCVOYLPr0sD88tyUJyZ8fUdeLE/znv0m43jKF/tkT4hf8XLsSfruMyVtXLxGuw==
X-Received: by 2002:a50:b3c8:: with SMTP id t8-v6mr19992322edd.95.1532462421094;
        Tue, 24 Jul 2018 13:00:21 -0700 (PDT)
Received: from kozik-lap (xdsl-188-155-58-14.adslplus.ch. [188.155.58.14])
        by smtp.googlemail.com with ESMTPSA id s21-v6sm5355862edr.62.2018.07.24.13.00.19
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 24 Jul 2018 13:00:20 -0700 (PDT)
Date:   Tue, 24 Jul 2018 22:00:18 +0200
From:   Krzysztof Kozlowski <krzk@kernel.org>
To:     Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: pinctrl: samsung: Add SPDX license
 identifier
Message-ID: <20180724200018.mg6f55dxmgax5dtw@kozik-lap>
References: <20180718200350.6590-1-krzk@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180718200350.6590-1-krzk@kernel.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 18, 2018 at 10:03:50PM +0200, Krzysztof Kozlowski wrote:
> Replace GPL license statement with SPDX license identifier (GPL-2.0).
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---
>  include/dt-bindings/pinctrl/samsung.h | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)

Applied.

Best regards,
Krzysztof

