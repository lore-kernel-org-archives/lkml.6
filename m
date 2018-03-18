Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754572AbeCRMwm (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Mar 2018 08:52:42 -0400
Received: from mail-pl0-f68.google.com ([209.85.160.68]:34768 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754332AbeCRMwe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Mar 2018 08:52:34 -0400
X-Google-Smtp-Source: AG47ELsEXYwIMqKHoRzhLEHo6gI61biV2R2gdxvhV2R0DomzVFQxVD2HDAV+e4IBqftN8J4M5NgE3g==
Date: Sun, 18 Mar 2018 07:52:31 -0500
From: Rob Herring <robh@kernel.org>
To: =?iso-8859-1?Q?Myl=E8ne?= Josserand <mylene.josserand@bootlin.com>
Cc: lgirdwood@gmail.com, broonie@kernel.org, mark.rutland@arm.com,
        perex@perex.cz, tiwai@suse.com, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        alexandre.belloni@bootlin.com, thomas.petazzoni@bootlin.com,
        michael@amarulasolutions.com
Subject: Re: [PATCH v3 2/2] ASoC: Add bindings for PCM1789
Message-ID: <20180318031809.doznckhzraitowcz@rob-hp-laptop>
References: <20180315161825.5524-1-mylene.josserand@bootlin.com>
 <20180315161825.5524-3-mylene.josserand@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180315161825.5524-3-mylene.josserand@bootlin.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 15, 2018 at 05:18:25PM +0100, Mylène Josserand wrote:
> Add a device-tree binding for Texas Instrument's PCM1789 codec.
> For the moment, only I2C bus is supported but SPI could be added
> in future.
> 
> Signed-off-by: Mylène Josserand <mylene.josserand@bootlin.com>
> ---
>  .../devicetree/bindings/sound/pcm1789.txt          | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/pcm1789.txt

Reviewed-by: Rob Herring <robh@kernel.org>
