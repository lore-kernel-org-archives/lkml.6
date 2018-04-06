Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752365AbeDFQHk (ORCPT <rfc822;w@1wt.eu>);
        Fri, 6 Apr 2018 12:07:40 -0400
Received: from mail-pl0-f52.google.com ([209.85.160.52]:45381 "EHLO
        mail-pl0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752081AbeDFQHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Apr 2018 12:07:37 -0400
X-Google-Smtp-Source: AIpwx49LEtjyda1nxkDu1SBlBfznDzg+N9bd+PloI+dr6RNmU3XAXIbOX+8kiMDMP5G2rfx6gCxIDg==
From: Florian Fainelli <f.fainelli@gmail.com>
To: bcm-kernel-feedback-list@broadcom.com, linux-kernel@vger.kernel.org
Cc: alex.aring@gmail.com, eric@anholt.net, ulf.hansson@linaro.org,
        khilman@kernel.org
Subject: Re: [PATCH] soc: bcm: raspberrypi-power: Fix use of __packed
Date: Fri,  6 Apr 2018 09:07:35 -0700
Message-Id: <20180406160735.30954-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20180401164225.8920-1-f.fainelli@gmail.com>
References: <20180401164225.8920-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  1 Apr 2018 09:42:25 -0700, Florian Fainelli <f.fainelli@gmail.com> wrote:
> Commit a09cd356586d ("ARM: bcm2835: add rpi power domain driver")
> attempted to annotate the structure rpi_power_domain_packet with
> __packed but introduced a typo and made it named __packet instead. Just
> drop the annotation since the structure is naturally aligned already.
> 
> Fixes: a09cd356586d ("ARM: bcm2835: add rpi power domain driver")
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---

Applied to drivers/fixes, thanks!
--
Florian
