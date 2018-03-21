Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752859AbeCUQrK (ORCPT <rfc822;w@1wt.eu>);
        Wed, 21 Mar 2018 12:47:10 -0400
Received: from mail-lf0-f49.google.com ([209.85.215.49]:32780 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751669AbeCUQrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Mar 2018 12:47:03 -0400
X-Google-Smtp-Source: AG47ELtot0oPcMX7WLX8FxSF0nKEO6Ziv51uSec4d8cOh5O6cz7JTL8FaAIJJ8u1a3D58hIPRM08Z0ieLwMZTm+x2kM=
MIME-Version: 1.0
In-Reply-To: <20180321152904.22411-9-paul.kocialkowski@bootlin.com>
References: <20180321152904.22411-1-paul.kocialkowski@bootlin.com> <20180321152904.22411-9-paul.kocialkowski@bootlin.com>
From: Daniel Stone <daniel@fooishbar.org>
Date: Wed, 21 Mar 2018 16:47:01 +0000
Message-ID: <CAPj87rPNgga_pspx_0kTiP4itWUOL3O++2ZCiTUFfNBDGzkd0w@mail.gmail.com>
Subject: Re: [PATCH 08/10] drm/fourcc: Add definitions for Allwinner vendor
 and MB32 tiled format
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-arm-kernel@lists.infradead.org,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        David Airlie <airlied@linux.ie>, Chen-Yu Tsai <wens@csie.org>,
        Daniel Vetter <daniel.vetter@intel.com>,
        Gustavo Padovan <gustavo@padovan.org>,
        Sean Paul <seanpaul@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Paul,

On 21 March 2018 at 15:29, Paul Kocialkowski
<paul.kocialkowski@bootlin.com> wrote:
> +/*
> + * Allwinner "MB32" tiled format
> + *
> + * This is the primary layout coming out of the VPU, where pixels are tiled
> + * 32x32.
> + */

Can you please be a bit more specific here, following the other
examples? In particular, it should list whether the tile order is row-
or column-major.

Cheers,
Daniel
