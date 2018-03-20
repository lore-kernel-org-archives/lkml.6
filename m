Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752524AbeCTKXH (ORCPT <rfc822;w@1wt.eu>);
        Tue, 20 Mar 2018 06:23:07 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:57800 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751681AbeCTKXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Mar 2018 06:23:05 -0400
Date: Tue, 20 Mar 2018 03:23:04 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Sinan Kaya <okaya@codeaurora.org>
Cc: linux-scsi@vger.kernel.org, timur@codeaurora.org,
        sulrich@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Adaptec OEM Raid Solutions <aacraid@adaptec.com>,
        "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 3/7] scsi: dpt_i2o: eliminate duplicate barriers on
 weakly-ordered archs
Message-ID: <20180320102304.GA21265@infradead.org>
References: <1521514207-10695-1-git-send-email-okaya@codeaurora.org>
 <1521514207-10695-4-git-send-email-okaya@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1521514207-10695-4-git-send-email-okaya@codeaurora.org>
User-Agent: Mutt/1.9.2 (2017-12-15)
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a basically unmaintained driver for historic hardware, and not the
right place for micro-optimizations.
