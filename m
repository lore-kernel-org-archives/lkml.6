Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753375AbeDLVjw (ORCPT <rfc822;w@1wt.eu>);
        Thu, 12 Apr 2018 17:39:52 -0400
Received: from mga02.intel.com ([134.134.136.20]:50492 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752846AbeDLVjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Apr 2018 17:39:51 -0400
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,443,1517904000";
   d="scan'208";a="32261107"
Date: Thu, 12 Apr 2018 15:40:48 -0600
From: Keith Busch <keith.busch@intel.com>
To: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Micah Parrish <micah.parrish@hpe.com>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org, pragyansri.pathi@intel.com,
        jeffrey.wang@seagate.com, Kieulien.Dang@seagate.com
Subject: Re: [PATCH] NVMe: Add Quirk Delay before CHK RDY for Seagate Nytro
 Flash Storage
Message-ID: <20180412214047.GC6424@localhost.localdomain>
References: <1523561125-31945-1-git-send-email-micah.parrish@hpe.com>
 <yq1r2nkunbh.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq1r2nkunbh.fsf@oracle.com>
User-Agent: Mutt/1.9.1 (2017-09-22)
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, applied for 4.17-rc1.

I was a little surprised git was able to apply this since the patch
format is off, but it worked!
