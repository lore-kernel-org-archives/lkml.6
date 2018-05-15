Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752877AbeEOSFg (ORCPT <rfc822;w@1wt.eu>);
        Tue, 15 May 2018 14:05:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:33852 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752178AbeEOSFf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 May 2018 14:05:35 -0400
From: Christoph Hellwig <hch@lst.de>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: swiotlb cleanup
Date: Tue, 15 May 2018 20:05:17 +0200
Message-Id: <20180515180523.3038-1-hch@lst.de>
X-Mailer: git-send-email 2.17.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Konrad,

below are a few swiotlb patches.  Mostly just cleanups, but the removal
of the panic option is an actual change in (rarely used) functionality.
