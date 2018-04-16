Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753041AbeDPRIO (ORCPT <rfc822;w@1wt.eu>);
        Mon, 16 Apr 2018 13:08:14 -0400
Received: from mailout.micron.com ([137.201.242.129]:34977 "EHLO
        mailout.micron.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752652AbeDPRIM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Apr 2018 13:08:12 -0400
From: "Bean Huo (beanhuo)" <beanhuo@micron.com>
To: Bart Van Assche <Bart.VanAssche@wdc.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>,
        "rajatja@google.com" <rajatja@google.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "mingo@redhad.com" <mingo@redhad.com>,
        "jejb@linux.vnet.ibm.com" <jejb@linux.vnet.ibm.com>
Subject: Re: [RESEND PATCH v1 1/2] trace: events: scsi: Add tag in SCSI trace
 events
Thread-Topic: [RESEND PATCH v1 1/2] trace: events: scsi: Add tag in SCSI trace
 events
Thread-Index: AdPVpS/NqOtYca0xRKWV1f/VxYkLww==
Date: Mon, 16 Apr 2018 17:05:59 +0000
Message-ID: <b46de00ee67e4ec9955bb3f09faa36c4@SIWEX5A.sing.micron.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.160.29.124]
X-TM-AS-Product-Ver: SMEX-12.0.0.1782-8.200.1013-23786.005
X-TM-AS-Result: No--9.017400-0.000000-31
X-TM-AS-MatchedID: 150567-139010-700022-700075-851106-707163-707451-702931-7
        04425-707663-700023-704421-711432-702020-705901-148004-148046-148133-148980
        -10019-41000-42000-42003-29961-63
X-TM-AS-User-Approved-Sender: Yes
X-TM-AS-User-Blocked-Sender: No
x-mt-checkinternalsenderrule: True
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w3GH8JJk018692

Hi, Bart

>On Mon, 2018-04-16 at 09:41 -0700, Rajat Jain wrote:
>> On Mon, Apr 16, 2018 at 8:28 AM, Steven Rostedt <rostedt@goodmis.org>
>wrote:
>> > On Mon, 16 Apr 2018 14:31:49 +0000
>> > "Bean Huo (beanhuo)" <beanhuo@micron.com> wrote:
>> >
>> > > Print the request tag along with other information while tracing a
>> > > command.
>> > >
>> > > Signed-off-by: Bean Huo <beanhuo@micron.com>
>>
>> Acked-by: Rajat Jain <rajatja@google.com>
>
>This patch is not acceptable because it adds support for tag tracing to the
>legacy block layer only. Any patch that adds a new feature to the legacy block
>layer must also add it to blk-mq.
>
To be honest, I don't understand your point, can you give me more explanation?

>Bart.
>
>
