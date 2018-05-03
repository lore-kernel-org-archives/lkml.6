Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751392AbeECU3q (ORCPT <rfc822;w@1wt.eu>);
        Thu, 3 May 2018 16:29:46 -0400
Received: from mga06.intel.com ([134.134.136.31]:27353 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751186AbeECU3n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 May 2018 16:29:43 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,359,1520924400";
   d="scan'208";a="42892258"
From: "Keller, Jacob E" <jacob.e.keller@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        Ganesh Goudar <ganeshgr@chelsio.com>,
        "Michael Chan" <michael.chan@broadcom.com>,
        Ariel Elior <ariel.elior@cavium.com>
CC: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "everest-linux-l2@cavium.com" <everest-linux-l2@cavium.com>,
        "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Tal Gilboa <talgi@mellanox.com>, Tariq Toukan <tariqt@mellanox.com>,
        Jakub Kicinski <kubakici@wp.pl>
Subject: RE: [PATCH v6 0/5] PCI: Improve PCIe link status reporting
Thread-Topic: [PATCH v6 0/5] PCI: Improve PCIe link status reporting
Thread-Index: AQHT4xlbexgDzKxGmU+j7nULJQA9SaQedJCQ
Date: Thu, 3 May 2018 20:29:38 +0000
Message-ID: <02874ECE860811409154E81DA85FBB5882DBA48B@ORSMSX115.amr.corp.intel.com>
References: <152537719056.62474.2571390812509425478.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152537719056.62474.2571390812509425478.stgit@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiYTEwYjc1ZDctNWE0YS00YTc0LTg1NTktMTZlY2JmNWNkNTdiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6IkxsVlRLU1VxSkpBK1p5eVwvVTNZeTRwM25HVmVmd2R3SENSWDVVMUpwUStFPSJ9
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.22.254.138]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w43KTnu5026512

> -----Original Message-----
> This does change the dmesg reporting of link speeds, and in the ixgbe case,
> it changes the reporting from KERN_WARN level to KERN_INFO.  If that's an
> issue, let's talk about it.  I'm hoping the reduce code size, improved
> functionality, and consistency across drivers is enough to make this
> worthwhile.
> 

I personally have no issue with this change, but I don't work on the ixgbe driver much anymore.

Thanks,
Jake
