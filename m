Return-Path: <SRS0=o3h7=QU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57C2AC282C2
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:55:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 238D52086C
	for <linux-kernel@archiver.kernel.org>; Wed, 13 Feb 2019 17:55:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1550080539;
	bh=mzOeovzamvkxdP8MQLu4eGQgRa6Mt95/laR5yOxjrMk=;
	h=To:In-Reply-To:Subject:References:Cc:From:Date:List-ID:From;
	b=RI7vTIbiMctjlpFNY96dhSn5Bzg7CgdYspym10TdyYCWRNjVywB69+a0uGG8RPeQZ
	 y6iCLQKZRsv3bKxLYKDATlyNNRthNI2mWvXLlRu1Tfu1CHa69Dyn2M5HhhPlFKFjyE
	 sbmDVRL039jrI0lsxiWLeDlGZIUODZu3JV8btYFE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404751AbfBMRzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 Feb 2019 12:55:37 -0500
Received: from mail.kernel.org ([198.145.29.99]:46086 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2404737AbfBMRzg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Feb 2019 12:55:36 -0500
Received: from localhost (unknown [104.132.0.74])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 409E9222B1;
        Wed, 13 Feb 2019 17:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1550080535;
        bh=mzOeovzamvkxdP8MQLu4eGQgRa6Mt95/laR5yOxjrMk=;
        h=To:In-Reply-To:Subject:References:Cc:From:Date:From;
        b=zZ/MEZ0F3A8vE6MMsaId4cTj5Yj9ImX5wdqW7RRBFuBArAVn9GwukZNJUgSCo6IwU
         roQB3H3MumD8b9muXyYrKTWpqVsprWmsXCVWfRb4yv+ffsRp3Ic5PYhTfA2Oag92Aw
         kyYrWT+aExW9Yl+A9FUr5CcMFcb9z8HnwO0nycYA=
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
To:     Sugaya Taichi <sugaya.taichi@socionext.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1549628823-31388-1-git-send-email-sugaya.taichi@socionext.com>
User-Agent: alot/0.8
Subject: Re: [PATCH v2 07/15] ndings: clock: milbeaut: add Milbeaut clock description
Message-ID: <155008053444.115909.15767350529461671558@swboyd.mtv.corp.google.com>
References: <1549628823-31388-1-git-send-email-sugaya.taichi@socionext.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Takao Orito <orito.takao@socionext.com>,
        Kazuhiro Kasai <kasai.kazuhiro@socionext.com>,
        Shinji Kanematsu <kanematsu.shinji@socionext.com>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Sugaya Taichi <sugaya.taichi@socionext.com>
From:   Stephen Boyd <sboyd@kernel.org>
Date:   Wed, 13 Feb 2019 09:55:34 -0800
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The subject seems to have been cut off? "ndings"?

Quoting Sugaya Taichi (2019-02-08 04:27:03)
> diff --git a/Documentation/devicetree/bindings/clock/milbeaut-clock.txt b=
/Documentation/devicetree/bindings/clock/milbeaut-clock.txt
> new file mode 100644
> index 0000000..bcfc5df
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/milbeaut-clock.txt
> @@ -0,0 +1,49 @@
> +Milbeaut SoCs Clock Controller Binding
> +----------------------------------------
> +Milbeaut SoCs Clock controller is an integrated clock controller, which
> +generates and supplies to all modules.
> +
> +This binding uses common clock bindings
> +[1] Documentation/devicetree/bindings/clock/clock-bindings.txt
> +
> +Required properties:
> +- compatible: should be one of the following:
> +    "socionext,milbeaut-m10v-ccu" - for M10V SoC
> +- reg: shall contain base address and length of clock registers
> +- #clock-cells: shall be 1
> +- clocks: shall be an external clock
> +
> +Example: Clock controller node:
> +
> +       clk: m10v-clk-ctrl@1d021000 {
> +               compatible =3D "socionext,milbeaut-m10v-clk-ccu";

I thought there was some length limit on compatible string names. 32
bytes? Just barely under!

