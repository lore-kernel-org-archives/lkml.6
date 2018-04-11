Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752598AbeDKBif convert rfc822-to-8bit (ORCPT <rfc822;w@1wt.eu>);
        Tue, 10 Apr 2018 21:38:35 -0400
Received: from mga04.intel.com ([192.55.52.120]:41088 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751946AbeDKBid (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Apr 2018 21:38:33 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.48,434,1517904000";
   d="scan'208";a="49783829"
From: "Tian, Kevin" <kevin.tian@intel.com>
To: "Liang, Cunming" <cunming.liang@intel.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
CC: "Duyck, Alexander H" <alexander.h.duyck@intel.com>,
        "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org"
        <virtualization@lists.linux-foundation.org>,
        "Wang, Xiao W" <xiao.w.wang@intel.com>,
        "ddutile@redhat.com" <ddutile@redhat.com>,
        "Tan, Jianfeng" <jianfeng.tan@intel.com>,
        "Wang, Zhihong" <zhihong.wang@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: RE: [virtio-dev] Re: [RFC] vhost: introduce mdev based hardware
        vhost backend
Thread-Topic: [virtio-dev] Re: [RFC] vhost: introduce mdev based hardware
        vhost backend
Thread-Index: AQHT0NeTBfYf0Rz3+EK0/QyAUusgkaP6yMCg
Date: Wed, 11 Apr 2018 01:38:29 +0000
Message-ID: <AADFC41AFE54684AB9EE6CBC0274A5D1910E3505@SHSMSX101.ccr.corp.intel.com>
References: <20180402152330.4158-1-tiwei.bie@intel.com>
        <622f4bd7-1249-5545-dc5a-5a92b64f5c26@redhat.com>
        <20180410045723.rftsb7l4l3ip2ioi@debian>
        <7ee31a12-a370-fc43-82a6-2235f598e970@redhat.com>
        <D0158A423229094DA7ABF71CF2FA0DA34E9222F4@SHSMSX104.ccr.corp.intel.com>
        <20180410163105-mutt-send-email-mst@kernel.org>
 <D0158A423229094DA7ABF71CF2FA0DA34E9226AF@SHSMSX104.ccr.corp.intel.com>
In-Reply-To: <D0158A423229094DA7ABF71CF2FA0DA34E9226AF@SHSMSX104.ccr.corp.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ctpclassification: CTP_NT
x-titus-metadata-40: eyJDYXRlZ29yeUxhYmVscyI6IiIsIk1ldGFkYXRhIjp7Im5zIjoiaHR0cDpcL1wvd3d3LnRpdHVzLmNvbVwvbnNcL0ludGVsMyIsImlkIjoiZTQ5OWYwMWUtMDUzMy00NDc2LTlhNDktMTIwZWVhYzZkMTBlIiwicHJvcHMiOlt7Im4iOiJDVFBDbGFzc2lmaWNhdGlvbiIsInZhbHMiOlt7InZhbHVlIjoiQ1RQX05UIn1dfV19LCJTdWJqZWN0TGFiZWxzIjpbXSwiVE1DVmVyc2lvbiI6IjE2LjUuOS4zIiwiVHJ1c3RlZExhYmVsSGFzaCI6IkxIZ0JtUExaK282RG5tYmsrN3d4MDE2NVVOeVpwY3hNOXRZTFZYUVo0ZGM9In0=
dlp-product: dlpe-windows
dlp-version: 11.0.0.116
dlp-reaction: no-action
x-originating-ip: [10.239.127.40]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Liang, Cunming
> Sent: Tuesday, April 10, 2018 10:24 PM
> 
[...]
> >
> > As others said, we do not need to go overeboard. A couple of small
> vendor-
> > specific quirks in qemu isn't a big deal.
> 
> It's quite challenge to identify it's small or not, there's no uniform metric.
> 
> It's only dependent on QEMU itself, that's the obvious benefit. Tradeoff is
> to build the entire device driver. We don't object to do that in QEMU, but
> wanna make sure to understand the boundary size clearly.
> 

It might be helpful if you can post some sample code using proposed 
framework - then people have a clear feeling about what size is talked 
about here and whether it falls into the concept of 'small quirks'.

Thanks
Kevin
