Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752877AbeEOScY (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:32:24 -0400
Received: from muru.com ([72.249.23.125]:42312 "EHLO muru.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751099AbeEOScX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:32:23 -0400
Date: Tue, 15 May 2018 11:32:19 -0700
From: Tony Lindgren <tony@atomide.com>
To: Eyal Reizer <eyalreizer@gmail.com>
Cc: bcousson@baylibre.com, robh+dt@kernel.org, mark.rutland@arm.com,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, nsekhar@ti.com,
        Eyal Reizer <eyalr@ti.com>
Subject: Re: [PATCH v2] ARM: dts: am437x-sk-evm: add wilink8 support
Message-ID: <20180515183219.GA98604@atomide.com>
References: <1525593486-13028-1-git-send-email-eyalr@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525593486-13028-1-git-send-email-eyalr@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Eyal Reizer <eyalreizer@gmail.com> [180506 01:00]:
> enable mmc3 used for wlan and uart1 used for bluetooth
> configure the gpios used for wlan and bluetooth controls
> add fixed voltage regulator used for wlan power control

Applying into omap-for-v4.18/dt thanks.

Tony
