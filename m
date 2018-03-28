Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752936AbeC1Nfp (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Mar 2018 09:35:45 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:43938 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750820AbeC1Nfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Mar 2018 09:35:44 -0400
From: Christoph Hellwig <hch@lst.de>
To: x86@kernel.org
Cc: Evgeniy Didin <Evgeniy.Didin@synopsys.com>,
        Sebastian Ott <sebott@linux.vnet.ibm.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: tip/x86/dma fix for arc and s390 (at least)
Date: Wed, 28 Mar 2018 15:35:34 +0200
Message-Id: <20180328133535.17302-1-hch@lst.de>
X-Mailer: git-send-email 2.14.2
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

this restores previous __GFP_ZERO passthrough behavior for now as arc and
s390 rely on it.  Needs more work to sort out the API mess in the long run.
