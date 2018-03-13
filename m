Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932372AbeCMWlu (ORCPT <rfc822;w@1wt.eu>);
        Tue, 13 Mar 2018 18:41:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:31794 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751300AbeCMWlt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Mar 2018 18:41:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.47,466,1515484800";
   d="scan'208";a="211277645"
From: "Luck, Tony" <tony.luck@intel.com>
To: Bjorn Helgaas <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
CC: Mikael Starvik <starvik@axis.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "David Howells" <dhowells@redhat.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>,
        "linux-cris-kernel@axis.com" <linux-cris-kernel@axis.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
        "linux-am33-list@redhat.com" <linux-am33-list@redhat.com>
Subject: RE: [PATCH] PCI/MSI: Don't set up INTx if MSI or MSI-X is enabled
Thread-Topic: [PATCH] PCI/MSI: Don't set up INTx if MSI or MSI-X is enabled
Thread-Index: AQHTuxSuMc0eXSM3JUS6bkBMcdsn4KPOwdiw
Date: Tue, 13 Mar 2018 22:41:44 +0000
Message-ID: <3908561D78D1C84285E8C5FCA982C28F7B39A76B@ORSMSX110.amr.corp.intel.com>
References: <152097754955.241946.9551793957889760940.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <152097754955.241946.9551793957889760940.stgit@bhelgaas-glaptop.roam.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiOTliOGIwYjItY2U0NS00ZTQ3LWE0MGUtNjFiNGM1NzVlM2NiIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE3LjIuNS4xOCIsIlRydXN0ZWRMYWJlbEhhc2giOiJMRzV2akIwNTJVdXU1QUdkTDFRNTUzZld2dGhSejBcL280b1FLSjJGbENCYzZRbys5SUM2U2xUTWo3ckxcL0RDa2wifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.22.254.139]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w2DMfub8002344

> Change the remaining arches (cris, frv, and ia64) to skip INTx setup when
> either MSI or MSI-X is enabled.

My ia64 still boots with this patch applied (and doesn't have any new/different messages
in the console log).  So:

Tested-by: Tony Luck <tony.luck@intel.com>

-Tony
