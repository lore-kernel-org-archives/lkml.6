Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934664AbeCHCAm (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 21:00:42 -0500
Received: from mail-ot0-f196.google.com ([74.125.82.196]:44810 "EHLO
        mail-ot0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933351AbeCHCAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 21:00:40 -0500
X-Google-Smtp-Source: AG47ELtexvDj/2kRDhNXe085YT9ycZrOGjwd+1pP8rEh/Pw7XNklQfxhFvGLdU2aAUjLPkBM/y1+Eg==
Date: Wed, 7 Mar 2018 20:00:38 -0600
From: Rob Herring <robh@kernel.org>
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: Zhang Rui <rui.zhang@intel.com>,
        Eduardo Valentin <edubezval@gmail.com>,
        Krzysztof Kozlowski <krzk@kernel.org>, Kukjin Kim <kgene@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 11/12] dt-bindings: thermal: remove no longer needed
 samsung thermal properties
Message-ID: <20180308020038.3yhihjqa5m4pugjx@rob-hp-laptop>
References: <1520347435-22970-1-git-send-email-b.zolnierkie@samsung.com>
 <CGME20180306144516epcas1p3e951e15e666779c870ad091d65041409@epcas1p3.samsung.com>
 <1520347435-22970-12-git-send-email-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1520347435-22970-12-git-send-email-b.zolnierkie@samsung.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 06, 2018 at 03:43:54PM +0100, Bartlomiej Zolnierkiewicz wrote:
> Remove documentation for longer needed samsung thermal properties.
> 
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
>  .../devicetree/bindings/thermal/exynos-thermal.txt | 23 +++++-----------------
>  1 file changed, 5 insertions(+), 18 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
