Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752411AbeFEUBV (ORCPT <rfc822;w@1wt.eu>);
        Tue, 5 Jun 2018 16:01:21 -0400
Received: from mail-yw0-f195.google.com ([209.85.161.195]:35563 "EHLO
        mail-yw0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751959AbeFEUBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jun 2018 16:01:19 -0400
X-Google-Smtp-Source: ADUXVKIhV3GbfMK61lXvQwEmTDPmLWTuoHbz32OfaaZqEEy7dFDuIMywHBiBLOdjlY1RqTKkLYGY0w==
Date: Tue, 5 Jun 2018 14:01:15 -0600
From: Rob Herring <robh@kernel.org>
To: avifishman70@gmail.com
Cc: gregkh@linuxfoundation.org, stern@rowland.harvard.edu,
        tmaimon77@gmail.com, venture@google.com, yuenn@google.com,
        brendanhiggins@google.com, mathias.nyman@linux.intel.com,
        bjorn.andersson@linaro.org, jhogan@kernel.org, albeu@free.fr,
        chunfeng.yun@mediatek.com, tony@atomide.com, baolu.lu@linux.intel.com,
        elder@linaro.org, digetx@gmail.com, kstewart@linuxfoundation.org,
        hdegoede@redhat.com, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, openbmc@lists.ozlabs.org,
        mark.rutland@arm.com, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 2/3] USB: DT probing support to ehci-npcm7xx
Message-ID: <20180605200115.GA20061@rob-hp-laptop>
References: <1527788430-12494-1-git-send-email-avifishman70@gmail.com>
 <1527788430-12494-3-git-send-email-avifishman70@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1527788430-12494-3-git-send-email-avifishman70@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 31, 2018 at 08:40:29PM +0300, avifishman70@gmail.com wrote:
> From: Avi Fishman <AviFishman70@gmail.com>

The subject sounds like a driver change, not a binding doc. To start 
with, the subject prefix should be "dt-bindings: usb: ..."

> Device Tree documentation for Nuvoton npcm7xx EHCI.
> 
> Signed-off-by: Avi Fishman <AviFishman70@gmail.com>
> ---
>  Documentation/devicetree/bindings/usb/npcm7xx-usb.txt | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/usb/npcm7xx-usb.txt

Otherwise,

Reviewed-by: Rob Herring <robh@kernel.org>
