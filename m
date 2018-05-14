Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932202AbeENN4S (ORCPT <rfc822;w@1wt.eu>);
        Mon, 14 May 2018 09:56:18 -0400
Received: from mail3.advaoptical.com ([74.202.24.82]:56552 "EHLO
        mail3.advaoptical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753435AbeENN4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 May 2018 09:56:16 -0400
From: Tim Shearer <TShearer@advaoptical.com>
To: Wanpeng Li <kernellwp@gmail.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
CC: LKML <linux-kernel@vger.kernel.org>, kvm <kvm@vger.kernel.org>,
        "Paolo Bonzini" <pbonzini@redhat.com>,
        =?utf-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>,
        Liran Alon <liran.alon@oracle.com>
Subject: RE: [PATCH 0/3] KVM: VMX: Allow to disable ioport intercept per-VM by
 userspace
Thread-Topic: [PATCH 0/3] KVM: VMX: Allow to disable ioport intercept per-VM
 by userspace
Thread-Index: AQHT1g9+PWMf5g7WBkaK0YvzIqSBF6QrE6qAgACdOACAA7Ca0A==
Date: Mon, 14 May 2018 13:48:41 +0000
Message-ID: <15cfb8d4b88c4eab84a474d32300118e@advaoptical.com>
References: <1523943962-25415-1-git-send-email-wanpengli@tencent.com>
 <20180511154019.GG27459@char.us.oracle.com>
 <CANRm+CwkeQTLSOAWDMz8J+Ng5e6FPWABE94wWLZ2vbYA15H1DA@mail.gmail.com>
In-Reply-To: <CANRm+CwkeQTLSOAWDMz8J+Ng5e6FPWABE94wWLZ2vbYA15H1DA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.16.5.40]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2018-05-14_03:,,
 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w4EDuMf4032402

> From: Wanpeng Li <kernellwp@gmail.com>
> Sent: Friday, May 11, 2018 9:03 PM
> 
> Yeah, both you and Liran give the original idea. :) Tim and Liran, any
> review for the patchset?
> 

> +Architectures: x86
> +Parameters: args[0] defines whether ioport intercept

Agree with Konrad that the flexibility of specifying the ioport via args[1] could be valuable, otherwise this looks good to me. Thank you!

Reviewed-by: Tim Shearer <tshearer@advaoptical.com>
