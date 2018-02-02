Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752212AbeBBQKd (ORCPT <rfc822;w@1wt.eu>);
        Fri, 2 Feb 2018 11:10:33 -0500
Received: from mail-qt0-f195.google.com ([209.85.216.195]:42390 "EHLO
        mail-qt0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751844AbeBBQKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Feb 2018 11:10:25 -0500
X-Google-Smtp-Source: AH8x227MRzxqFsdDkwSy5eUfOkbRZOnUMbej0KTAnlR6js1AltLKW32dxCzS4aBbCRKO0D1hs4H/lTZavoJ35cuWMFQ=
MIME-Version: 1.0
X-Originating-IP: [176.63.54.97]
In-Reply-To: <1517585624.3171.64.camel@linux.vnet.ibm.com>
References: <cover.1517314847.git.dongsu@kinvolk.io> <86832c6adb256f29f44b6229222b80964fc8cfcc.1517314847.git.dongsu@kinvolk.io>
 <1517584816.3171.61.camel@linux.vnet.ibm.com> <1517585624.3171.64.camel@linux.vnet.ibm.com>
From: Miklos Szeredi <miklos@szeredi.hu>
Date: Fri, 2 Feb 2018 17:10:24 +0100
Message-ID: <CAJfpegvt5W-q0W8_VRML-MNW6+n2ZQYW+51utRXDDKSbvsqf3w@mail.gmail.com>
Subject: Re: [RFC PATCH v4 1/2] fuse: introduce new fs_type flag FS_IMA_NO_CACHE
To: Mimi Zohar <zohar@linux.vnet.ibm.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-integrity@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Alban Crequy <alban@kinvolk.io>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        Seth Forshee <seth.forshee@canonical.com>,
        Dongsu Park <dongsu@kinvolk.io>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 2, 2018 at 4:33 PM, Mimi Zohar <zohar@linux.vnet.ibm.com> wrote:
> On Fri, 2018-02-02 at 10:20 -0500, Mimi Zohar wrote:
>> Hi Miklos,
>>
>> On Tue, 2018-01-30 at 19:06 +0100, Dongsu Park wrote:
>> > From: Alban Crequy <alban@kinvolk.io>
>> >
>> > This new fs_type flag FS_IMA_NO_CACHE means files should be re-measured,
>> > re-appraised and re-audited each time. Cached integrity results should
>> > not be used.
>> >
>> > It is useful in FUSE because the userspace FUSE process can change the
>> > underlying files at any time without notifying the kernel.

I don't really have an understanding what IMA is doing, I think the
same thing applies to any network filesystem (i.e. ones with
d_revalidate).

Isn't that the case?

Thanks,
Miklos
