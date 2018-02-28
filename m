Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932750AbeB1Qpo (ORCPT <rfc822;w@1wt.eu>);
        Wed, 28 Feb 2018 11:45:44 -0500
Received: from verein.lst.de ([213.95.11.211]:54456 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753126AbeB1Qpm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Feb 2018 11:45:42 -0500
Date: Wed, 28 Feb 2018 17:45:41 +0100
From: Christoph Hellwig <hch@lst.de>
To: Baegjae Sung <baegjae@gmail.com>
Cc: keith.busch@intel.com, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] nvme-multipath: fix sysfs dangerously created links
Message-ID: <20180228164541.GA16536@lst.de>
References: <20180228070604.25868-1-baegjae@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180228070604.25868-1-baegjae@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Looks fine,

Reviewed-by: Christoph Hellwig <hch@lst.de>
