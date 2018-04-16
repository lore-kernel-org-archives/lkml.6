Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752319AbeDPOuS convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 10:50:18 -0400
Received: from mailout.micron.com ([137.201.242.129]:62164 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750799AbeDPOuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 10:50:13 -0400
From: "Bean Huo (beanhuo)" <beanhuo@micron.com>
To: Steven Rostedt <rostedt@goodmis.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhad.com" <mingo@redhad.com>,
        "Bart.VanAssche@sandisk.com" <Bart.VanAssche@sandisk.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Bean Huo (beanhuo)" <beanhuo@micron.com>,
        "rajatja@google.com" <rajatja@google.com>
Subject: [RESEND PATCH v1 0/2] Print the request tag in Block/SCSI trace
 events
Thread-Topic: [RESEND PATCH v1 0/2] Print the request tag in Block/SCSI trace
 events
Thread-Index: AdPVjlfjR8jlAiOoT8aZukcp5c3Myg==
Date: Mon, 16 Apr 2018 14:30:03 +0000
Message-ID: <7a9ea1426253406a91253a0501783c90@SIWEX5A.sing.micron.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.160.29.124]
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-23786.005
X-TM-AS-Result: No--7.569300-0.000000-31
X-TM-AS-MatchedID: 704421-707163-703788-707451-702150-708712-703491-187067-1
        05700-139705-703523-708440-851106-700016-148004-148050-148980-10019-41000-4
        2000-42003-29961-63
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
x-mt-checkinternalsenderrule: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches are to add the printout of the request tag in Block/SCSI trace
events when tracing one request or command, this is very useful for tracing
the task running status in the storage device which supports multiple command
queue.

As for the first patch " Add tag in SCSI trace events", copied from
Rajat Jain [1]. I am just re-sending here.
 
[1]https://patchwork.kernel.org/patch/6399661/

-- Resend since patches need to go through the block and SCSI subsystem, and need related
maintainer's confirmation.

Bean Huo (2):
  trace: events: scsi: Add tag in SCSI trace events
  trace: events: block: Add tag in block trace events

 include/trace/events/block.h | 36 +++++++++++++++++++++++++-----------
 include/trace/events/scsi.h  | 20 +++++++++++++-------
 2 files changed, 38 insertions(+), 18 deletions(-)

-- 
2.7.4
