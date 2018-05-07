Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753189AbeEGUy6 (ORCPT <rfc822;w@1wt.eu>);
        Mon, 7 May 2018 16:54:58 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:42636 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752709AbeEGUy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 May 2018 16:54:56 -0400
X-Google-Smtp-Source: AB8JxZo97OHcYWSJnEikrQ8YcKg6149AH25EUwjws30KoSKRM11JElVlYBUwHsgAP/hcAVFD+2+b1g==
Date: Mon, 7 May 2018 15:54:55 -0500
From: Rob Herring <robh@kernel.org>
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Johan Hovold <johan@kernel.org>, afd@ti.com,
        Mark Rutland <mark.rutland@arm.com>,
        =?iso-8859-1?Q?Beno=EEt?= Cousson <bcousson@baylibre.com>,
        Tony Lindgren <tony@atomide.com>, Russell King <linux@armlinux.org.uk>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Thierry Reding <treding@nvidia.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Noralf =?iso-8859-1?Q?Tr=F8nnes?= <noralf@tronnes.org>,
        David Lechner <david@lechnology.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org,
        letux-kernel@openphoenux.org, kernel@pyra-handheld.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v7 1/6] dt-bindings: define vendor prefix for Wi2Wi, Inc.
Message-ID: <20180507205455.GA28316@rob-hp-laptop>
References: <cover.1525340143.git.hns@goldelico.com>
 <7c03df30ceec8b171ab88787c1ef9556c96b30f6.1525340143.git.hns@goldelico.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7c03df30ceec8b171ab88787c1ef9556c96b30f6.1525340143.git.hns@goldelico.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 03, 2018 at 11:35:46AM +0200, H. Nikolaus Schaller wrote:
> Introduce vendor prefix for Wi2Wi, Inc. for W2SG0004 GPS module
> and W2CBW003 Bluetooth/WiFi combo (CSR/Marvell).
> 
> Signed-off-by: H. Nikolaus Schaller <hns@goldelico.com>
> Acked-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.txt | 1 +
>  1 file changed, 1 insertion(+)

Applied this one so you don't have to keep sending it.

Rob
