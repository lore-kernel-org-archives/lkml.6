Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753268AbeDQML6 (ORCPT <rfc822;w@1wt.eu>);
        Tue, 17 Apr 2018 08:11:58 -0400
Received: from mailout.micron.com ([137.201.242.129]:51259 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752712AbeDQMLz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Apr 2018 08:11:55 -0400
From: "Bean Huo (beanhuo)" <beanhuo@micron.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "rajatja@google.com" <rajatja@google.com>
CC: "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mingo@redhad.com" <mingo@redhad.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>
Subject: Re: [RESEND PATCH v1 1/2] trace: events: scsi: Add tag in SCSI trace
 events
Thread-Topic: [RESEND PATCH v1 1/2] trace: events: scsi: Add tag in SCSI trace
 events
Thread-Index: AdPWROvYwC4lEZ3QTDCERkGhwBoFPg==
Date: Tue, 17 Apr 2018 12:09:26 +0000
Message-ID: <be6b85e181cd4894b89e1cd8ec0c0363@SIWEX5A.sing.micron.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.160.29.124]
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-23788.005
X-TM-AS-Result: No--15.342000-0.000000-31
X-TM-AS-MatchedID: 150567-139010-700022-851106-700075-701583-704421-704425-7
        07663-707163-709584-700133-703491-700107-702020-187067-105700-106230-705901
        -703747-700038-703283-148004-148046-148133-148980-41000-42000-42003-29961-63
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
x-mt-checkinternalsenderrule: True
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3HCCm0d011855

>On Mon, 2018-04-16 at 20:27 +0000, Bean Huo (beanhuo) wrote:
>> By the way, these patches are not to add new feature, they are just to
>> add print tag along with the other exist printed request parameters.
>
>Are you aware that there are two tag fields in struct request, namely "tag"
>and "internal_tag"? Are you aware that how these fields are used depends on
>whether or not a scheduler is attached to a request queue? Have you verified
>that the "tag" field contains a meaningful value for blk-mq for every blk-mq
>tracepoint?
>
>Thanks,
>
>Bart.
>
>
Yes, I noticed and was aware, there are tag and internal_tag.
One thing I was not aware is that the patches would make such a big impact on blk-mq based on
Your comments.

I am not expert on block layer, that is why I added block maintainer here.
Please point out which line and what is problem? If there is some wrong with the patch.
Which one is correct "tag" to track request? 

Thanks,
//Bean Huo
