Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751442AbeCLWvX (ORCPT <rfc822;w@1wt.eu>);
        Mon, 12 Mar 2018 18:51:23 -0400
Received: from mail-qk0-f182.google.com ([209.85.220.182]:39876 "EHLO
        mail-qk0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751312AbeCLWvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Mar 2018 18:51:21 -0400
X-Google-Smtp-Source: AG47ELvjZZqZt2957rdftj8APXvfhjuvxY7vcwcWMSx0LA2vHBSZTvNoLjP4SswsDXmgIiys+LiUOw==
From: Florian Fainelli <f.fainelli@gmail.com>
To: bcm-kernel-feedback-list@broadcom.com,
        linux-arm-kernel@lists.infradead.org
Cc: andrew@lunn.ch, vivien.didelot@savoirfairelinux.com,
        Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Russell King <linux@armlinux.org.uk>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS"
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ARM: dts: NSP: Switch to port 8 for CPU port
Date: Mon, 12 Mar 2018 15:51:01 -0700
Message-Id: <20180312225101.14635-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180227204520.24122-1-f.fainelli@gmail.com>
References: <20180227204520.24122-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Feb 2018 12:45:19 -0800, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Now that we have added support for pre-pended Broadcom tags with commit
> 11606039604c ("net: dsa: b53: Support prepended Broadcom tags") we can
> switch all the Northstar Plus reference boards to use port 8 for the CPU
> port. This allows us to prepare room for supporting the Flow Accelerator
> 2 NAPT offload, and frees up port 5 to be made fully configurable for
> the modes that it supports: internal, SGMII, RGMII etc.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to devicetree/next, thanks!
--
Florian
