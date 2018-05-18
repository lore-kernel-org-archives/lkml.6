Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752141AbeERPLu (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 11:11:50 -0400
Received: from mail-oi0-f67.google.com ([209.85.218.67]:41224 "EHLO
        mail-oi0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750841AbeERPLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 11:11:45 -0400
X-Google-Smtp-Source: AB8JxZpLmD7eIfAGIBaTcTtkd8ID9gLXS8DPeksShv8UUiG/VfJP7IZDiYZhPiZ/TpyT7Hi9sTQ2Rw==
Date: Fri, 18 May 2018 10:11:43 -0500
From: Rob Herring <robh@kernel.org>
To: Dan Murphy <dmurphy@ti.com>
Cc: mark.rutland@arm.com, jacek.anaszewski@gmail.com, pavel@ucw.cz,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-leds@vger.kernel.org
Subject: Re: [PATCH v6 1/2] dt: bindings: lm3601x: Introduce the lm3601x
 driver
Message-ID: <20180518151143.GA13110@rob-hp-laptop>
References: <20180515154352.20263-1-dmurphy@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180515154352.20263-1-dmurphy@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 15, 2018 at 10:43:51AM -0500, Dan Murphy wrote:
> Introduce the device tree bindings for the lm3601x
> family of LED torch, flash and IR drivers.
> 
> Signed-off-by: Dan Murphy <dmurphy@ti.com>
> ---
> 
> v6 - Removed multiple led child nodes, fixed example to display micro ranges
> for corresponding child nodes and added led-sources to define the current driver -
> https://patchwork.kernel.org/patch/10392121/
> 
> v5 - No changes - https://patchwork.kernel.org/patch/10391743/
> v4 - Added " " around "=", changed strobe to flash on label, removed "support and
> register" comment and change ir lable to ir:torch - See v2 patchworks for comments
> v3 - Removed wildcard compatible - https://patchwork.kernel.org/patch/10386241/
> v2 - No changes - https://patchwork.kernel.org/patch/10384587/
> 
>  .../devicetree/bindings/leds/leds-lm3601x.txt | 47 +++++++++++++++++++
>  1 file changed, 47 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/leds-lm3601x.txt

Reviewed-by: Rob Herring <robh@kernel.org>
