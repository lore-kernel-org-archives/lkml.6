Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754767AbeBATrF (ORCPT <rfc822;w@1wt.eu>);
        Thu, 1 Feb 2018 14:47:05 -0500
Received: from ms.lwn.net ([45.79.88.28]:42758 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752838AbeBATq7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Feb 2018 14:46:59 -0500
Date: Thu, 1 Feb 2018 12:46:57 -0700
From: Jonathan Corbet <corbet@lwn.net>
To: Corentin Labbe <clabbe@baylibre.com>
Cc: ralf@linux-mips.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org
Subject: Re: [PATCH] Documentation: mips: Update AU1xxx_IDE Kconfig
 dependencies
Message-ID: <20180201124657.5f9b3090@lwn.net>
In-Reply-To: <1517228467-1444-1-git-send-email-clabbe@baylibre.com>
References: <1517228467-1444-1-git-send-email-clabbe@baylibre.com>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 Jan 2018 12:21:07 +0000
Corentin Labbe <clabbe@baylibre.com> wrote:

> IDEDMA_AUTO IDEDMA_PCI_AUTO was removed in commit 120b9cfddff2 ("ide: remove CONFIG_IDEDMA_{ICS,PCI}_AUTO config")
> BLK_DEV_IDEDISK was removed in commit 806f80a6fc20 ("ide: add generic ATA/ATAPI disk driver")
> BLK_DEV_IDE_AU1XXX_BURSTABLE_ON was removed in commit 8f29e650bffc ("ide: AU1200 IDE update")
> Remove them from documentation

Applied to the docs tree, thanks.

jon
