Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753401AbeC1NWP (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 09:22:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:53216 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751072AbeC1NWN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 09:22:13 -0400
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1507B217D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=robh+dt@kernel.org
X-Google-Smtp-Source: AIpwx49LIwavn1GxDIVq7ldVXfXskOkhQa9R8HFRp3k01/yhgWKywhryJ6/XmhxWFN6pNQ5H8hWcxcGyvVwzJ7SQsRI=
MIME-Version: 1.0
In-Reply-To: <1522207358-8388-1-git-send-email-Anson.Huang@nxp.com>
References: <1522207358-8388-1-git-send-email-Anson.Huang@nxp.com>
From: Rob Herring <robh+dt@kernel.org>
Date: Wed, 28 Mar 2018 08:21:51 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK4pmAzvJAFg5EfCdBiEywnaCy_gJ0-J7FwkPk9i8shBQ@mail.gmail.com>
Message-ID: <CAL_JsqK4pmAzvJAFg5EfCdBiEywnaCy_gJ0-J7FwkPk9i8shBQ@mail.gmail.com>
Subject: Re: [PATCH V2 1/4] dt-bindings: timer: tpm: fix typo of clock name
To: Anson Huang <Anson.Huang@nxp.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>,
        NXP Linux Team <Linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 27, 2018 at 10:22 PM, Anson Huang <Anson.Huang@nxp.com> wrote:
> The clock name should be ipg instead of igp.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  Documentation/devicetree/bindings/timer/nxp,tpm-timer.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
