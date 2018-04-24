Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752056AbeDXQiC (ORCPT <rfc822;w@1wt.eu>);
        Tue, 24 Apr 2018 12:38:02 -0400
Received: from mail-oi0-f53.google.com ([209.85.218.53]:41988 "EHLO
        mail-oi0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750814AbeDXQh6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Apr 2018 12:37:58 -0400
X-Google-Smtp-Source: AIpwx48/rluif37Sb4ckVqN5G0xehWMfQIf4Djygzy0AQizzpJ3MUnuVNg/d83w5EkOu6mSXn9HuEA==
Date: Tue, 24 Apr 2018 11:37:57 -0500
From: Rob Herring <robh@kernel.org>
To: Jacopo Mondi <jacopo+renesas@jmondi.org>
Cc: architt@codeaurora.org, a.hajda@samsung.com,
        Laurent.pinchart@ideasonboard.com, airlied@linux.ie, daniel@ffwll.ch,
        peda@axentia.se, linux-renesas-soc@vger.kernel.org,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/8] dt-bindings: display: bridge: thc63lvd1024: Add lvds
 map property
Message-ID: <20180424163757.tonxzoyofnvohgv3@rob-hp-laptop>
References: <1524130269-32688-1-git-send-email-jacopo+renesas@jmondi.org>
 <1524130269-32688-3-git-send-email-jacopo+renesas@jmondi.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1524130269-32688-3-git-send-email-jacopo+renesas@jmondi.org>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 19, 2018 at 11:31:03AM +0200, Jacopo Mondi wrote:
> The THC63LVD1024 LVDS to RGB bridge supports two different input mapping
> modes, selectable by means of an external pin.
> 
> Describe the LVDS mode map through a newly defined mandatory property in
> device tree bindings.
> 
> Signed-off-by: Jacopo Mondi <jacopo+renesas@jmondi.org>
> ---
>  .../devicetree/bindings/display/bridge/thine,thc63lvd1024.txt          | 3 +++
>  1 file changed, 3 insertions(+)

+1 for what Laurent said.

Reviewed-by: Rob Herring <robh@kernel.org>
