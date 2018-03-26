Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752709AbeCZWYl (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:24:41 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:36930 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751907AbeCZWYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:24:36 -0400
X-Google-Smtp-Source: AIpwx48NJo6kkQFrlS3UUKdCKpEw5JbpTTRU1Sq1Q+yruEXBr0s4sfYnP2zzeOyUtwm2yKrLpi9PzA==
Date: Mon, 26 Mar 2018 17:24:35 -0500
From: Rob Herring <robh@kernel.org>
To: Giulio Benetti <giulio.benetti@micronovasrl.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org,
        David Airlie <airlied@linux.ie>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, Chen-Yu Tsai <wens@csie.org>,
        Maxime Ripard <maxime.ripard@free-electrons.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 3/7] drm/panel: add panel CDTech S043WQ26H-CT7 to
 panel-simple
Message-ID: <20180326222435.uip56y2w6wetycam@rob-hp-laptop>
References: <1521662593-25468-1-git-send-email-giulio.benetti@micronovasrl.com>
 <1521662593-25468-3-git-send-email-giulio.benetti@micronovasrl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521662593-25468-3-git-send-email-giulio.benetti@micronovasrl.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 21, 2018 at 09:03:09PM +0100, Giulio Benetti wrote:
> Signed-off-by: Giulio Benetti <giulio.benetti@micronovasrl.com>
> ---
>  .../display/panel/cdtech,s043wq26h-ct7.txt         |  7 ++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 28 ++++++++++++++++++++++
>  2 files changed, 35 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/cdtech,s043wq26h-ct7.txt
> 
> diff --git a/Documentation/devicetree/bindings/display/panel/cdtech,s043wq26h-ct7.txt b/Documentation/devicetree/bindings/display/panel/cdtech,s043wq26h-ct7.txt
> new file mode 100644
> index 0000000..a22af85
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/panel/cdtech,s043wq26h-ct7.txt
> @@ -0,0 +1,7 @@
> +CDTech(H.K.) Electronics Limited 4.3" 480x272 color TFT-LCD panel
> +
> +Required properties:
> +- compatible: should be "cdtech,s043wq26h-ct7"
> +
> +This binding is compatible with the simple-panel binding, which is specified
> +in simple-panel.txt in this directory.

Same comment here.

Also, please split bindings to separate patches.

Rob
