Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753347AbeDPTXo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 15:23:44 -0400
Received: from mail-ot0-f195.google.com ([74.125.82.195]:38488 "EHLO
        mail-ot0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753239AbeDPTXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 15:23:43 -0400
X-Google-Smtp-Source: AIpwx4+NWKTFmraRCdjhL/xEUZG9J1SUqdV248nDViWakpT2HdDQWTDRKcf4jS/F+XYXAOG+cIA/5w==
Date: Mon, 16 Apr 2018 14:23:41 -0500
From: Rob Herring <robh@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] doc: Add vendor prefix for Kaohsiung
Message-ID: <20180416192341.4fhy674fprei3zlu@rob-hp-laptop>
References: <20180412143401.6433-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412143401.6433-1-lukma@denx.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 04:34:01PM +0200, Lukasz Majewski wrote:
> The 'kao' entry has been added to vendor-prefixes.txt to indicate
> products from Kaohsiung Opto-Electronics Inc.

kao or...

> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/vendor-prefixes.txt b/Documentation/devicetree/bindings/vendor-prefixes.txt
> index 8ff7eadc8bef..f995a876d2cc 100644
> --- a/Documentation/devicetree/bindings/vendor-prefixes.txt
> +++ b/Documentation/devicetree/bindings/vendor-prefixes.txt
> @@ -184,6 +184,7 @@ khadas	Khadas
>  kiebackpeter    Kieback & Peter GmbH
>  kinetic Kinetic Technologies
>  kingnovel	Kingnovel Technology Co., Ltd.
> +koe	Kaohsiung Opto-Electronics Inc.

koe?

>  kosagi	Sutajio Ko-Usagi PTE Ltd.
>  kyo	Kyocera Corporation
>  lacie	LaCie
> -- 
> 2.11.0
> 
