Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752332AbeERUpI (ORCPT <rfc822;w@1wt.eu>);
        Fri, 18 May 2018 16:45:08 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:40278 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751221AbeERUpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 May 2018 16:45:06 -0400
X-Google-Smtp-Source: AB8JxZqGUEWy7XgbXBBOlVE4cHBrYFwgxilOnB1cZdujxPgn6+FZY1dqAf4/MFgRnnBmuFWTlpuU7e7kZj/FC/51PHQ=
MIME-Version: 1.0
In-Reply-To: <MWHPR2101MB07297B07D495D66A1C9416FACE900@MWHPR2101MB0729.namprd21.prod.outlook.com>
References: <20180518002214.5657-1-longli@linuxonhyperv.com>
 <20180518002214.5657-10-longli@linuxonhyperv.com> <20180518072631.GA19250@infradead.org>
 <MWHPR2101MB07297B07D495D66A1C9416FACE900@MWHPR2101MB0729.namprd21.prod.outlook.com>
From: Steve French <smfrench@gmail.com>
Date: Fri, 18 May 2018 13:44:44 -0700
Message-ID: <CAH2r5mtzUJUakbPr_kzrDcqVPC9QuS7K8MXejNz7F=Uii6K5Kg@mail.gmail.com>
Subject: Re: [RFC PATCH 09/09] Introduce cache=rdma moutning option
To: Long Li <longli@microsoft.com>
Cc: Christoph Hellwig <hch@infradead.org>,
        Steve French <sfrench@samba.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 18, 2018 at 12:00 PM, Long Li via samba-technical
<samba-technical@lists.samba.org> wrote:
>> Subject: Re: [RFC PATCH 09/09] Introduce cache=rdma moutning option
>>
>> On Thu, May 17, 2018 at 05:22:14PM -0700, Long Li wrote:
>> > From: Long Li <longli@microsoft.com>
>> >
>> > When cache=rdma is enabled on mount options, CIFS do not allocate
>> > internal data buffer pages for I/O, data is read/writen directly to user
>> memory via RDMA.
>>
>> I don't think this should be an option.  For direct I/O without signing or
>> encryption CIFS should always use get_user_pages, with or without RDMA.
>
> Yes this should be done for all transport. If there are no objections, I'll send patches to change this.

Would this help/change performance much?



-- 
Thanks,

Steve
