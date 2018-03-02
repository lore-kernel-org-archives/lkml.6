Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1425334AbeCBTHx (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Mar 2018 14:07:53 -0500
Received: from mail-ot0-f174.google.com ([74.125.82.174]:38202 "EHLO
        mail-ot0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1424128AbeCBTHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Mar 2018 14:07:50 -0500
X-Google-Smtp-Source: AG47ELuNYVSnMDDZAn3NM8qwyw9OVL6a9egeHIbdNBJuFUoyQ9t3xbgb19la14DhKMor3E307eNV4A==
Date: Fri, 2 Mar 2018 13:07:47 -0600
From: Rob Herring <robh@kernel.org>
To: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
Cc: Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Tony Lindgren <tony@atomide.com>, Lee Jones <lee.jones@linaro.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        alsa-devel@alsa-project.org, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Subject: Re: [PATCHv5 1/5] dt-bindings: mfd: motorola-cpcap: document
 audio-codec
Message-ID: <20180302190747.7a3ox4cg5tsmbe33@rob-hp-laptop>
References: <20180223200254.25685-1-sebastian.reichel@collabora.co.uk>
 <20180223200254.25685-2-sebastian.reichel@collabora.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180223200254.25685-2-sebastian.reichel@collabora.co.uk>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 23, 2018 at 09:02:50PM +0100, Sebastian Reichel wrote:
> This adds the DT binding for the audio-codec sub-module found
> inside the Motorola CPCAP PMIC.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> ---
>  .../devicetree/bindings/mfd/motorola-cpcap.txt     | 42 ++++++++++++++++++++++
>  1 file changed, 42 insertions(+)

Reviewed-by: Rob Herring <robh@kernel.org>
