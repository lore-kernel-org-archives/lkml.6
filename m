Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751875AbeBRXNx (ORCPT <rfc822;w@1wt.eu>);
        Sun, 18 Feb 2018 18:13:53 -0500
Received: from mail-oi0-f65.google.com ([209.85.218.65]:34498 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751689AbeBRXNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Feb 2018 18:13:51 -0500
X-Google-Smtp-Source: AH8x224zsKfB442eK0G93CT8kMPM1Edlrjpexy3mgfBWlJCj2Jd+xxi59R6OqgKL2mTY8UM5ZDc5cw==
Date: Sun, 18 Feb 2018 17:13:49 -0600
From: Rob Herring <robh@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Wim Van Sebroeck <wim@iguana.be>, Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>, linux-watchdog@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] watchdog: imx2_wdt: allow setting timeout in devicetree
Message-ID: <20180218231349.k55xhl7z7wzwbbjg@rob-hp-laptop>
References: <20180208131108.3048-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180208131108.3048-1-marcus.folkesson@gmail.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 08, 2018 at 02:11:08PM +0100, Marcus Folkesson wrote:
> By following best practice described in
> Documentation/watchdog/watchdog-kernel-api.txt, it also let us to set
> timout-sec property in devicetree.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  Documentation/devicetree/bindings/watchdog/fsl-imx-wdt.txt | 2 ++
>  drivers/watchdog/imx2_wdt.c                                | 8 ++------
>  2 files changed, 4 insertions(+), 6 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
