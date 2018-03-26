Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752747AbeCZWYu (ORCPT <rfc822;w@1wt.eu>);
        Mon, 26 Mar 2018 18:24:50 -0400
Received: from mail-oi0-f65.google.com ([209.85.218.65]:38233 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752701AbeCZWYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Mar 2018 18:24:46 -0400
X-Google-Smtp-Source: AG47ELvFQisSxQszsY4E/vlpyxre4hK/LuI37xSszXEJCo7Aq/cfPPpwrkrPTJ/9hTgc5Zvu+2RkYg==
Date: Mon, 26 Mar 2018 17:24:44 -0500
From: Rob Herring <robh@kernel.org>
To: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Tejun Heo <tj@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>, linux-ide@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ata: ahci-platform: add reset control support
Message-ID: <20180326222444.dclqhstvrfi6sanr@rob-hp-laptop>
References: <1521768653-11824-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521768653-11824-1-git-send-email-hayashi.kunihiko@socionext.com>
User-Agent: NeoMutt/20170609 (1.8.3)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 23, 2018 at 10:30:53AM +0900, Kunihiko Hayashi wrote:
> Add support to get and control a list of resets for the device
> as optional and shared. These resets must be kept de-asserted until
> the device is enabled.
> 
> This is specified as shared because some SoCs like UniPhier series
> have common reset controls with all ahci controller instances.
> 
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../devicetree/bindings/ata/ahci-platform.txt      |  1 +

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/ata/ahci.h                                 |  1 +
>  drivers/ata/libahci_platform.c                     | 24 +++++++++++++++++++---
>  3 files changed, 23 insertions(+), 3 deletions(-)
