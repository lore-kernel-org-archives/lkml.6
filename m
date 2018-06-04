Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751780AbeFDVMc (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 17:12:32 -0400
Received: from mail-qk0-f193.google.com ([209.85.220.193]:40422 "EHLO
        mail-qk0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751285AbeFDVMb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 17:12:31 -0400
X-Google-Smtp-Source: ADUXVKLfd/jyeCrsThcooNVfyPBbdt6YOn9W8Jeo2n6oQoR4Mdl8p2S1x3ZWBYbsdG0/32dv41Uf5w==
From: Florian Fainelli <f.fainelli@gmail.com>
To: bcm-kernel-feedback-list@broadcom.com,
        =?iso-8859-1?q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>, Laura Abbott <labbott@redhat.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        =?iso-8859-1?q?Cl=E9ment?= Peron <clement.peron@devialet.com>
Subject: Re: [PATCH v2 1/2] ARM: debug: Add Iproc UART3 debug addresses
Date: Mon,  4 Jun 2018 14:12:27 -0700
Message-Id: <20180604211227.20438-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
In-Reply-To: <20180530131956.13972-1-peron.clem@gmail.com>
References: <20180530131956.13972-1-peron.clem@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2018 15:19:55 +0200, Clément Péron <peron.clem@gmail.com> wrote:
> From: Clément Peron <clement.peron@devialet.com>
> 
> Broadcom Iproc SoCs typically use the UART3 for
> debug/console, provide a known good location for that.
> 
> Signed-off-by: Clément Peron <clement.peron@devialet.com>
> ---

Applied to soc/next, thanks!
--
Florian
