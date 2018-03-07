Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934272AbeCGW3N (ORCPT <rfc822;w@1wt.eu>);
        Wed, 7 Mar 2018 17:29:13 -0500
Received: from mail-oi0-f45.google.com ([209.85.218.45]:36209 "EHLO
        mail-oi0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933415AbeCGW3L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Mar 2018 17:29:11 -0500
X-Google-Smtp-Source: AG47ELt4ynwew1kL8jXC8T/PREDxYXs3VDeBfbUjUzRifVYNs28QPOrd26oP1OxTLPXlbCrJqyd4/Q==
Date: Wed, 7 Mar 2018 16:29:09 -0600
From: Rob Herring <robh@kernel.org>
To: Joel Stanley <joel@jms.id.au>
Cc: Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mark Rutland <mark.rutland@arm.com>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tomer Maimon <tmaimon77@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: watchdog: Add Nuvoton NPCM
 description
Message-ID: <20180307222909.rwfvz4xjmpf2hxwa@rob-hp-laptop>
References: <20180305114541.9917-1-joel@jms.id.au>
 <20180305114541.9917-2-joel@jms.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180305114541.9917-2-joel@jms.id.au>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 05, 2018 at 10:15:40PM +1030, Joel Stanley wrote:
> These bindings describe the watchdog IP as used by the Nuvoton NPCM750
> (Poleg) BMC SoC.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---
> V2: Add optional timeout property
> ---
>  .../bindings/watchdog/nuvoton,npcm-wdt.txt         | 28 ++++++++++++++++++++++
>  1 file changed, 28 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/watchdog/nuvoton,npcm-wdt.txt

Reviewed-by: Rob Herring <robh@kernel.org>
