Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754679AbeCVPWx (ORCPT <rfc822;w@1wt.eu>);
        Thu, 22 Mar 2018 11:22:53 -0400
Received: from Galois.linutronix.de ([146.0.238.70]:39522 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753268AbeCVPWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Mar 2018 11:22:50 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Joerg Roedel <joro@8bytes.org>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de, Scott Wood <swood@redhat.com>
Subject: [PATCH 00/10 v3] iommu/amd: lock splitting & GFP_KERNEL allocation
Date: Thu, 22 Mar 2018 16:22:32 +0100
Message-Id: <20180322152242.12705-1-bigeasy@linutronix.de>
X-Mailer: git-send-email 2.16.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is the rebase on top of iommu/x86/amd of my last series. It takes
Scotts comments into consideration from my v2.

It contains lock splitting and GFP_KERNEL allocation of remap-table.
Mostly cleanup.

The patches were boot tested on an AMD EPYC 7601.

Sebastian
