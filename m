Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0A87C169C4
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:37:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A02021473
	for <linux-kernel@archiver.kernel.org>; Tue, 29 Jan 2019 13:37:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728811AbfA2Nhb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 29 Jan 2019 08:37:31 -0500
Received: from gloria.sntech.de ([185.11.138.130]:35502 "EHLO gloria.sntech.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727544AbfA2Nh3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Jan 2019 08:37:29 -0500
Received: from ip5f5a6320.dynamic.kabel-deutschland.de ([95.90.99.32] helo=diego.localnet)
        by gloria.sntech.de with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <heiko@sntech.de>)
        id 1goTZs-0000y2-IA; Tue, 29 Jan 2019 14:37:24 +0100
From:   Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko@sntech.de>
To:     thierry.reding@gmail.com
Cc:     airlied@linux.ie, robh+dt@kernel.org, mark.rutland@arm.com,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: display: add binding for Innolux ee101ia-01d panel
Date:   Tue, 29 Jan 2019 14:37:23 +0100
Message-ID: <5825168.ASgtykK0VC@diego>
In-Reply-To: <20181113124205.29319-1-heiko@sntech.de>
References: <20181113124205.29319-1-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thierry,

Am Dienstag, 13. November 2018, 13:42:05 CET schrieb Heiko Stuebner:
> From: Heiko Stuebner <heiko.stuebner@bq.com>
> 
> This is a panel handled through the generic lvds-panel binding,
> so only needs its additional compatible specified.
> 
> Signed-off-by: Heiko Stuebner <heiko.stuebner@bq.com>

just pulling this pending patch out of the woodworks again too :-)

Thanks in advance for considering it.
Heiko

> ---
>  .../bindings/display/panel/innolux,ee101ia-01d.txt         | 7 +++++++
>  1 file changed, 7 insertions(+)
>  create mode 100644
> Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.txt
> 
> diff --git
> a/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.txt
> b/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.txt
> new file mode 100644
> index 000000000000..e5ca4ccd55ed
> --- /dev/null
> +++
> b/Documentation/devicetree/bindings/display/panel/innolux,ee101ia-01d.txt
> @@ -0,0 +1,7 @@
> +Innolux Corporation 10.1" EE101IA-01D WXGA (1280x800) LVDS panel
> +
> +Required properties:
> +- compatible: should be "innolux,ee101ia-01d"
> +
> +This binding is compatible with the lvds-panel binding, which is specified
> +in panel-lvds.txt in this directory.




