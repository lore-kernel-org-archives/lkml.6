Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752291AbeDRUQa (ORCPT <rfc822;w@1wt.eu>);
        Wed, 18 Apr 2018 16:16:30 -0400
Received: from mga06.intel.com ([134.134.136.31]:46606 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751407AbeDRUQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Apr 2018 16:16:29 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,466,1517904000";
   d="scan'208";a="38509696"
From: "Mehta, Sohil" <sohil.mehta@intel.com>
To: "shunyong.yang@hxt-semitech.com" <shunyong.yang@hxt-semitech.com>,
        "gary.hook@amd.com" <gary.hook@amd.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "ghook@amd.com" <ghook@amd.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
Thread-Topic: [PATCH v3 2/2] iommu/amd: Add basic debugfs infrastructure for
 AMD IOMMU
Thread-Index: AQHT04THDyVaDNNW7k6hYyQjJLsxvaQFs/wAgADO9QCAABkcAIAAEZYAgADFRIA=
Date: Wed, 18 Apr 2018 20:16:27 +0000
Message-ID: <1524082659.2747.37.camel@intel.com>
References: <152302042701.47565.17954813724758433858.stgit@sosxen2.amd.com>
         <152302067362.47565.628887796165116844.stgit@sosxen2.amd.com>
         <1523664612.2747.13.camel@intel.com>
         <efa2b7a3-04a7-20b1-3651-89ebafa85c27@amd.com>
         <1524031122.4031.5.camel@hxt-semitech.com>
         <1524036520.2747.31.camel@intel.com>
         <1524040290.4031.25.camel@hxt-semitech.com>
In-Reply-To: <1524040290.4031.25.camel@hxt-semitech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.25.110.4]
Content-Type: text/plain; charset="utf-8"
Content-ID: <3899D9E6BD7CE04EAE32C61B6F339008@intel.com>
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3IKGZfs029432

On Wed, 2018-04-18 at 08:31 +0000, Yang, Shunyong wrote:
> Maybe the original design is to call debugfs_initialized() before
> calling debugfs_create_xxx()?

I am unaware of the original design. Someone else would probably have
more context. However, looking at other places in the kernel where
debugfs_create_xx() is used, the common convention seems to be to avoid
calling debugfs_initialized().

 Sohil
