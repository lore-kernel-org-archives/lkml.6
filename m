Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754561AbeCRM4g (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:56:36 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:43097 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754511AbeCRMwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:52:19 -0400
X-Google-Smtp-Source: AG47ELvv8arnhrylehIUbHQYSpyC//SJ/uhZN2sS9rUJSmabgq+pKO8YSdop/7CoUdvsuBdoSRyYPw==
Date: Sun, 18 Mar 2018 07:52:17 -0500
From: Rob Herring <robh@kernel.org>
To: Chen-Yu Tsai <wens@csie.org>
Cc: Maxime Ripard <maxime.ripard@bootlin.com>,
        Mark Rutland <mark.rutland@arm.com>, David Airlie <airlied@linux.ie>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/8] drm/sun4i: Add compatible strings for the A80
 display pipeline
Message-ID: <20180318125217.hhokfxwmccluyjkq@rob-hp-laptop>
References: <20180315114136.24747-1-wens@csie.org>
 <20180315114136.24747-5-wens@csie.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180315114136.24747-5-wens@csie.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 07:41:32PM +0800, Chen-Yu Tsai wrote:
> This patch adds compatible strings for the remaining documented
> components of the Allwinner A80 display pipeline.
> 
> Signed-off-by: Chen-Yu Tsai <wens@csie.org>
> ---
>  Documentation/devicetree/bindings/display/sunxi/sun4i-drm.txt | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
