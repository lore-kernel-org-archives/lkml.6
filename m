Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751770AbeEBQhW (ORCPT <rfc822;w@1wt.eu>);
        Wed, 2 May 2018 12:37:22 -0400
Received: from mail-ua0-f178.google.com ([209.85.217.178]:42596 "EHLO
        mail-ua0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751529AbeEBQhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 May 2018 12:37:19 -0400
X-Google-Smtp-Source: AB8JxZotRSHff6/a2sVBdyV7hxqF586hx63rKD5qt68MatqCV4BrrakjdcH4c3Y6b8e1WfesuC/8KeKTy2utKyxojOY=
MIME-Version: 1.0
In-Reply-To: <39b676d2ba7dac2436196cc5a090c6f151498dc8.1523673467.git.collinsd@codeaurora.org>
References: <cover.1523673467.git.collinsd@codeaurora.org> <39b676d2ba7dac2436196cc5a090c6f151498dc8.1523673467.git.collinsd@codeaurora.org>
From: Doug Anderson <dianders@chromium.org>
Date: Wed, 2 May 2018 09:37:15 -0700
X-Google-Sender-Auth: t9jarKAORBNoX-7y9_RO95rpgQw
Message-ID: <CAD=FV=UDUKg58xe+3C5QUbFwFkO8d3c_tzxmfPDzdv1KXZ3W9g@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] regulator: dt-bindings: add QCOM RPMh regulator bindings
To: David Collins <collinsd@codeaurora.org>
Cc: Mark Brown <broonie@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        linux-arm-msm@vger.kernel.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        devicetree@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, Apr 13, 2018 at 7:50 PM, David Collins <collinsd@codeaurora.org> wrote:
> +- vdd_l26-supply
> +- vdd_lvs1_lvs2-supply
> +- vdd_lvs1_lvs2-supply
> +       Usage:      optional (PM8998 only)
> +       Value type: <phandle>
> +       Definition: phandle of the parent supply regulator of one or more of the
> +                   regulators for this PMIC.

One small additional nit here is that "vdd_lvs1_lvs2-supply" is listed twice.

Also on the schematics (and in the PM8998 datasheet) I have this is
"VIN_LVS_1_2".  It seems like you should be consistent here and call
this "vin-lvs-1-2-supply".

-Doug
