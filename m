Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751792AbeFDVMo (ORCPT <rfc822;w@1wt.eu>);
        Mon, 4 Jun 2018 17:12:44 -0400
Received: from mail-qk0-f196.google.com ([209.85.220.196]:36691 "EHLO
        mail-qk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751213AbeFDVMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jun 2018 17:12:43 -0400
X-Google-Smtp-Source: ADUXVKJEDVeNEvlVqDB/M0WJTcend34YwBYRPo+r0oUArhpPjkz+9s0/mMXsS8z6LfOMJniKsMSquA==
From: Florian Fainelli <f.fainelli@gmail.com>
To: bcm-kernel-feedback-list@broadcom.com,
        =?iso-8859-1?q?Cl=E9ment_P=E9ron?= <peron.clem@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Cc: Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
        Tony Lindgren <tony@atomide.com>, Laura Abbott <labbott@redhat.com>,
        Scott Branden <sbranden@broadcom.com>,
        Jon Mason <jonmason@broadcom.com>, Ray Jui <rjui@broadcom.com>,
        =?iso-8859-1?q?Cl=E9ment?= Peron <clement.peron@devialet.com>
Subject: Re: [PATCH v2 2/2] ARM: debug: fix BCM2836 order entry
Date: Mon,  4 Jun 2018 14:12:39 -0700
Message-Id: <20180604211239.20528-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
In-Reply-To: <20180530131956.13972-2-peron.clem@gmail.com>
References: <20180530131956.13972-1-peron.clem@gmail.com> <20180530131956.13972-2-peron.clem@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 30 May 2018 15:19:56 +0200, Clément Péron <peron.clem@gmail.com> wrote:
> From: Clément Peron <clement.peron@devialet.com>
> 
> Entries are sorted by their address value, except the BCM2836/KONA
> which are not in the proper order.
> 
> Signed-off-by: Clément Peron <clement.peron@devialet.com>
> ---

Applied to soc/next, thanks!
--
Florian
