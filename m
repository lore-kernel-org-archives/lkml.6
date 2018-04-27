Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759225AbeD0UPI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 27 Apr 2018 16:15:08 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:39079 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758945AbeD0UPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Apr 2018 16:15:06 -0400
X-Google-Smtp-Source: AB8JxZoT2REZ5MfI/a8gPUjj0Fseec+Bc9MyE1jJ4xBqeFmDk8z3D2vXQH0iOA9VJAHveBW8Smd7HQ==
Date: Fri, 27 Apr 2018 15:15:05 -0500
From: Rob Herring <robh@kernel.org>
To: Jean-Jacques Hiblot <jjhiblot@ti.com>
Cc: broonie@kernel.org, mark.rutland@arm.com, perex@perex.cz,
        tiwai@suse.com, dannenberg@ti.com, afd@ti.com,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] ASoC: tas6424: Add support for the mute pin
Message-ID: <20180427201505.3wseaug6v2uak5mf@rob-hp-laptop>
References: <1524837349-16350-1-git-send-email-jjhiblot@ti.com>
 <1524837349-16350-3-git-send-email-jjhiblot@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524837349-16350-3-git-send-email-jjhiblot@ti.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 27, 2018 at 03:55:48PM +0200, Jean-Jacques Hiblot wrote:
> mute can be connected to GPIO. In that case we have to drive it to the
> correct value
> 
> Signed-off-by: Jean-Jacques Hiblot <jjhiblot@ti.com>
> ---
>  .../devicetree/bindings/sound/ti,tas6424.txt       |  1 +
>  sound/soc/codecs/tas6424.c                         | 37 +++++++++++++++++++++-
>  2 files changed, 37 insertions(+), 1 deletion(-)

Reviewed-by: Rob Herring <robh@kernel.org>
