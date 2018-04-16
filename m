Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753478AbeDPTYq (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 15:24:46 -0400
Received: from mail-oi0-f68.google.com ([209.85.218.68]:38789 "EHLO
        mail-oi0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752829AbeDPTYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 15:24:44 -0400
X-Google-Smtp-Source: AIpwx48ZUZ0tCIuJnnFNzZLIXtaFs/Z+xD7d5fqIZ8LYZsiCg0EocxAhPPIw0P6KB4Iwgd301Atodw==
Date: Mon, 16 Apr 2018 14:24:42 -0500
From: Rob Herring <robh@kernel.org>
To: Lukasz Majewski <lukma@denx.de>
Cc: Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>, dri-devel@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] display: panel: Add KOE tx14d24vm1bpa display support
 (320x240)
Message-ID: <20180416192442.qnb53b6u3bsfet6y@rob-hp-laptop>
References: <20180412143715.6828-1-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180412143715.6828-1-lukma@denx.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 12, 2018 at 04:37:15PM +0200, Lukasz Majewski wrote:
> This commit adds support for KOE's 5.7" display.
> 
> Signed-off-by: Lukasz Majewski <lukma@denx.de>
> ---
>  .../bindings/display/panel/koe,tx14d24vm1bpa.txt   | 42 ++++++++++++++++++++++
>  drivers/gpu/drm/panel/panel-simple.c               | 26 ++++++++++++++
>  2 files changed, 68 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/display/panel/koe,tx14d24vm1bpa.txt

Reviewed-by: Rob Herring <robh@kernel.org>
