Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965221AbeEIPrV (ORCPT <rfc822;w@1wt.eu>);
        Wed, 9 May 2018 11:47:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:58345 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S964907AbeEIPrT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 May 2018 11:47:19 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.49,382,1520924400";
   d="scan'208";a="39660950"
From: "Wang, Wei W" <wei.w.wang@intel.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
        "Liu, Jingqi" <jingqi.liu@intel.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>
CC: "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>, "hpa@zytor.com" <hpa@zytor.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] KVM: x86: Expose CLDEMOTE CPU feature to guest VM
Thread-Topic: [PATCH] KVM: x86: Expose CLDEMOTE CPU feature to guest VM
Thread-Index: AQHT4oTLOU3sQTG4s0eXcQx3kjuFvqQj9i6AgACgHgCAAjbjAIAAsqRw
Date: Wed, 9 May 2018 15:47:15 +0000
Message-ID: <286AC319A985734F985F78AFA26841F73952628B@SHSMSX101.ccr.corp.intel.com>
References: <1525406146-54791-1-git-send-email-jingqi.liu@intel.com>
 <a799d2b8-9d75-0969-a98f-be5d96314dbb@redhat.com>
 <09D68D4CF52CAF489B702DEBDD12D3D35269A68D@SHSMSX103.ccr.corp.intel.com>
 <a7b69935-8a91-2109-c3a2-e44fea3091fd@redhat.com>
In-Reply-To: <a7b69935-8a91-2109-c3a2-e44fea3091fd@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiMmIzZDFiZDktMjllMC00ZGZhLWIxZmMtYjI1ZmEwODg1NmY2IiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6ImY1K0NIQUdcL2FUQ3BnenBSTXU0OURqdzdKSzRcL3VlSGI3R2hrRkRtTjdNUT0ifQ==
x-ctpclassification: CTP_NT
dlp-product: dlpe-windows
dlp-version: 11.0.200.100
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 8bit
X-MIME-Autoconverted: from base64 to 8bit by mail.home.local id w49FlSFT019426

On Wednesday, May 9, 2018 7:52 PM, Paolo Bonzini wrote:
> On 08/05/2018 04:03, Liu, Jingqi wrote:
> > Hi Paolo,
> > Thanks.
> > Will you help to modify the Signed-off-by chain ?
> > Or do I need to submit the second version after modifying the Signed-off-
> by chain ?
> 
> Can you explain your role and Wei Wang's in the development of the patch?
> 

Hi Paolo,

Thanks for reviewing our patches.
Jingqi is the owner of the patches, I'm just an assistant. You could adjust the order or change mine to reviewed-by.

Best,
Wei
